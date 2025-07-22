import router from '@ohos.router';

@Entry
@Component
struct YuJingXinXi {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(24)
          .fontColor('#000000')
          .onClick(() => router.back())

        Blank()

        Text('预警信息')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Blank()
      }
      .width('100%')
      .height(50)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#FFFFFF')

      // 信息列表区域
      Column({ space: 0 }) {
        this.InfoRow('车身颜色', '黑色')
        this.InfoRow('品牌型号', '奔驰C200')
        this.InfoRow('布控类型', '套牌违法')
        this.InfoRow('布控等级', '一级')
        this.InfoRow('布控单位', '指挥中心')
        this.InfoRow('报警地点', '东兴区汉安大道西段988号')
        this.InfoRow('报警时间', '2021年5月31日17:25:59')
        this.InfoRow('更新地点', '东兴区汉安大道西段952号')
        this.InfoRow('更新时间', '2021年5月31日17:33:53')
        this.InfoRow('布控时限', '2021-5-6 - 2021-6-9')
        this.InfoRow('布控状态', '布控中')
      }
      .backgroundColor('#FFFFFF')
      .padding({ top: 10 })

      // 地图定位标题
      Row() {
        Text('地图定位')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .padding({ left: 15, right: 15, top: 20, bottom: 10 })
      .backgroundColor('#F5F5F5')

      // 地图区域
      Stack({ alignContent: Alignment.Center }) {
        // 地图背景（模拟地图）
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#E8F4FD')

        // 地图上的红色定位点
        Circle({ width: 12, height: 12 })
          .fill('#FF4444')
          .stroke('#FFFFFF')
          .strokeWidth(2)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#E8F4FD')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }

  @Builder
  InfoRow(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(14)
        .fontColor('#666666')
        .width(80)
        .textAlign(TextAlign.Start)

      Blank()

      Text(value)
        .fontSize(14)
        .fontColor('#333333')
        .textAlign(TextAlign.End)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .height(45)
    .padding({ left: 15, right: 15 })
    .alignItems(VerticalAlign.Center)
    .border({
      width: { bottom: 0.5 },
      color: '#E5E5E5'
    })
  }
}