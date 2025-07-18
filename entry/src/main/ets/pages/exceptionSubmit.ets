import router from '@ohos.router';
import { MapComponent, mapCommon, map } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';

@Entry
@Component
struct ExceptionSubmit {
  @State message: string = 'Hello World';
  @State isShow: boolean = true;
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  private mapOptions?: mapCommon.MapOptions;
  private callback?: AsyncCallback<map.MapComponentController>;
  private mapController?: map.MapComponentController;



  aboutToAppear(): void {

    let target: mapCommon.LatLng = {
      latitude: 39.9181,
      longitude: 116.3970193
    }
    let cameraPosition: mapCommon.CameraPosition = {
      target: target,
      zoom: 15
    }
    this.mapOptions = {
      position: cameraPosition
    }

    // 地图初始化的回调
    this.callback = async (err, mapController) => {
      if (!err) {
        this.mapController = mapController;
        // 初始化marker（标记）参数
        let markerOptions: mapCommon.MarkerOptions = {
          position: {
            latitude: 39.9181,
            longitude: 116.3970193
          }
        };
        // 新建一个默认的marker图标
        await this.mapController?.addMarker(markerOptions);
      }
    }
  }

  @Builder
  mysheet() {
    Column({ space: 12 }) { // 调整间距更舒展
      // 标题行：加大字号、加粗，和设计稿对齐
      Text("问题调研上报")
        .fontSize(18) // 原 35 太大，调小贴近设计
        .fontWeight(FontWeight.Bold) // 明确加粗
        .width('100%')
        .textAlign(TextAlign.Start);

      // 地址行：替换为目标文字，调整图标、文字布局
      Row() {
        Text('四川省内江市汉安大道925号') // 替换“这里有个地址”为设计稿文字
          .fontSize(14)
          .flexGrow(1);
        Row({ space: 4 }) {
          Image($r('app.media.position'))
            .width(16) // 适当放大图标
            .height(16)
          Text('更改位置') // 改“更改地址”为“更改位置”
            .fontSize(14)
            .fontColor('#409EFF') // 用更醒目的蓝色，贴近设计稿
            .onClick(() => {
              // 可扩展地址修改逻辑，比如唤起地图选择
              console.log('点击更改位置');
            });
        }
      }
      .width('100%')
      .padding({ bottom: 8 }) // 底部加间距，和下部分分隔

      // 详情描述标题
      Text('详情描述')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ bottom: 4 });

      // 输入框：调整 placeholder 文字
      TextInput({ placeholder: '请输入情况描述' })
        .onChange((val: string) => {
          this.message = val;
        })
        .height(120) // 适度调整高度
        .width('100%')
        .backgroundColor('#f5f5f5')
        .border({ width: 1, color: Color.Gray, radius: 8 })
        .padding(10)
        .fontSize(14);

      // 上传照片区域：调整标题 + 相机图标布局
      Text('上传照片')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ top: 8, bottom: 4 });
      Row() {
        Image($r('app.media.camera'))
          .width(24) // 放大相机图标
          .height(24)
          .onClick(() => {
            // 可扩展调用相机逻辑
            console.log('点击上传照片');
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.Start); // 让相机图标居中

      // 新增“立即上报”按钮
      Button('立即上报')
        .width('100%')
        .height(44)
        .backgroundColor('#409EFF')
        .fontColor(Color.White)
        .borderRadius(8)
        .margin({ top: 12 }) // 和上方内容分隔
        .onClick(() => {
          // 可扩展提交逻辑：如校验输入、调用接口等
          console.log('点击立即上报，内容：', this.message);
        });
    }
    .width('100%')
    .padding(16); // 整体加内边距，避免内容贴边
  }
  build() {
    Stack(){

      Column(){

        MapComponent({ mapOptions: this.mapOptions, mapCallback: this.callback }).width('100%').height('100%');
        Row({space:4}){

          Text('<')
            .fontSize(40)
            .height(40)
            .onClick(() => router.back())

          Search({placeholder: '搜地点 搜路线'})
            .height(40)
            .width(360)

        }
        .width('95%')
        .position({ top: 5 ,left:10})

      }
      .bindSheet(this.isShow,this.mysheet(),{height:SheetSize.FIT_CONTENT,showClose:false})

    }
    .width('100%')
    .height('100%')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }
}