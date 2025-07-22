import { router } from '@kit.ArkUI';

interface PerformanceRecord {
  id: string;
  name: string;
  department: string;
  score: number;
  period: string;
  status: 'pending' | 'feedback' | 'confirm' | 'completed';
}

@Entry
@Component
struct PerformanceApproval {
  @State currentTab: number = 0;
  private  swiperController: SwiperController = new SwiperController();

  // 筛选器相关状态
  @State index: number = 5; // 默认选择6月
  @State text1: string = '6月';
  @State text2: string = '选择部门';
  @State space: number = 4;
  @State arrowPosition: ArrowPosition = ArrowPosition.END;

  // 绩效考核数据
  @State performanceRecords: PerformanceRecord[] = [
    {
      id: '1',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      score: 93,
      period: '2021-4',
      status: 'pending'
    },
    {
      id: '2',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      score: 93,
      period: '2021-4',
      status: 'feedback'
    },
    {
      id: '3',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      score: 93,
      period: '2021-4',
      status: 'confirm'
    },
    {
      id: '4',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      score: 93,
      period: '2021-4',
      status: 'completed'
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

        Text('绩效考核审批')
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
          .avoidance(AvoidanceMode.COVER_TARGET)

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
          .avoidance(AvoidanceMode.COVER_TARGET)

        Blank()
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor('#F5F5F5')

      // 状态标签
      Row() {
        this.buildTabItem('待审核', 0)
        this.buildTabItem('待反馈', 1)
        this.buildTabItem('待确认', 2)
        this.buildTabItem('已完成', 3)
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.SpaceAround)

      // Swiper内容区域
      Swiper(this.swiperController) {
        // 待审核列表
        this.buildRecordList('pending')
        // 待反馈列表
        this.buildRecordList('feedback')
        // 待确认列表
        this.buildRecordList('confirm')
        // 已完成列表
        this.buildRecordList('completed')
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
          Text('5')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF3B30')
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
      ForEach(this.performanceRecords.filter(record => record.status === status),
        (record: PerformanceRecord) => {
          ListItem() {
            this.buildRecordCard(record, status)
          }
          .margin({ bottom: 12 })
        })
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
  }

  @Builder
  buildRecordCard(record: PerformanceRecord, status: string) {
    Column() {
      Row() {
        // 待审核状态显示勾选框
        if (status === 'pending') {
          Checkbox()
            .margin({ right: 12 })
        }

        Text(record.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007AFF')

        Blank()

        // 根据状态显示不同的操作按钮
        if (status === 'pending') {
          Button('审核')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#007AFF')
            .borderRadius(4)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ShenPiGuanLi/jixiaoshenpi'
              });
            })
        }
        else if (status === 'confirm') {
          Button('确认')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#007AFF')
            .borderRadius(4)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ShenPiGuanLi/jixiaoqueren'
              });
            })
        }
        else if(status === 'feedback'){
          Button('反馈按钮')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#007AFF')
            .borderRadius(4)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ShenPiGuanLi/jixiaofankui'
              });
            })
        }
        else {
          Button('确认')
            .fontSize(20)
            .fontColor('#CCCCCC')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ShenPiGuanLi/jixiaoxiangqin'
              });
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
          Text('绩效分数：')
            .fontSize(14)
            .fontColor('#666666')
          Text(record.score.toString())
            .fontSize(14)
            .fontColor('#333333')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('考核周期：')
            .fontSize(14)
            .fontColor('#666666')
          Text(record.period)
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