import { router } from '@kit.ArkUI';

@Entry
@Component
struct AbnormalServiceDetail {
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

        Text('详情')
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
          // 基本信息内容
          Column() {
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
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })

          // 反馈意见
          Column() {
            Row() {
              Text('反馈意见')
                .fontSize(14)
                .fontColor('#333333')
                .width(80)

              Blank()
            }
            .width('100%')
            .height(44)
            .alignItems(VerticalAlign.Center)
            .border({
              width: { bottom: 0.5 },
              color: '#E5E5E5'
            })

            Text('值班过程中路面发生事故前去处理，脱离了自己的岗位')
              .fontSize(14)
              .fontColor('#666666')
              .width('100%')
              .padding({ top: 12, bottom: 16 })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .padding({ left: 16, right: 16 })

          // 图片区域
          Column() {
            Row() {
              Text('图片：')
                .fontSize(14)
                .fontColor('#333333')
            }
            .width('100%')
            .padding({ bottom: 12 })

            Row({ space: 12 }) {
              this.buildImagePlaceholder()
              this.buildImagePlaceholder()
              this.buildImagePlaceholder()
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .padding({ left: 16, right: 16, bottom: 16 })

          // 异常勤务历史记录
          Column() {
            Row() {
              Text('异常勤务历史记录')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
            }
            .width('100%')
            .padding({ left: 16, top: 20, bottom: 12 })
            .backgroundColor('#FFFFFF')

            Column() {
              this.buildHistoryItem('已完成', '申核人员刘能完成异常勤务', '2021-4-12 11:30:48')
              this.buildHistoryItem('确认', '申核人员刘能对勤务异常反馈进行确认', '2021-4-12 11:30:48')
              this.buildHistoryItem('反馈', '勤务人员张亚飞对勤务异常进行反馈', '2021-4-12 10:30:48')
              this.buildHistoryItem('审核', '申核人员刘能进行勤务异常审核', '2021-4-11 16:30:48')
              this.buildHistoryItem('待审核', '系统发出勤务异常预警', '2021-4-11 15:38:48')
            }
            .width('100%')
            .backgroundColor('#FFFFFF')
            .padding({ left: 16, right: 16, bottom: 16 })
          }

          // 底部间距
          Row().height(30)
        }
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
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

  @Builder
  buildImagePlaceholder() {
    Column() {
      Image($r('app.media.tu'))
        .width(60)
        .height(40)
        .objectFit(ImageFit.Cover)
        .backgroundColor('#E5E5E5')
    }
    .width(80)
    .height(60)
    .backgroundColor('#F0F0F0')
    .borderRadius(4)
    .justifyContent(FlexAlign.Center)
    .border({ width: 1, color: '#E5E5E5' })
  }

  @Builder
  buildHistoryItem(status: string, description: string, time: string) {
    Row() {
      // 状态圆点
      Circle()
        .width(8)
        .height(8)
        .fill('#007AFF')
        .margin({ top: 4, right: 12 })

      Column({ space: 4 }) {
        Row() {
          Text(`【${status}】`)
            .fontSize(14)
            .fontColor('#007AFF')
            .fontWeight(FontWeight.Medium)

          Text(description)
            .fontSize(14)
            .fontColor('#333333')
            .layoutWeight(1)
        }
        .width('100%')

        Text(time)
          .fontSize(12)
          .fontColor('#999999')
          .alignSelf(ItemAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ bottom: 16 })
    .alignItems(VerticalAlign.Top)
  }
}