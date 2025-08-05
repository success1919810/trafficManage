import router from '@ohos.router';
import { getCurrentUser, getToken } from '../../utils/TokenUtils';
import { errorSubmitService } from '../../utils/ErrorSubmitService';
import promptAction from '@ohos.promptAction';
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs';
import http from '@ohos.net.http';

// 获取工单详情的接口
interface MyReportCardDetailVO {
  id: number;
  location: string;
  equipmentId: string;
  equipmentType: string;
  responsiblePerson: string;
  contactPhone: string;
  faultType: string;
  faultDescription: string;
  faultImages: string[];
}

interface ApiResponse {
  code: number;
  msg: string;
  data: MyReportCardDetailVO;
}

interface UploadResponse {
  code: number;
  msg: string;
  data: string;
}

interface UpdateWorkOrderDTO {
  id: number;
  equipmentId: string;
  reporterName: string;
  reportTime: string;
  faultType: string;
  faultDescription: string;
  faultImages: string[];
}

interface RouterParams {
  orderId: number;
  reporterName: string;
}

@Entry
@Component
struct EditWorkOrder {
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;
  private faultTypeController: TextInputController = new TextInputController();
  @State refreshKey: number = 0;

  // 路由参数
  @State orderId: number = 0;

  // 表单数据
  @State equipmentId: string = '';
  @State equipmentCode: string = '';
  @State equipmentType: string = '';
  @State location: string = '';
  @State responsiblePerson: string = '';
  @State contactPhone: string = '';
  @State reporterName: string = '';
  @State faultType: string = '';
  @State faultDescription: string = '';
  @State faultImages: string[] = [];

  // UI状态
  @State isLoading: boolean = false;
  @State isSubmitting: boolean = false;
  @State isUploadingImage: boolean = false;

  aboutToAppear() {
    // 获取路由参数
    const params = router.getParams() as RouterParams;
    if (params) {
      this.orderId = params.orderId || 0;
      this.reporterName = params.reporterName || getCurrentUser();
    }

    if (this.orderId > 0) {
      this.fetchWorkOrderDetail();
    }
  }

  // 获取工单详情
  async fetchWorkOrderDetail() {
    this.isLoading = true;
    try {
      const context = getContext(this);
      const result = await errorSubmitService<ApiResponse>(
        `http://26.120.165.93:8080/errorSubmit/getDetails?id=${this.orderId}`,
        context
      );

      if (result.code === 200) {
        const detail = result.data;
        this.equipmentId = detail.equipmentId;
        this.equipmentCode = detail.equipmentId; // 假设equipmentId就是设备编号
        this.equipmentType = detail.equipmentType;
        this.location = detail.location;
        this.responsiblePerson = detail.responsiblePerson;
        this.contactPhone = detail.contactPhone;
        this.faultType = detail.faultType;
        this.faultDescription = detail.faultDescription;
        this.faultImages = detail.faultImages || [];

        promptAction.showToast({ message: '工单详情加载成功' });
      } else {
        promptAction.showToast({ message: result.msg || '获取工单详情失败' });
        router.back();
      }
    } catch (error) {
      console.error('获取工单详情失败:', error);
      promptAction.showToast({ message: '网络请求失败' });
      router.back();
    } finally {
      this.isLoading = false;
    }
  }

  // 从相册选择并上传图片
  async addImage() {
    if (this.faultImages.length >= 3) {
      promptAction.showToast({ message: '最多只能添加3张图片' });
      return;
    }

    if (this.isUploadingImage) {
      promptAction.showToast({ message: '正在上传图片，请稍候' });
      return;
    }

    try {
      // 调用相册选择图片
      const photoSelectOptions = new picker.PhotoSelectOptions();
      photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      photoSelectOptions.maxSelectNumber = 1;

      const photoPicker = new picker.PhotoViewPicker();
      const photoSelectResult = await photoPicker.select(photoSelectOptions);

      if (photoSelectResult && photoSelectResult.photoUris.length > 0) {
        const imageUri = photoSelectResult.photoUris[0];

        // 上传图片到OSS
        const imageUrl = await this.uploadImageToOSS(imageUri);
        if (imageUrl) {
          this.faultImages.push(imageUrl);
          promptAction.showToast({ message: '图片添加成功' });
        }
      }
    } catch (error) {
      console.error('选择图片失败:', error);
      promptAction.showToast({ message: '选择图片失败' });
    }
  }

