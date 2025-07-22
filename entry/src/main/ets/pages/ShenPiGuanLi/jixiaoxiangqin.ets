import router from '@ohos.router';

@Entry
@Component
struct Jixiaoxiangqin {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  // 表格数据
  @State tableData: TableItem[] = [
    { name: '日常考勤', type: '栏目类型', rule: '规则', standard: '标准', score: '迟到', unitScore: 2, data: 3, totalScore: 6 },
    { name: '日常考勤', type: '', rule: '', standard: '标准', score: '早退', unitScore: 1, data: 0, totalScore: 0 },
    { name: '勤务值班', type: '', rule: '', standard: '标准', score: '里程未达标', unitScore: 1, data: 7, unit: 'km', totalScore: 1 },
    { name: '勤务值班', type: '', rule: '', standard: '标准', score: '超界', unitScore: 1, data: 0, unit: '分钟', totalScore: 0 },
    { name: '辖区助学', type: '', rule: '', standard: '自定义', score: '帮助儿童', unitScore: 2, data: 0, unit: '无', totalScore: 0 }
  ];

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('<')
          .fontSize(24)
          .fontColor('#000000')
          .onClick(() => router.back())

        Blank()

        Text('审核')
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
          // 基本信息
          this.InfoItem('被考人员', '张亚飞')
          this.InfoItem('考核部门', 'XX市交警支队一大队')
          this.InfoItem('考核周期', '2021-4')
          this.InfoItem('综效分数', '93')

          // 明细标题
          Text('明细')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .width('100%')
            .padding({ left: 20, top: 20, bottom: 15 })
            .backgroundColor('#F5F5F5')

          // 表格
          this.TableView()

          // 底部按钮
          Row({ space: 20 }) {
            Button('不通过')
              .width(120)
              .height(40)
              .backgroundColor('#FFFFFF')
              .fontColor('#4FC3F7')
              .fontSize(16)
              .borderRadius(8)
              .border({ width: 1, color: '#4FC3F7' })
              .onClick(() => {
                console.log('不通过')
                router.back()
              })

            Button('通过')
              .width(120)
              .height(40)
              .backgroundColor('#4FC3F7')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .borderRadius(8)
              .onClick(() => {
                console.log('通过')
                router.back()
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 30, bottom: 30 })
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
  TableView() {
    Column() {
      // 表头
      Row() {
        Text('考核栏目')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('栏目类型')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('规则')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('单次扣分')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('综效扣分')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#F8F8F8')
      .border({
        width: { bottom: 1 },
        color: '#E5E5E5'
      })

      // 日常考勤 - 迟到行
      Row() {
        Text('日常考勤')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('标准')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('迟到')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('2')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('6')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#FFFFFF')
      .border({
        width: { bottom: 0.5 },
        color: '#E5E5E5'
      })

      // 日常考勤 - 早退行
      Row() {
        Text('日常考勤')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('标准')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('早退')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('1')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('0')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#FFFFFF')
      .border({
        width: { bottom: 0.5 },
        color: '#E5E5E5'
      })

      // 勤务值班 - 里程未达标行
      Row() {
        Text('勤务值班')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('标准')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('里程未达标')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('1')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('1')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#FFFFFF')
      .border({
        width: { bottom: 0.5 },
        color: '#E5E5E5'
      })

      // 勤务值班 - 超界行
      Row() {
        Text('勤务值班')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('标准')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('超界')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('1')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('0')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#FFFFFF')
      .border({
        width: { bottom: 0.5 },
        color: '#E5E5E5'
      })

      // 辖区助学行
      Row() {
        Text('辖区助学')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('自定义')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('帮助儿童')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('2')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)

        Text('0')
          .fontSize(14)
          .fontColor('#333333')
          .width(70)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#FFFFFF')
      .border({
        width: { bottom: 0.5 },
        color: '#E5E5E5'
      })

      // 分页指示器
      Row() {
        Text('<')
          .fontSize(16)
          .fontColor('#999999')

        Blank()

        Row() {
          Rect({ width: 30, height: 4 })
            .fill('#CCCCCC')
            .radius(2)
        }
        .width(100)
        .justifyContent(FlexAlign.Center)

        Blank()

        Text('>')
          .fontSize(16)
          .fontColor('#999999')
      }
      .width('100%')
      .height(40)
      .padding({ left: 20, right: 20 })
      .backgroundColor('#FFFFFF')

      // 反馈意见
      Column() {
        Row() {
          Text('反馈意见')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Blank()

          Text('对统计结果无异议')
            .fontSize(14)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 15, bottom: 15 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .margin({ top: 10 })

      // 综效考核历史记录
      Column() {
        Text('综效考核历史记录')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .width('100%')
          .padding({ left: 20, right: 20, top: 15, bottom: 10 })

        // 历史记录列表
        Column({ space: 15 }) {
          this.HistoryItem('已完成', '审核人员对能完成个人综效分数查核', '2021-4-12 11:30:48')
          this.HistoryItem('确认', '审核人员对能对反馈分数进行确认', '2021-4-12 11:30:48')
          this.HistoryItem('反馈', '张亚飞对自己的综效分数进行反馈', '2021-4-12 10:30:48')
          this.HistoryItem('调整', '审核人员对能对个人综效分数进行调整', '2021-4-11 16:30:48')
          this.HistoryItem('待调整', '综效统计人员整理统计个人综效分数', '2021-4-11 15:38:48')
        }
        .width('100%')
        .padding({ left: 20, right: 20, bottom: 20 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .margin({ top: 10 })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  HistoryItem(status: string, description: string, time: string) {
    Row({ space: 10 }) {
      // 状态圆点
      Circle({ width: 8, height: 8 })
        .fill('#4FC3F7')

      // 内容区域
      Column({ space: 5 }) {
        Row() {
          Text(`【${status}】`)
            .fontSize(14)
            .fontColor('#4FC3F7')
            .fontWeight(FontWeight.Medium)

          Text(description)
            .fontSize(14)
            .fontColor('#333333')
            .flexGrow(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Text(time)
          .fontSize(12)
          .fontColor('#999999')
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .flexGrow(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

// 表格数据接口
interface TableItem {
  name: string;
  type: string;
  rule: string;
  standard: string;
  score: string;
  unitScore: number;
  data: number;
  unit?: string;
  totalScore: number;
}