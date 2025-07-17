// 1. 完善接口定义，明确值班数据结构
interface Item1 {
  date: string;          // 值班日期
  location: string;      // 执勤点
  shiftName: string;     // 班次名称
  time: string;          // 班次时段
  borderColor: string;   // 边框颜色
  showAdjustBtn: boolean; // 是否显示"申请调整"按钮
  adjustBtnMargin?: number; // 调整按钮左侧边距（可选参数）
}

@Component
export struct yzhiban {
  // 2. 初始化值班数据（对应7个卡片）
  datas: Item1[] = [
    {
      date: '2020-4-11',
      location: '巡区一区',
      shiftName: '早班',
      time: '8:30:00-12:00:00',
      borderColor: '#0099ff',
      showAdjustBtn: false, // 第一个卡片不显示"申请调整"
      adjustBtnMargin: 10   // 第一个卡片"提交值班"按钮左距10
    },
    {
      date: '2020-4-11',
      location: '巡区一区',
      shiftName: '早班',
      time: '8:30:00-12:00:00',
      borderColor: '#999999',
      showAdjustBtn: true,  // 显示"申请调整"按钮
      adjustBtnMargin: 2    // 按钮左距2
    },
    // 复用数据结构，添加剩余5个卡片
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

  // 2. 提取卡片布局组件，复用UI
  @Builder
  myItemUI(item: Item1) {
    Column() {
      // 顶部：日期和按钮区域
      Row() {
        Text(`值班日期： ${item.date}`)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom:                10 })
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

        // "提交值班"按钮（所有卡片都显示）
        Text('提交值班')
          .fontColor('#ffffff')
          .fontSize(16)
          .padding(5)
          .margin({ left: item.showAdjustBtn ? 2 : item.adjustBtnMargin, bottom: 10 })
          .backgroundColor('#0099ff')
          .borderRadius(5)
      }

      // 底部：值班详情区域
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
    // 3. 使用List实现高效滚动列表
    List() {
      ForEach(this.datas, (item: Item1) => {
        ListItem() {
          this.myItemUI(item) // 调用卡片组件
        }
        .margin({ top: 10 }) // 卡片之间的间距
      }) // 唯一键（确保列表项稳定）
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#F5F5F5') // 列表背景色（区分卡片）
  }
}
