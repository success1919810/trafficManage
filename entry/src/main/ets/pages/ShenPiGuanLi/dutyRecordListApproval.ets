import { router } from '@kit.ArkUI';

interface DutyRecord {
  id: string;
  name: string;
  department: string;
  dutyPoint: string;
  dutyDate: string;
  shiftTime: string;
  status: 'pending' | 'approved';
}

@Entry
@Component
struct DutyRecordApproval {
  @State currentMonth: number = 6;
  @State selectedDepartment: string = '选择部门';
  @State currentTab: number = 0; // 0-待审核, 1-已审核
  @State searchText: string = '';
  @State text1: string = "月份";
  @State text2: string = "选择部门";
  @State index: number = 2;
  @State space: number = 8;
  @State arrowPosition: ArrowPosition = ArrowPosition.END;

  @State dutyRecords: DutyRecord[] = [
    {
      id: '1',
      name: '张三三',
      department: 'XX市交警支队一大队',
      dutyPoint: '巡区一区',
      dutyDate: '2020-4-41',
      shiftTime: '8:30:00-12:00:00',
      status: 'pending'
    },
    {
      id: '2',
      name: '张三三',
      department: 'XX市交警支队一大队',
      dutyPoint: '巡区一区',
      dutyDate: '2020-4-41',
      shiftTime: '8:30:00-12:00:00',
      status: 'pending'
    },
    {
      id: '3',
      name: '张三三',
      department: 'XX市交警支队一大队',
      dutyPoint: '巡区一区',
      dutyDate: '2020-4-41',
      shiftTime: '8:30:00-12:00:00',
      status: 'pending'
    },
    {
      id: '4',
      name: '李四四',
      department: 'XX市交警支队二大队',
      dutyPoint: '巡区二区',
      dutyDate: '2020-4-40',
      shiftTime: '14:00:00-18:00:00',
      status: 'approved'
    }
  ];

  private swiperController: SwiperController = new SwiperController();

  build() {
    Column() {
      // 标题栏 - 使用您提供的模板
      Row(){
        Text('<')
          .fontSize(40)
          .margin({bottom:30})
          .width('10%')
          .onClick(() => {
            router.back();
          })

        Text('值班记录审批')
          .fontSize(20)
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('80%')

        Text('<')
          .fontSize(26)
          .fontColor('#F2F2F2')
          .margin({bottom:20})
          .width('10%')
      }.backgroundColor('#F2F2F2').width('100%').height(50).margin({ top: 40 });

      Row().height(2).backgroundColor('#F2F2F2').width('100%')

      // 筛选器区域
      Row() {
        // 月份选择
        Row() {
          Select([{ value: '一月' }, { value: '二月' },{ value: '三月' },{ value: '四月' },{ value: '五月' },{ value: '六月' },{ value: '七月' },{ value: '八月' },{ value: '九月' },{ value: '十月' },{ value: '十一月' },{ value: '十二月' }])
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
        // 部门选择
        Row() {
          Select([{ value: '内江市交警支队一大队' }, { value: '内江市交警支队二大队' },{ value: '内江市交警支队三大队' },{ value: '内江市交警支队四大队' }])
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

        Blank()

        // 搜索框
        Row() {
          Text('🔍')
            .fontSize(16)
            .fontColor('#999999')
            .margin({ right: 8 })

          Text('输入人员姓名进行搜索')
            .fontSize(14)
            .fontColor('#CCCCCC')
        }
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .backgroundColor('#FFFFFF')
        .borderRadius(4)
        .width(180)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor('#F5F5F5')

      // 状态标签
      Row() {
        Text('待审核')
          .fontSize(16)
          .fontColor(this.currentTab === 0 ? '#007AFF' : '#999999')
          .fontWeight(this.currentTab === 0 ? FontWeight.Medium : FontWeight.Normal)
          .onClick(() => {
            this.currentTab = 0;
            this.swiperController.changeIndex(0);
          })

        Blank()

        Text('已审核')
          .fontSize(16)
          .fontColor(this.currentTab === 1 ? '#007AFF' : '#999999')
          .fontWeight(this.currentTab === 1 ? FontWeight.Medium : FontWeight.Normal)
          .onClick(() => {
            this.currentTab = 1;
            this.swiperController.changeIndex(1);
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
      .backgroundColor('#F5F5F5')

      // Swiper内容区域
      Swiper(this.swiperController) {
        // 待审核列表
        this.buildRecordList('pending')

        // 已审核列表
        this.buildRecordList('approved')
      }
      .width('100%')
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentTab = index;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildRecordList(status: string) {
    List() {
      ForEach(this.dutyRecords.filter(record =>
      status === 'pending' ? record.status === 'pending' : record.status === 'approved'
      ), (record: DutyRecord) => {
        ListItem() {
          this.buildRecordCard(record)
        }
        .margin({ bottom: 12 })
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
  }

  @Builder
  buildRecordCard(record: DutyRecord) {
    Column() {
      // 卡片头部 - 姓名和按钮
      Row() {
        Text(record.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007AFF')

        Blank()

        if (record.status === 'pending') {
          Button('审核')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#007AFF')
            .borderRadius(4)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ShenPiGuanLi/dutyRecordApproval'
              });
            })
        } else {
          Text('>')
            .fontSize(20)
            .fontColor('#CCCCCC')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ShenPiGuanLi/dutyRecordDetail'
              });
            })
        }
      }
      .width('100%')
      .margin({ bottom: 16 })

      // 详细信息
      Column({ space: 8 }) {
        Row() {
          Text('管理部门：')
            .fontSize(14)
            .fontColor('#333333')
            .width(80)

          Text(record.department)
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('执勤点：')
            .fontSize(14)
            .fontColor('#333333')
            .width(80)

          Text(record.dutyPoint)
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('值班日期：')
            .fontSize(14)
            .fontColor('#333333')
            .width(80)

          Text(record.dutyDate)
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('班次时段：')
            .fontSize(14)
            .fontColor('#333333')
            .width(80)

          Text(record.shiftTime)
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#00000010', offsetY: 1 })
  }
}