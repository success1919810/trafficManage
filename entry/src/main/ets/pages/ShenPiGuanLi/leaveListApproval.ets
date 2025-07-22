import { router } from '@kit.ArkUI';

interface LeaveApplication {
  id: string;
  name: string;
  department: string;
  leaveType: string;
  leaveDate: string;
  leaveDuration: string;
  position: string;
  status: 'pending' | 'approved';
}

@Entry
@Component
struct LeaveApproval {
  @State currentMonth: number = 6;
  @State currentTab: number = 0; // 0-待审核, 1-已审核
  @State text1: string = "月份";
  @State index: number = 2;
  @State space: number = 8;
  @State arrowPosition: ArrowPosition = ArrowPosition.END;
  private swiperController: SwiperController = new SwiperController();

  @State leaveApplications: LeaveApplication[] = [
  // 待审核数据
    {
      id: '1',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      leaveType: '事假',
      leaveDate: '2021-4-15',
      leaveDuration: '8小时',
      position: '辅警',
      status: 'pending'
    },
    {
      id: '2',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      leaveType: '事假',
      leaveDate: '2021-4-15',
      leaveDuration: '8小时',
      position: '辅警',
      status: 'pending'
    },
    {
      id: '3',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      leaveType: '事假',
      leaveDate: '2021-4-15',
      leaveDuration: '8小时',
      position: '辅警',
      status: 'pending'
    },
    // 已审核数据
    {
      id: '4',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      leaveType: '事假',
      leaveDate: '2021-4-15',
      leaveDuration: '8小时',
      position: '辅警',
      status: 'approved'
    },
    {
      id: '5',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      leaveType: '事假',
      leaveDate: '2021-4-15',
      leaveDuration: '8小时',
      position: '辅警',
      status: 'approved'
    },
    {
      id: '6',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      leaveType: '事假',
      leaveDate: '2021-4-15',
      leaveDuration: '8小时',
      position: '辅警',
      status: 'approved'
    }
  ];

  build() {
    Column() {
      // 顶部导航栏
      Row(){
        Text('<')
          .fontSize(40)
          .margin({bottom:30})
          .width('10%')
          .onClick(() => {
            // 调用路由返回方法，回到上一级页面（Workbench）
            router.back();
          })
        Text('请假审批')
          .fontSize(20)
          // 去掉 bottom margin，避免干扰垂直居中
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('80%')
        Text('<')
          .fontSize(26)
          .fontColor('#F2F2F2')
          .margin({bottom:20})
          .width('10%')
      }.backgroundColor('#F2F2F2').width('100%').height(50).margin({ top: 40,bottom: 10 }); // 增加顶部外边距，值可根据实际需求调整

      Row(){
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
      }.width('100%').padding(15)

      // 状态标签
      Row() {
        Text('待审核')
          .fontSize(16)
          .fontColor(this.currentTab === 0 ? '#007AFF' : '#999999')
          .fontWeight(this.currentTab === 0 ? FontWeight.Medium : FontWeight.Normal)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.currentTab = 0;
            this.swiperController.changeIndex(0);
          })

        Text('已审核')
          .fontSize(16)
          .fontColor(this.currentTab === 1 ? '#007AFF' : '#999999')
          .fontWeight(this.currentTab === 1 ? FontWeight.Medium : FontWeight.Normal)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.currentTab = 1;
            this.swiperController.changeIndex(1);
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 20 })

      // Swiper组件
      Swiper(this.swiperController) {
        // 待审核列表
        this.buildLeaveList('pending')

        // 已审核列表
        this.buildLeaveList('approved')
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
  buildLeaveList(status: 'pending' | 'approved') {
    List() {
      ForEach(this.leaveApplications.filter(app => app.status === status), (application: LeaveApplication) => {
        ListItem() {
          this.buildLeaveCard(application)
        }
        .margin({ bottom: 12 })
      })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
  }

  @Builder
  buildLeaveCard(application: LeaveApplication) {
    Column() {
      // 姓名和审核按钮
      Row() {
        Text(application.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007AFF')

        Blank()

        // 只有待审核状态才显示审核按钮
        if (application.status === 'pending') {
          Button('审核')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#007AFF')
            .borderRadius(4)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ShenPiGuanLi/leaveApproval'
              });
            })
        }
      }
      .width('100%')
      .margin({ bottom: 16 })

      // 详细信息
      Column({ space: 8 }) {
        Row() {
          Text('所属部门：')
            .fontSize(14)
            .fontColor('#333333')
            .width(80)

          Text(application.department)
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Row() {
          Text('请假类型：')
            .fontSize(14)
            .fontColor('#333333')
            .width(80)

          Text(application.leaveType)
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Row() {
          Text('请假日期：')
            .fontSize(14)
            .fontColor('#333333')
            .width(80)

          Text(application.leaveDate)
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Row() {
          Text('请假时长：')
            .fontSize(14)
            .fontColor('#333333')
            .width(80)

          Text(application.leaveDuration)
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Row() {
          Text('职务：')
            .fontSize(14)
            .fontColor('#333333')
            .width(80)

          Text(application.position)
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
      }
      .onClick(() => {
        router.pushUrl({
          url: 'pages/ShenPiGuanLi/leaveDetail'
        });
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#00000010', offsetY: 1 })
  }
}