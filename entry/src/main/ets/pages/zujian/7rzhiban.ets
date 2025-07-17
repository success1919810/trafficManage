// 1. 定义值班数据接口，明确类型
interface DutyItem {
  date: string;          // 值班日期
  location: string;      // 执勤点
  shiftName: string;     // 班次名称
  time: string;          // 班次时段
  borderColor: string;   // 边框颜色
  showAdjustBtn: boolean; // 是否显示"申请调整"按钮
  adjustBtnMargin?: number; // 调整按钮左侧边距（可选）
}

@Component
export struct rzhiban {
  // 2. 初始化值班数据（7条数据，对应7个卡片）
  private dutyList: DutyItem[] = [
    {
      date: '2020-4-11',
      location: '巡区一区',
      shiftName: '早班',
      time: '8:30:00-12:00:00',
      borderColor: '#0099ff',
      showAdjustBtn: false, // 第一个卡片不显示"申请调整"
      adjustBtnMargin: 10   // "提交值班"按钮左距10
    },
    {
      date: '2020-4-11',
      location: '巡区一区',
      shiftName: '早班',
      time: '8:30:00-12:00:00',
      borderColor: '#999999',
      showAdjustBtn: true,  // 显示"申请调整"
      adjustBtnMargin: 2
    },
    {
      date: '2020-4-11',
      location: '巡区一区',
      shiftName: '早班',
      time: '8:30:00-12:00:00',
      borderColor: '#999999',
      showAdjustBtn: true,
      adjustBtnMargin: 2
    },
    {
      date: '2020-4-11',
      location: '巡区一区',
      shiftName: '早班',
      time: '8:30:00-12:00:00',
      borderColor: '#999999',
      showAdjustBtn: true,
      adjustBtnMargin: 2
    },
    {
      date: '2020-4-11',
      location: '巡区一区',
      shiftName: '早班',
      time: '8:30:00-12:00:00',
      borderColor: '#999999',
      showAdjustBtn: true,
      adjustBtnMargin: 2
    },
    {
      date: '2020-4-11',
      location: '巡区一区',
      shiftName: '早班',
      time: '8:30:00-12:00:00',
      borderColor: '#999999',
      showAdjustBtn: true,
      adjustBtnMargin: 2
    },
    {
      date: '2020-4-11',
      location: '巡区一区',
      shiftName: '早班',
      time: '8:30:00-12:00:00',
      borderColor: '#999999',
      showAdjustBtn: true,
      adjustBtnMargin: 2
    }
  ];

  // 3. 提取卡片布局组件，复用UI
  @Builder
  private renderDutyCard(item: DutyItem) {
    Column() {
      // 顶部：日期和按钮区域
      Row() {
        Text(`值班日期： ${item.date}`)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10 })
          .fontColor('#0099ff')

        // 条件显示"申请调整"按钮
        if (item.showAdjustBtn) {
          Text('申请调整')
            .fontColor('#ffffff')
            .fontSize(16)
            .padding(5)
            .margin({ left: item.adjustBtnMargin, bottom: 10 })
            .backgroundColor('#0099ff')
            .borderRadius(5)
        }

        // "提交值班"按钮
        Text('提交值班')
          .fontColor('#ffffff')
          .fontSize(16)
          .padding(5)
          .margin({
            left: item.showAdjustBtn ? 2 : item.adjustBtnMargin,
            bottom: 10
          })
          .backgroundColor('#0099ff')
          .borderRadius(5)
      }

      // 底部：值班详情
      Row() {
        Column() {
          Text('    执勤点： \n班次名称： \n班次时段： ')
            .fontSize(16)
            .fontColor('#000000')
        }
        Column() {
          Text(`${item.location}\n${item.shiftName}\n${item.time}`)
            .fontSize(16)
            .fontColor('#999999')
        }
      }
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({
      width: 1,
      color: item.borderColor
    })
  }

  build() {
    // 4. 使用List组件实现高性能滚动列表
    List() {
      ForEach(
        this.dutyList,
        (item: DutyItem) => { // 明确item类型为DutyItem，避免any
          ListItem() {
            this.renderDutyCard(item)
          }
          .margin({ top: 10 }) // 卡片间距
        }
      )
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#F5F5F5')
  }
}