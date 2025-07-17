interface VehicleInfo {
  licensePlate: string; // 车牌号
  location: string;     // 抓拍地点
  captureTime: string;  // 抓拍时间
  taskTime: string;     // 任务时间
  status: string;       // 状态（布控中/已过期/已撤诉）
  statusColor: string;  // 状态文字颜色
}
@Component
export struct jc1 {
  private vehicleList: VehicleInfo[] = [
    {
      licensePlate: '川K·A7H86',
      location: '内江市东兴区汉安大道西段988号',
      captureTime: '2021年6月28日10:12:34',
      taskTime: '2021年6月25日15:27:29',
      status: '布控中',
      statusColor: '#0000ff'
    }
  ];
  @Builder
  private renderVehicleCard(item: VehicleInfo) {
    Column({ space: 10 }) {
      // 车牌号
      Row() {
        Text(item.licensePlate)
          .fontSize(20)
          .fontColor('#ff0000')
          .fontWeight(FontWeight.Bold)
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')

      // 抓拍信息
      Row() {
        Text(`抓拍地点：${item.location}\n抓拍时间：${item.captureTime}\n任务时间：${item.taskTime}\n`)
          .fontSize(16)
          .fontColor('#666666')
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')

      // 状态
      Row() {
        Text(item.status)
          .fontSize(14)
          .fontColor(item.statusColor)
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
    }
    .margin({ top: 10 })
    .backgroundColor('#ffffff')
    .borderRadius(10)

    .padding(10) // 增加内边距，避免内容贴边
  }

  build() {
    // 4. 使用List实现滚动列表
    List() {
      ForEach(
        this.vehicleList,
        (item: VehicleInfo) => {
          ListItem() {
            this.renderVehicleCard(item) // 调用卡片组件
          }
        },
      )
    }
    .margin({ left: '5%', right: '5%', top: 0 })
    .width('90%')
    .height('100%')
  }

}