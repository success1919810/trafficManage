import router from '@ohos.router';
import {WorkOrderItem} from '../../utils/ErrorSubmitType'

@Entry
@Component
struct Gongdanxingxi {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @State
  orderData:WorkOrderItem={} as WorkOrderItem
  aboutToAppear() {
    const params = router.getParams() as Record<string, WorkOrderItem>;
    if (params && typeof params.orderData === 'object') {
      this.orderData = params.orderData as WorkOrderItem;
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(30)
          .fontColor('#000000')
          .borderRadius(5)
          .padding({ left: 10, right: 10 })
          .onClick(() => router.back());

        Text('工单信息')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000');
        Row().width(40)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 15, right: 15 })

      // 滚动内容
      Scroll() {
        Column() {
          // 工单信息项
          this.InfoItem('工单编号', this.orderData.orderNo)
          this.InfoItem('设备类型', this.orderData.equipmentType+this.orderData.equipmentCode)
          this.InfoItem('设备位置', this.orderData.location)
          this.InfoItem('设备负责人', this.orderData.responsiblePerson)
          this.InfoItem('联系电话', this.orderData.contactPhone)
          this.InfoItem('报修人', this.orderData.reporterName)
          this.InfoItem('报修时间', this.orderData.reportTime)
          this.InfoItem('工单状态', this.orderData.status)
          this.InfoItem('故障类型', this.orderData.faultType)

          // 故障描述
          Column() {
            Row() {
              Text('故障描述')
                .fontSize(16)
                .fontColor('#333333')
              Blank()
            }
            .width('100%')
            .margin({ bottom: 8 })

            Text('设备突然掉线，重启后仍无法正常使用。')
              .fontSize(14)
              .fontColor('#666666')
              .textAlign(TextAlign.Start)
              .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: 20, right: 20, top: 15, bottom: 15 })

          // 故障照片
          Column() {
            Row() {
              Text('故障照片')
                .fontSize(16)
                .fontColor('#333333')
              Blank()
            }
            .width('100%')
            .margin({ bottom: 15 })

            Row() {
              ForEach(this.orderData.faultImages ?? [], (item: string, index: number) => {
                Column() {
                  Image(item) // 正确加载网络图片
                    .width(80)
                    .height(80)
                    .objectFit(ImageFit.Cover)
                    .borderRadius(8)
                }
                .margin({ right: index < (this.orderData.faultImages.length - 1) ? 15 : 0 })
              })
            }
            .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: 20, right: 20, top: 15, bottom: 15 })

          // 新增的信息项
          this.InfoItem('运维人员', this.orderData.maintenancePerson)
          this.InfoItem('处理时间', this.orderData.processTime)
          this.InfoItem('完成时间', this.orderData.completeTime)

          // 现场照片
          Column() {
            Row() {
              Text('现场照片')
                .fontSize(16)
                .fontColor('#333333')
              Blank()
            }
            .width('100%')
            .margin({ bottom: 15 })

            Row() {
              ForEach(this.orderData.sceneImages ?? [], (item: string, index: number) => {
                Column() {
                  Image(item) // 正确加载网络图片
                    .width(80)
                    .height(80)
                    .objectFit(ImageFit.Cover)
                    .borderRadius(8)
                }
                .margin({ right: index < (this.orderData.faultImages.length - 1) ? 15 : 0 })
              })
            }
            .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: 20, right: 20, top: 15, bottom: 15 })

        }
      }
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .margin({ top: 10 })

      // 底部评价按钮
      Button('评价')
        .width('90%')
        .height(45)
        .backgroundColor('#4FC3F7')
        .fontColor('#FFFFFF')
        .fontSize(18)
        .borderRadius(8)
        .margin({ top: 15, bottom: 15 })
        .onClick(() => {
          // 跳转到评价页面或显示评价弹窗
          router.pushUrl({ url: 'pages/gongdanpingjia' })
        })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }

  @Builder
  InfoItem(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(16)
        .fontColor('#333333')
        .width(80)

      Blank()

      Text(value)
        .fontSize(16)
        .fontColor('#666666')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .height(50)
    .padding({ left: 20, right: 20 })
    .border({
      width: { bottom: 0.5 },
      color: '#E5E5E5'
    })
  }
}