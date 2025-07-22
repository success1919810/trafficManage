import router from '@ohos.router';


@Entry
@Component
struct MyReportPage {
  private selectedType: string = 'all';
  @State text1: string = "    筛选    ";
  @State text2: string = "    月份    ";
  @State index: number = 2;
  @State space: number = 8;
  @State arrowPosition: ArrowPosition = ArrowPosition.END;

  build() {
    Column() {
      // 标题 Row 部分，调整 margin.top 来控制与上边缘间距
      Row() {
        // 返回按钮
        Text('<')
          .fontSize(40)
          .width(120)
          .onClick(() => router.back());

        // 页面标题
        Text('我的上报')
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          .margin({ left: 10, right: 10 });

        // 筛选 Select 组件
        Select([{ value: '交通事件' }, { value: '设备故障' }])
          .selected(this.index)
          .value(this.text1)
          .font({ size: 16, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 16, weight: 400 })
          .optionFont({ size: 16, weight: 400 })
          .space(this.space)
          .arrowPosition(this.arrowPosition)
          .menuAlign(MenuAlignType.START, { dx: 0, dy: 0 })
          .optionWidth(120)
          .optionHeight(300)
          .onSelect((index: number, text?: string | undefined) => {
            console.info('Select:' + index);
            this.index = index;
            if (text) {
              this.text1 = text;
            }
          })
      }
      .width('100%')
      .padding({ left: 10, right: 10 })
      // 关键调整：增大 top 的 margin 值，让标题区域下移
      .margin({ top: 40, bottom: 10 }) // 将 bottom 从 20 改为 10，减少下方间距
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween);

      // 月份显示 Row
      Row(){
        Select([{ value: '一月' }, { value: '二月' },{ value: '三月' },{ value: '四月' },{ value: '五月' },{ value: '六月' },{ value: '七月' },{ value: '八月' },{ value: '九月' },{ value: '十月' },{ value: '十一月' },{ value: '十二月' }])
          .selected(this.index)
          .value(this.text2)
          .font({ size: 16, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 16, weight: 400 })
          .optionFont({ size: 16, weight: 400 })
          .space(this.space)
          .arrowPosition(this.arrowPosition)
          .menuAlign(MenuAlignType.START, { dx: 0, dy: 0 })
          .optionWidth(120)
          .optionHeight(300)
          .onSelect((index: number, text?: string | undefined) => {
            console.info('Select:' + index);
            this.index = index;
            if (text) {
              this.text2 = text;
            }
          })
      }
      .width('100%')
      .margin({ top: 0 })
      .padding({ left: 10})


      // 引入 report 组件
      report();
    }
    .width('100%')
    .height('100%')
  }
}

// 列表接口定义
interface Item1 {
  text1: string;
  text2: string;
  text3: string;
  text4: string;
}

// 上报内容组件
@Component
struct report {
  // 模拟数据
  datas: Item1[] = [
    { text1: '交通事件', text2: '事件类型：交通拥堵', text3: '事件地点：内江市东兴区汉安大道西段 988 号', text4: '上报时间: 2021 年 6 月 25 日 15:27:29' },
    { text1: '设备故障', text2: '设备名称：高点球机 - BH58Z1', text3: '设备地点：内江市东兴区汉安大道西段 988 号', text4: '上报时间: 2021 年 6 月 25 日 15:27:29' },
    { text1: '设备故障', text2: '设备名称：高点球机 - BH58Z1', text3: '设备地点：内江市东兴区汉安大道西段 988 号', text4: '上报时间: 2021 年 6 月 25 日 15:27:29' },
    { text1: '设备故障', text2: '设备名称：高点球机 - BH58Z1', text3: '设备地点：内江市东兴区汉安大道西段 988 号', text4: '上报时间: 2021 年 6 月 25 日 15:27:29' },
    { text1: '设备故障', text2: '设备名称：高点球机 - BH58Z1', text3: '设备地点：内江市东兴区汉安大道西段 988 号', text4: '上报时间: 2021 年 6 月 25 日 15:27:29' },
  ];

  // 列表项 UI 构建器
  @Builder
  myItemUI(item: Item1) {
    Column({ space: 10 }) {
      Text(item.text1)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%');

      Text(item.text2)
        .width('100%')
        .fontColor('#666666');

      Text(item.text3)
        .width('100%')
        .fontColor('#666666');

      Text(item.text4)
        .width('100%')
        .fontColor('#666666');
    }
    .width('95%')
    .backgroundColor('#ffffff')
    .margin({ top: 15, left: 5, right: 5 })
    .padding(20)
    .borderRadius(15);
  }

  build() {
    List() {
      ForEach(this.datas, (item1: Item1) => {
        ListItem() {
          this.myItemUI(item1)
        }
      });
    }
    .width('100%')
    .padding({ bottom: 20 })
    .backgroundColor('#f2f2f2')
    .height('100%');
  }
}