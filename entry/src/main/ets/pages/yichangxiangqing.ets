import router from '@ohos.router';

@Entry
@Component
struct Yichangxiangqing {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('<')
          .fontSize(24)
          .fontColor('#000000')
          .onClick(() => router.back())

        Blank()

        Text('异常无效')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Blank()
      }
      .width('100%')
      .height(50)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#FFFFFF')

      // 滚动内容
      Scroll() {
        Column({ space: 0 }) {
          // 异常信息
          this.SectionTitle('异常信息')
          this.InfoItem('异常类型', '超时未受收')
          this.InfoItem('人员名称', '张亚飞')
          this.InfoItem('所属部门', '内江市交警支队一大队')
          this.InfoItem('异常时间', '2021-4-11 10:25:45')
          this.InfoItem('异常描述', '警情超时15分钟未受收')

          // 调度单信息
          this.SectionTitle('调度单信息')
          this.InfoItem('派单单位', '内江市交警支队')
          this.InfoItem('派单时间', '2021-4-11 10:35:45')
          this.InfoItem('派单人员', '李刚')
          this.InfoItem('联系电话', '15889126789')

          // 警情基本信息
          this.SectionTitle('警情基本信息')
          this.InfoItem('所属部门', '内江市交警支队一大队')
          this.InfoItem('接警时间', '2021-4-11 8:30:40')
          this.InfoItem('警情地点', '内江市东兴区双安大道中路25')
          this.InfoItem('警情来源', '96122接处警')
          this.InfoItem('警情分类', '应急警情')
          this.InfoItem('警情类型', '交通事故现场处置')
          this.InfoItem('警情级别', '一般')
          this.InfoItem('警情描述', '该路段发生一起车祸，两车追尾，暂无人员伤亡')

          // 视频图片
          Column() {
            Text('视频图片')
              .fontSize(16)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 15 })

            Row() {
              ForEach([1, 2, 3], (item: number) => {
                Column() {
                  Image($r('app.media.1'))
                    .width(80)
                    .height(80)
                    .backgroundColor('#E8F4FD')
                    .borderRadius(8)
                }
                .margin({ right: item < 3 ? 15 : 0 })
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: 20, right: 20, top: 15, bottom: 15 })
          .backgroundColor('#FFFFFF')

          // 扩充信息
          this.SectionTitle('扩充信息')
          this.InfoItem('接警民警', '张亚飞')
          this.InfoItem('报警人', '刘磊')
          this.InfoItem('报警人性别', '男')
          this.InfoItem('联系电话', '15889126789')
          this.InfoItem('报警方式', '电话报警')

          // 反馈信息
          this.SectionTitle('反馈信息')
          this.InfoItem('反馈描述', '手机无提示收到警情任务')
          this.InfoItem('状态', '无效')

          // 异常警情历史记录
          this.SectionTitle('异常警情历史记录')
          Column() {
            this.HistoryItem('无效', '雷接人员刘磊说道了警情异常反馈', '2021-4-12 11:30:48', false)
            this.HistoryItem('备检', '雷接人员刘磊对警情异常反馈进行备检', '2021-4-11 16:30:48', false)
            this.HistoryItem('反馈', '勤务人员张亚飞对警情异常进行反馈', '2021-4-12 10:30:48', false)
            this.HistoryItem('备效', '系统来查警情异常记录', '2021-4-11 15:38:48', true)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')

        }
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }

  @Builder
  SectionTitle(title: string) {
    Text(title)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor('#333333')
      .width('100%')
      .padding({ left: 20, right: 20, top: 15, bottom: 10 })
      .backgroundColor('#F5F5F5')
  }

  @Builder
  InfoItem(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(16)
        .fontColor('#333333')
        .width(100)

      Blank()

      Text(value)
        .fontSize(16)
        .fontColor('#666666')
        .textAlign(TextAlign.End)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .height(50)
    .padding({ left: 20, right: 20 })
    .backgroundColor('#FFFFFF')
    .border({
      width: { bottom: 0.5 },
      color: '#E5E5E5'
    })
  }

  @Builder
  HistoryItem(status: string, description: string, time: string, isLast: boolean) {
    Row() {
      // 左侧状态圆点和连线
      Column() {
        Circle({ width: 12, height: 12 })
          .fill('#4FC3F7')

        if (!isLast) {
          Line()
            .width(2)
            .height(30)
            .stroke('#E5E5E5')
            .margin({ top: 5 })
        }
      }
      .width(20)
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 15 })

      // 右侧内容
      Column({ space: 5 }) {
        Row() {
          Text(`【${status}】`)
            .fontSize(14)
            .fontColor('#4FC3F7')
            .fontWeight(FontWeight.Medium)

          Text(description)
            .fontSize(14)
            .fontColor('#333333')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Text(time)
          .fontSize(12)
          .fontColor('#999999')
          .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .alignItems(VerticalAlign.Top)
  }
}