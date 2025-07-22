import { router } from '@kit.ArkUI';

@Entry
@Component
struct DutyRecordDetail {
  @State dutyName: string = '带班领导';
  @State dutyPerson: string = '张亚飞';
  @State department: string = '成都市公安局交警大队';
  @State dutyPoint: string = '巡区一区';
  @State dutyDate: string = '2021-4-11';
  @State dutyCategory: string = '部门值班';
  @State dutySubCategory: string = '带班领导';
  @State shiftName: string = '早高峰巡逻';
  @State shiftTime: string = '8:00:00-18:00:00';
  @State colleagues: string = '刘能、邓杰、黎明';
  @State resultDescription: string = '处理了5项临时任务';

  build() {
    Column() {
      // 顶部导航栏
      Row(){
        Text('<')
          .fontSize(40)
          .margin({bottom:30})
          .width('10%')
          .onClick(() => {
            router.back();
          })

        Text('值班记录审核')
          .fontSize(20)
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('80%')

        Text('<')
          .fontSize(26)
          .fontColor('#F2F2F2')
          .margin({bottom:20})
          .width('10%')
      }.backgroundColor('#F2F2F2').width('100%').height(50).margin({ top: 40 });

      // 内容区域
      Column() {
        // 值班信息
        this.buildInfoRow('值班名称', this.dutyName)
        this.buildInfoRow('值班人员', this.dutyPerson)
        this.buildInfoRow('所属部门', this.department)
        this.buildInfoRow('执勤点', this.dutyPoint)
        this.buildInfoRow('勤务日期', this.dutyDate)
        this.buildInfoRow('勤务分类', this.dutyCategory)
        this.buildInfoRow('勤务子分类', this.dutySubCategory)
        this.buildInfoRow('班次名称', this.shiftName)
        this.buildInfoRow('班次时段', this.shiftTime)
        this.buildInfoRow('共同值班警员', this.colleagues)

        // 值班结果信息标题
        Text('值班结果信息')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 10 })
          .alignSelf(ItemAlign.Start)

        this.buildInfoRow('值班结果描述', this.resultDescription)

        // 图片区域
        Row() {
          Text('图片')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Row() {
            Image($r('app.media.tu'))
              .width(60)
              .height(60)
              .backgroundColor('#E5E5E5')
              .borderRadius(4)
              .margin({ right: 10 })

            Image($r('app.media.tu'))
              .width(60)
              .height(60)
              .backgroundColor('#E5E5E5')
              .borderRadius(4)
          }
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .alignItems(VerticalAlign.Top)

        Blank()

        // 底部按钮
        Row() {
          Button('无效')
            .fontSize(16)
            .fontColor('#007AFF')
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .border({ width: 1, color: '#007AFF' })
            .width('40%')
            .height(44)
            .onClick(() => {
              router.back();
            })

          Button('有效')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#007AFF')
            .borderRadius(8)
            .width('40%')
            .height(44)
            .onClick(() => {
              router.back();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ bottom: 30 })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildInfoRow(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(16)
        .fontColor('#333333')

      Blank()

      Text(value)
        .fontSize(16)
        .fontColor('#666666')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
  }
}