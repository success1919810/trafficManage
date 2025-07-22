import router from '@ohos.router';

@Entry
@Component
struct ShiGongXiangQing {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Column() {
      // 地图区域
      Stack({ alignContent: Alignment.TopStart }) {
        // 地图背景（这里用灰色背景模拟地图）
        Column()
          .width('100%')
          .height(400)
          .backgroundColor('#F0F0F0')

        // 顶部搜索栏
        Row({ space: 10 }) {
          Text('<')
            .fontSize(24)
            .fontColor('#000000')
            .onClick(() => router.back())

          TextInput({ placeholder: '请输入地点' })
            .fontSize(14)
            .backgroundColor('#FFFFFF')
            .borderRadius(20)
            .padding({ left: 15, right: 15 })
            .flexGrow(1)

          TextInput({ placeholder: '搜索路线' })
            .fontSize(14)
            .backgroundColor('#FFFFFF')
            .borderRadius(20)
            .padding({ left: 15, right: 15 })
            .width(100)

          Image($r('app.media.a'))
            .width(24)
            .height(24)
            .fillColor('#666666')
        }
        .width('100%')
        .padding({ left: 15, right: 15, top: 10 })


      }

      // 底部信息卡片
      Column({ space: 0 }) {
        // 标题栏
        Row() {
          Column() {
            Text('汉安大道925号')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          Blank()
          // 右侧上报按钮
          Column() {
            Button() {
              Column({ space: 5 }) {
                Image($r('app.media.warning'))
                  .width(20)
                  .height(20)
                  .fillColor('#FFFFFF')

                Text('上报')
                  .fontSize(12)
                  .fontColor('#FFFFFF')
              }
            }
            .width(50)
            .height(50)
            .backgroundColor('#4FC3F7')
            .borderRadius(25)
          }
        }
        .justifyContent(FlexAlign.SpaceAround)
        .width('100%')
        .padding({ left: 20, right: 20, top: 15, bottom: 10 })
        .backgroundColor('#FFFFFF')

        // 信息列表
        Column({ space: 12 }) {
          this.InfoRow('施工单位：', '中铁三局')
          this.InfoRow('施工时间：', '2021-3-30 - 2021-5-30')
          this.InfoRow('施工状态：', '施工中')
          this.InfoRow('施工进度：', '80%')
          this.InfoRow('占道类型：', '半封闭')
          this.InfoRow('联 系 人：', '刘力')
          this.InfoRow('联系方式：', '182****253')

          // 修改方案行（带图标）
          Row() {
            Text('修改方案：')
              .fontSize(14)
              .fontColor('#666666')
              .width(80)

              Text('查看')
                .fontSize(14)
                .fontColor('#4FC3F7')
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          Text('检查记录 (2/2)')
            .fontSize(14)
            .textAlign(TextAlign.Start)
        }
        .padding({ left: 20, right: 20, bottom: 20 })
        .backgroundColor('#FFFFFF')
      }
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 15, topRight: 15 })
      .margin({ top: -15 })
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

      Text(value)
        .fontSize(14)
        .fontColor('#333333')
        .flexGrow(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}