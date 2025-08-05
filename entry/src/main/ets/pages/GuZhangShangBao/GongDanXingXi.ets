import router from '@ohos.router';
import {WorkOrderItem,ApiResponse} from "../../utils/ErrorSubmitType"
import {getCurrentUser} from  "../../utils/TokenUtils"
import { promptAction} from '@kit.ArkUI';
import { errorSubmitService} from "../../utils/ErrorSubmitService"

interface ResponseData{
  code:number
  msg:string
  data:object
}
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

      // 工单详情内容
      Column() {
        // 工单信息项
        this.InfoItem('工单编号',this.orderData.orderNo )
        this.InfoItem('设备类型', this.orderData.equipmentCode+this.orderData.equipmentType)
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
        // 登录按钮
        Button('工单承接')
          .width('90%')
          .height(50)
          .borderRadius(10)
          .margin({ top: 50 })
          .onClick(() => {
            try{
              const context = getContext()
              const currentUser = getCurrentUser();
              const now = new Date();
              const reportTime = now.getFullYear() + '-' +
              String(now.getMonth() + 1).padStart(2, '0') + '-' +
              String(now.getDate()).padStart(2, '0') + ' ' +
              String(now.getHours()).padStart(2, '0') + ':' +
              String(now.getMinutes()).padStart(2, '0') + ':' +
              String(now.getSeconds()).padStart(2, '0');
              if (!currentUser) {
                promptAction.showToast({ message: '请先登录' });
                return;
              }
              const result = await errorSubmitService<ResponseData>(
                `http://26.120.165.93:8080/orders/status?taker=${encodeURIComponent(currentUser)}`,//url需要完善
                context
              );
              if(result.code===200){
                promptAction.showToast({message:"你已经成功接单，请注意"})
              }
            } catch (error) {
              // 捕获异常
            }
          }
          )
          .shadow({ radius: 20, color: '#666666', offsetX: 15, offsetY: 15 })
      }
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .margin({ top: 10 })

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