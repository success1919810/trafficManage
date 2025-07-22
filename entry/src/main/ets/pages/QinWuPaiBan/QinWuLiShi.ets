import router from '@ohos.router';

interface ZhiBanRecord {
  date: string;
  location: string;
  shiftName: string;
  timeRange: string;
  status: string;
  statusColor: string;
}

@Entry
@Component
struct QinWuLiShi {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  @State zhiBanList: ZhiBanRecord[] = [
    {
      date: '2020-4-41',
      location: '巡区一区',
      shiftName: '早班',
      timeRange: '8:30:00-12:00:00',
      status: '待审核',
      statusColor: '#FF9800'
    },
    {
      date: '2020-4-41',
      location: '巡区一区',
      shiftName: '早班',
      timeRange: '8:30:00-12:00:00',
      status: '有效',
      statusColor: '#4CAF50'
    },
    {
      date: '2020-4-41',
      location: '巡区一区',
      shiftName: '早班',
      timeRange: '8:30:00-12:00:00',
      status: '无效',
      statusColor: '#F44336'
    }
  ];

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(24)
          .fontColor('#000000')
          .onClick(() => router.back())

        Blank()

        Text('历史值班列表')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Blank()
      }
      .width('100%')
      .height(50)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#FFFFFF')

      // 列表内容
      List({ space: 10 }) {
        ForEach(this.zhiBanList, (item: ZhiBanRecord, index: number) => {
          ListItem() {
            this.ZhiBanCard(item)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 15, right: 15, top: 10 })
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }

  @Builder
  ZhiBanCard(item: ZhiBanRecord) {
    Column({ space: 8 }) {
      // 顶部日期和箭头
      Row() {
        Row({ space: 5 }) {
          Text('值班日期:')
            .fontSize(14)
            .fontColor('#666666')

          Text(item.date)
            .fontSize(14)
            .fontColor('#2196F3')
        }

        Blank()

        Text('>')
          .fontSize(16)
          .fontColor('#2196F3')
      }
      .width('100%')

      // 执勤点
      Row() {
        Text('执勤点:')
          .fontSize(14)
          .fontColor('#666666')
          .width(70)

        Text(item.location)
          .fontSize(14)
          .fontColor('#333333')
      }
      .width('100%')

      // 班次名称
      Row() {
        Text('班次名称:')
          .fontSize(14)
          .fontColor('#666666')
          .width(70)

        Text(item.shiftName)
          .fontSize(14)
          .fontColor('#333333')
      }
      .width('100%')

      // 班次时段
      Row() {
        Text('班次时段:')
          .fontSize(14)
          .fontColor('#666666')
          .width(70)

        Text(item.timeRange)
          .fontSize(14)
          .fontColor('#333333')
      }
      .width('100%')

      // 状态
      Row() {
        Text('状态:')
          .fontSize(14)
          .fontColor('#666666')
          .width(70)

        Text(item.status)
          .fontSize(14)
          .fontColor(item.statusColor)
      }
      .width('100%')
    }
    .width('100%')
    .padding(15)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#E0E0E0', offsetX: 0, offsetY: 1 })
    .onClick(() => {
      // 点击跳转到详情页面
      console.log('点击值班记录:', item.date)
    })
  }
}