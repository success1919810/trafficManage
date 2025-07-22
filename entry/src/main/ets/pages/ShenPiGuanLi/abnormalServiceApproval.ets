import { router } from '@kit.ArkUI';

@Entry
@Component
struct AbnormalDutyDetail {
  @State recordId: string = '';

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params.recordId) {
      this.recordId = params.recordId as string;
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(26)
          .fontColor('#333333')
          .width('10%')
          .onClick(() => {
            router.back();
          })

        Text('审核')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
          .width('80%')

        Text('')
          .width('10%')
      }
      .width('100%')
      .height(50)
      .backgroundColor('#F8F8F8')
      .padding({ left: 16, right: 16 })
      .margin({ top: 40 })

      // 滚动内容区域
      Scroll() {
        Column() {
          // 异常信息标题
          Row() {
            Text('异常信息')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
          .width('100%')
          .padding({ left: 16, top: 20, bottom: 12 })
          .backgroundColor('#FFFFFF')

          // 异常信息内容
          Column() {
            this.buildInfoRow('入员名称', '张亚飞')
            this.buildInfoRow('所属部门', '内江市交警支队一大队')
            this.buildInfoRow('监督结果', '异常', '#FF3B30')
            this.buildInfoRow('异常类型', '越界')
            this.buildInfoRow('异常日期', '2021-4-11')
            this.buildInfoRow('异常时间', '15:38:48')
            this.buildInfoRow('执勤点', '汉安大道中段')
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .padding({ left: 16, right: 16, bottom: 16 })

          // 值班信息标题
          Row() {
            Text('值班信息')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
          .width('100%')
          .padding({ left: 16, top: 20, bottom: 12 })
          .backgroundColor('#FFFFFF')

          // 值班信息内容
          Column() {
            this.buildInfoRow('值班人员', '张亚飞')
            this.buildInfoRow('所属部门', '一大队')
            this.buildInfoRow('执勤点', '汉安大道中段')
            this.buildInfoRow('值班日期', '2021-4-11')
            this.buildInfoRow('勤务类型', '路面勤务')
            this.buildInfoRow('勤务子类型', '指挥调度')
            this.buildInfoRow('班次名称', '晚班')
            this.buildInfoRow('班次时段：', '12:00:00-16:00:00')
            this.buildInfoRow('巡逻方式：', '车巡')
            this.buildInfoRow('车牌号码：', '川K·2345警')
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .padding({ left: 16, right: 16, bottom: 16 })

          // 底部间距，确保按钮不被遮挡
          Row().height(100)
        }
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')

      // 底部操作按钮
      Row() {
        Button('驳回')
          .fontSize(16)
          .fontColor('#666666')
          .backgroundColor('#E5E5E5')
          .borderRadius(8)
          .width('40%')
          .height(44)
          .onClick(() => {
            // 驳回逻辑
            router.back();
          })

        Button('通过')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .backgroundColor('#007AFF')
          .borderRadius(8)
          .width('40%')
          .height(44)
          .onClick(() => {
            // 通过逻辑
            router.back();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ left: 16, right: 16, bottom: 30 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildInfoRow(label: string, value: string, valueColor?: string) {
    Row() {
      Text(label)
        .fontSize(14)
        .fontColor('#333333')
        .width(80)

      Blank()

      Text(value)
        .fontSize(14)
        .fontColor(valueColor || '#666666')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .height(44)
    .alignItems(VerticalAlign.Center)
    .border({
      width: { bottom: 0.5 },
      color: '#E5E5E5'
    })
  }
}