  async uploadImageToOSS(imageUri: string): Promise<string | null> {
    this.isUploadingImage = true;
    try {
      promptAction.showToast({ message: `开始处理图片: ${imageUri}` });

      // 获取应用上下文和临时目录
      const context = getContext(this);
      const tempDir = context.tempDir;
      const fileName = `temp_image_${Date.now()}.jpg`;
      const tempFilePath = `${tempDir}/${fileName}`;

      // 复制图片到临时目录
      const sourceFile = fs.openSync(imageUri, fs.OpenMode.READ_ONLY);
      const destFile = fs.openSync(tempFilePath, fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY);

      const stat = fs.statSync(sourceFile.fd);
      const buffer = new ArrayBuffer(stat.size);
      const readBytes = fs.readSync(sourceFile.fd, buffer);
      fs.writeSync(destFile.fd, buffer);

      fs.closeSync(sourceFile);
      fs.closeSync(destFile);

      promptAction.showToast({ message: `图片复制成功，读取了${readBytes}字节` });

      // 重新打开临时文件读取数据
      const uploadFile = fs.openSync(tempFilePath, fs.OpenMode.READ_ONLY);
      const uploadStat = fs.statSync(uploadFile.fd);
      const imageData = new ArrayBuffer(uploadStat.size);
      const uploadReadBytes = fs.readSync(uploadFile.fd, imageData);
      fs.closeSync(uploadFile);

      promptAction.showToast({ message: `准备上传${uploadReadBytes}字节数据` });

      const httpRequest = http.createHttp();
      const token = await getToken(context);

      return new Promise<string | null>((resolve, reject) => {
        httpRequest.request('http://26.120.165.93:8080/upload', {
          method: http.RequestMethod.POST,
          header: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'multipart/form-data'
          },
          multiFormDataList: [
            {
              name: 'file',
              contentType: 'image/jpeg',
              remoteFileName: `fault_${Date.now()}.jpg`,
              data: imageData
            }
          ]
        }, (err, data) => {
          httpRequest.destroy();

          // 清理临时文件
          try {
            fs.unlinkSync(tempFilePath);
          } catch (e) {
            console.log('清理临时文件失败:', e);
          }

          if (err) {
            promptAction.showToast({ message: `网络错误: ${JSON.stringify(err)}` });
            resolve(null);
            return;
          }

          try {
            const result = JSON.parse(data.result.toString()) as UploadResponse;
            if (result.code === 200) {
              promptAction.showToast({ message: '上传成功!' });
              resolve(result.data);
            } else {
              promptAction.showToast({ message: `服务器错误: ${result.msg}` });
              resolve(null);
            }
          } catch (parseError) {
            promptAction.showToast({ message: `解析响应失败: ${parseError}` });
            resolve(null);
          }
        });
      });
    } catch (error) {
      promptAction.showToast({ message: `处理图片失败: ${error}` });
      return null;
    } finally {
      this.isUploadingImage = false;
    }
  }

  // 删除图片
  removeImage(index: number) {
    this.faultImages.splice(index, 1);
  }

  // 提交修改
  async submitWorkOrder() {
    // 表单验证
    if (!this.faultType.trim()) {
      promptAction.showToast({ message: '请输入故障类型' });
      return;
    }

    if (!this.faultDescription.trim()) {
      promptAction.showToast({ message: '请输入故障描述' });
      return;
    }

    this.isSubmitting = true;
    try {
      const context = getContext(this);

      // 生成新的报修时间
      const now = new Date();
      const reportTime = now.getFullYear() + '-' +
      String(now.getMonth() + 1).padStart(2, '0') + '-' +
      String(now.getDate()).padStart(2, '0') + ' ' +
      String(now.getHours()).padStart(2, '0') + ':' +
      String(now.getMinutes()).padStart(2, '0') + ':' +
      String(now.getSeconds()).padStart(2, '0');

      const updateData: UpdateWorkOrderDTO = {
        id: this.orderId,
        equipmentId: this.equipmentId,
        reporterName: this.reporterName,
        reportTime: reportTime,
        faultType: this.faultType,
        faultDescription: this.faultDescription,
        faultImages: this.faultImages
      };

      promptAction.showToast({ message: `时间格式: ${reportTime}` });

      const httpRequest = http.createHttp();
      const token = await getToken(context);

      const response = await httpRequest.request('http://26.195.0.245:8080/errorSubmit/updateOrder', {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        extraData: JSON.stringify(updateData)
      });

      const result = JSON.parse(response.result.toString()) as ApiResponse;
      httpRequest.destroy();

      if (result.code === 200) {
        promptAction.showToast({ message: '工单修改成功' });
        router.back();
      } else {
        promptAction.showToast({ message: result.msg || '修改失败' });
      }
    } catch (error) {
      console.error('修改工单失败:', error);
      promptAction.showToast({ message: '网络请求失败' });
    } finally {
      this.isSubmitting = false;
    }
  }

  // 信息项构建器
  @Builder
  InfoItem(label: string, getValue: () => string, isEditable: boolean = false, placeholder: string = '') {
    Column() {
      Row() {
        Text(label)
          .fontSize(16)
          .fontColor('#333333')
          .width(100);

        if (isEditable) {
          TextInput({ placeholder: placeholder, text: getValue() })
            .layoutWeight(1)
            .height(40)
            .backgroundColor('#f8f8f8')
            .borderRadius(4)
            .onChange((val: string) => {
              if (label === '故障类型') this.faultType = val;
            });
        } else {
          Text(getValue() || '--')
            .fontSize(16)
            .fontColor('#666666')
            .layoutWeight(1)
            .textAlign(TextAlign.End);
        }
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 15, bottom: 15 });

      Divider()
        .color('#f0f0f0')
        .strokeWidth(1);
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(30)
          .fontColor('#000000')
          .onClick(() => router.back());

        Text('修改工单')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Text(this.isSubmitting ? '提交中...' : '提交')
          .fontSize(16)
          .fontColor(this.isSubmitting ? '#cccccc' : '#0099ff')
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .border({ width: 1, color: this.isSubmitting ? '#cccccc' : '#0099ff', radius: 4 })
          .onClick(() => {
            if (!this.isSubmitting) {
              this.submitWorkOrder();
            }
          });
      }
      .width('100%')
      .height(60)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#ffffff')
      .alignItems(VerticalAlign.Center);

      if (this.isLoading) {
        // 加载状态
        Column() {
          LoadingProgress()
            .width(50)
            .height(50);
          Text('加载中...')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 10 });
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center);
      } else {
        // 滚动内容
        Scroll() {
          Column() {
            // 设备信息（只读）
            this.InfoItem('设备编号', () => this.equipmentCode);
            this.InfoItem('设备类型', () => this.equipmentType);
            this.InfoItem('设备位置', () => this.location);
            this.InfoItem('设备负责人', () => this.responsiblePerson);
            this.InfoItem('联系电话', () => this.contactPhone);
            this.InfoItem('报修人', () => this.reporterName);

            // 故障信息（可编辑）
            this.InfoItem('故障类型', () => this.faultType, true, '请输入故障类型');

            // 故障描述
            Column() {
              Row() {
                Text('故障描述')
                  .fontSize(16)
                  .fontColor('#333333');
              }
              .width('100%')
              .padding({ left: 20, right: 20, top: 15, bottom: 8 });

              TextArea({ placeholder: '请详细描述故障情况...', text: this.faultDescription })
                .width('90%')
                .height(120)
                .backgroundColor('#f8f8f8')
                .borderRadius(4)
                .fontSize(16)
                .onChange((val: string) => {
                  this.faultDescription = val;
                });

              Divider()
                .color('#f0f0f0')
                .strokeWidth(1)
                .margin({ top: 15 });
            }

            // 故障照片
            Column() {
              Row() {
                Text('故障照片')
                  .fontSize(16)
                  .fontColor('#333333');

                Text(`(${this.faultImages.length}/3)`)
                  .fontSize(14)
                  .fontColor('#999999')
                  .margin({ left: 10 });
              }
              .width('100%')
              .padding({ left: 20, right: 20, top: 15, bottom: 15 });

              // 图片展示区域
              Row({ space: 10 }) {
                ForEach(this.faultImages, (image: string, index: number) => {
                  Stack() {
                    Image(image)
                      .width(80)
                      .height(80)
                      .objectFit(ImageFit.Cover)
                      .borderRadius(8)
                      .backgroundColor('#f0f0f0');

                    // 删除按钮
                    Text('×')
                      .fontSize(20)
                      .fontColor('#ffffff')
                      .backgroundColor('#ff4444')
                      .width(24)
                      .height(24)
                      .borderRadius(12)
                      .textAlign(TextAlign.Center)
                      .position({ x: 60, y: -4 })
                      .onClick(() => {
                        this.removeImage(index);
                      });
                  }
                });

                // 添加图片按钮
                if (this.faultImages.length < 3) {
                  Column() {
                    if (this.isUploadingImage) {
                      Text('上传中...')
                        .fontSize(12)
                        .fontColor('#999999');
                    } else {
                      Text('+')
                        .fontSize(30)
                        .fontColor('#cccccc');
                    }
                  }
                  .width(80)
                  .height(80)
                  .backgroundColor(this.isUploadingImage ? '#f0f0f0' : '#f8f8f8')
                  .borderRadius(8)
                  .border({ width: 1, color: '#e0e0e0', style: BorderStyle.Dashed })
                  .justifyContent(FlexAlign.Center)
                  .onClick(() => {
                    if (!this.isUploadingImage) {
                      this.addImage();
                    }
                  });
                }
              }
              .width('100%')
              .padding({ left: 20, right: 20, bottom: 20 });
            }
          }
        }
        .layoutWeight(1)
        .backgroundColor('#ffffff');
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f2f2f2')
    .padding({
      top: px2vp(this.topRectHeight),
      bottom: px2vp(this.bottomRectHeight)
    });
  }
}