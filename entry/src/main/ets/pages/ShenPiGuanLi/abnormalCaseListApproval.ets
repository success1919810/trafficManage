import { router } from '@kit.ArkUI';

interface WarningRecord {
  id: string;
  name: string;
  department: string;
  warningType: string;
  warningTime: string;
  status: 'valid' | 'pending' | 'invalid';
}

@Entry
@Component
struct AbnormalWarning {
  @State currentTab: number = 0;
  private  swiperController: SwiperController = new SwiperController();

  // 筛选器相关状态
  @State index: number = 5; // 默认选择6月
  @State text1: string = '6月';
  @State text2: string = '选择部门';
  @State space: number = 4;
  @State arrowPosition: ArrowPosition = ArrowPosition.END;
  @State searchText: string = '';

  // 异常警情数据
  @State warningRecords: WarningRecord[] = [
    {
      id: '1',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      warningType: '超时未签收',
      warningTime: '202104-11 10:25:45',
      status: 'valid'
    },
    {
      id: '2',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      warningType: '超时未签收',
      warningTime: '202104-11 10:25:45',
      status: 'pending'
    },
    {
      id: '3',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      warningType: '超时未签收',
      warningTime: '202104-11 10:25:45',
      status: 'invalid'
    }
  ];

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(40)
          .margin({ bottom: 30 })
          .width('10%')
          .onClick(() => {
            router.back();
          })

        Text('异常警情')
          .fontSize(20)
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('80%')

        Text('<')
          .fontSize(26)
          .fontColor('#F2F2F2')
          .margin({ bottom: 20 })
          .width('10%')
      }
      .backgroundColor('#F2F2F2')
      .width('100%')
      .height(50)
      .margin({ top: 40 })

      // 筛选器区域
      Row() {
        // 月份选择
        Select([
          { value: '1月' }, { value: '2月' }, { value: '3月' }, { value: '4月' },
          { value: '5月' }, { value: '6月' }, { value: '7月' }, { value: '8月' },
          { value: '9月' }, { value: '10月' }, { value: '11月' }, { value: '12月' }
        ])
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

        Select([
          { value: '内江市交警支队一大队' }, { value: '内江市交警支队二大队' },
          { value: '内江市交警支队三大队' }, { value: '内江市交警支队四大队' }
        ])
          .selected(0)
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
            if (text) {
              this.text2 = text;
            }
          })

        // 搜索框
        Search({ placeholder: '输入人员名称' })
          .width(120)
          .height(40)
          .backgroundColor('#FFFFFF')
          .onChange((value: string) => {
            this.searchText = value;
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor('#F5F5F5')

      // 状态标签
      Row() {
        this.buildTabItem('有效', 0)
        this.buildTabItem('待审核', 1)
        this.buildTabItem('无效', 2)
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.SpaceAround)

      // Swiper内容区域
      Swiper(this.swiperController) {
        // 有效列表
        this.buildRecordList('valid')
        // 待审核列表
        this.buildRecordList('pending')
        // 无效列表
        this.buildRecordList('invalid')
      }
      .width('100%')
      .layoutWeight(1)
      .indicator(false)
      .onChange((index: number) => {
        this.currentTab = index;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildTabItem(title: string, index: number) {
    Column() {
      Row() {
        Text(title)
          .fontSize(16)
          .fontColor(this.currentTab === index ? '#007AFF' : '#999999')
          .fontWeight(this.currentTab === index ? FontWeight.Medium : FontWeight.Normal)

        if (index === 0) {
          Text('1')
            .fontSize(12)
            .fontColor('#333333')
            .backgroundColor('#FFD700')
            .borderRadius(8)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .margin({ left: 4 })
        }
      }

      if (this.currentTab === index) {
        Divider()
          .width(40)
          .height(2)
          .color('#007AFF')
          .margin({ top: 8 })
      }
    }
    .onClick(() => {
      this.currentTab = index;
      this.swiperController.changeIndex(index);
    })
  }

  @Builder
  buildRecordList(status: string) {
    List() {
      ForEach(this.warningRecords.filter(record => record.status === status),
        (record: WarningRecord) => {
          ListItem() {
            this.buildRecordCard(record, status)
          }
          .margin({ bottom: 12 })
        })

      // 有效页面底部显示全选和无效按钮
      if (status === 'valid') {
        ListItem() {
          Row() {
            Checkbox()
              .margin({ right: 8 })

            Text('全选')
              .fontSize(16)
              .fontColor('#333333')

            Text('共20条异常警情记录')
              .fontSize(14)
              .fontColor('#666666')
              .margin({ left: 16 })

            Blank()

            Button('无效')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .backgroundColor('#007AFF')
              .borderRadius(4)
              .padding({ left: 16, right: 16, top: 6, bottom: 6 })
              .onClick(() => {
                router.pushUrl({url:"pages/ShenPiGuanLi/jixiaoqueren"})
              })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
        }
        .margin({ top: 20 })
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
  }

  @Builder
  buildRecordCard(record: WarningRecord, status: string) {
    Column() {
      Row() {
        // 有效状态显示勾选框
        if (status === 'valid') {
          Checkbox()
            .margin({ right: 12 })
        }

        Text(record.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007AFF')

        Blank()

        // 根据状态显示不同的操作按钮
        if (status === 'valid') {
          Button('无效')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#007AFF')
            .borderRadius(4)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .onClick(() => {
              router.pushUrl({url:"pages/ShenPiGuanLi/yichangwuxiao"})
            })
        } else if (status === 'pending') {
          Button('审核')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#007AFF')
            .borderRadius(4)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .onClick(() => {
              router.pushUrl({url:"pages/ShenPiGuanLi/yichangshenpi"})
            })
        } else {
          Text('>')
            .fontSize(20)
            .fontColor('#CCCCCC')
            .onClick(() => {
              router.pushUrl({url:"pages/ShenPiGuanLi/yichangxiangqin"})
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 详细信息
      Column({ space: 8 }) {
        Row() {
          Text('所属部门：')
            .fontSize(14)
            .fontColor('#666666')
          Text(record.department)
            .fontSize(14)
            .fontColor('#333333')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('异常类型：')
            .fontSize(14)
            .fontColor('#666666')
          Text(record.warningType)
            .fontSize(14)
            .fontColor('#333333')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('异常时间：')
            .fontSize(14)
            .fontColor('#666666')
          Text(record.warningTime)
            .fontSize(14)
            .fontColor('#333333')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
  }
}