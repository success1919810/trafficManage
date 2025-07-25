import router from '@ohos.router';

@Entry
@Component
struct YichangJingqing {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  @State selectedMonth: string = '6月';
  @State selectedDepartment: string = '选择部门';
  @State searchText: string = '';
  @State selectAll: boolean = false;
  @State selectedItems: boolean[] = [false, false, false];

  // 异常警情数据
  @State alertData: AlertItem[] = [
    {
      name: '张亚飞',
      department: '内江市交警支队一大队',
      type: '超时未受收',
      time: '2021-04-11 10:25:45'
    },
    {
      name: '张亚飞',
      department: '内江市交警支队一大队',
      type: '超时未受收',
      time: '2021-04-11 10:25:45'
    },
    {
      name: '张亚飞',
      department: '内江市交警支队一大队',
      type: '超时未受收',
      time: '2021-04-11 10:25:45'
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

        Text('异常警情')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Blank()
      }
      .width('100%')
      .height(50)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#FFFFFF')

      // 筛选栏
      Row({ space: 10 }) {
        // 月份选择
        Row({ space: 5 }) {
          Text(this.selectedMonth)
            .fontSize(14)
            .fontColor('#333333')

          Text('▼')
            .fontSize(12)
            .fontColor('#666666')
        }
        .padding({ left: 10, right: 10, top: 8, bottom: 8 })
        .backgroundColor('#F5F5F5')
        .borderRadius(4)

        // 部门选择
        Row({ space: 5 }) {
          Text(this.selectedDepartment)
            .fontSize(14)
            .fontColor('#333333')

          Text('▼')
            .fontSize(12)
            .fontColor('#666666')
        }
        .padding({ left: 10, right: 10, top: 8, bottom: 8 })
        .backgroundColor('#F5F5F5')
        .borderRadius(4)

        // 搜索框
        Row({ space: 8 }) {
          Image($r('app.media.camera'))
            .width(16)
            .height(16)
            .fillColor('#999999')

          TextInput({ placeholder: '输入人员名称' })
            .fontSize(14)
            .backgroundColor(Color.Transparent)
            .border({ width: 0 })
            .padding(0)
            .flexGrow(1)
        }
        .padding({ left: 10, right: 10, top: 8, bottom: 8 })
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
        .flexGrow(1)
      }
      .width('100%')
      .padding({ left: 15, right: 15, top: 10, bottom: 10 })
      .backgroundColor('#FFFFFF')

      // 表头
      Row() {
        // 左侧有效列（包含黄色数字1）
        Row({ space: 5 }) {
          Column() {
            Text('有效')
              .fontSize(14)
              .fontColor('#4FC3F7')
              .margin({ top: 2 })
          }
        }
        .width('33.33%')
        .justifyContent(FlexAlign.Center)

        // 中间待审核列
        Text('待审核')
          .fontSize(14)
          .fontColor('#333333')
          .width('33.33%')
          .textAlign(TextAlign.Center)

        // 右侧无效列
        Text('无效')
          .fontSize(14)
          .fontColor('#333333')
          .width('33.33%')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#F8F8F8')
      .border({ width: { bottom: 1 }, color: '#E5E5E5' })

      //列表内容
      Scroll() {
        Column({ space: 0 }) {
          ForEach(this.alertData, (item: AlertItem, index: number) => {
            this.AlertItemView(item, index)
          })

          // 底部全选和批量操作
          Row() {
            Row({ space: 8 }) {
              Checkbox({ name: 'selectAll', group: 'checkboxGroup' })
                .select(this.selectAll)
                .selectedColor('#4FC3F7')
                .onChange((value: boolean) => {
                  this.selectAll = value;
                  this.selectedItems = this.selectedItems.map(() => value);
                })

              Text('全选')
                .fontSize(14)
                .fontColor('#333333')

              Text(`共${this.alertData.length}条异常警情记录`)
                .fontSize(12)
                .fontColor('#999999')
            }

            Button('无效')
              .width(60)
              .height(32)
              .backgroundColor('#4FC3F7')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .borderRadius(4)
          }
          .width('100%')
          .padding({ left: 15, right: 15, top: 15, bottom: 15 })
          .justifyContent(FlexAlign.SpaceBetween)
          .backgroundColor('#FFFFFF')
        }
      }
      .backgroundColor('#F5F5F5')
      .padding(0)
      .margin(0)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  AlertItemView(item: AlertItem, index: number) {
    Column() {
      Row() {
        Checkbox({ name: `item_${index}`, group: 'checkboxGroup' })
          .select(this.selectedItems[index])
          .selectedColor('#4FC3F7')
          .onChange((value: boolean) => {
            this.selectedItems[index] = value;
          })
          .margin({ right: 10 })

        Column({ space: 6 }) {
          Text(item.name)
            .fontSize(16)
            .fontColor('#4FC3F7')
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text(`所属部门：${item.department}`)
            .fontSize(14)
            .fontColor('#666666')
            .width('100%')
            .textAlign(TextAlign.Start)

          Text(`异常类型：${item.type}`)
            .fontSize(14)
            .fontColor('#666666')
            .width('100%')
            .textAlign(TextAlign.Start)

          Text(`异常时间：${item.time}`)
            .fontSize(14)
            .fontColor('#666666')
            .width('100%')
            .textAlign(TextAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button('无效')
          .width(70)
          .height(28)
          .backgroundColor('#4FC3F7')
          .fontColor('#FFFFFF')
          .fontSize(12)
          .borderRadius(4)
          .margin({ left: 10 })
          .onClick(() => {
            console.log(`标记第${index}项为无效`);
          })
      }
      .width('100%')
      .padding({ left: 15, right: 15, top: 12, bottom: 12 })
      .alignItems(VerticalAlign.Top)

      // 分割线
      if (index < this.alertData.length - 1) {
        Row()
          .width('100%')
          .height(0.5)
          .backgroundColor('#E5E5E5')
      }
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      router.pushUrl({
        url: 'pages/yichangxiangqing'
      });
    })
  }
}

interface AlertItem {
  name: string;
  department: string;
  type: string;
  time: string;
}