import { router } from '@kit.ArkUI';

interface DutyPlan {
  id: string;
  date: string;
  department: string;
  dutyPoints: number;
  dutyPersons: number;
  policeVehicles: number;
  status: 'pending' | 'approved';
}

@Entry
@Component
struct DutyPlanApproval {
  @State arrowPosition: ArrowPosition = ArrowPosition.END;
  @State currentMonth: number = 6;
  @State selectedDepartment: string = '选择部门';
  @State currentTab: number = 0; // 0-待审核, 1-已审核
  @State text1: string = "月份";
  @State text2: string = "选择部门";
  @State index: number = 2;
  @State space: number = 8;

  @State dutyPlans: DutyPlan[] = [
  // 待审核数据
    {
      id: '1',
      date: '2021-4-8',
      department: '内江市交警支队一大队',
      dutyPoints: 20,
      dutyPersons: 30,
      policeVehicles: 3,
      status: 'pending'
    },
    {
      id: '2',
      date: '2021-4-8',
      department: '内江市交警支队一大队',
      dutyPoints: 20,
      dutyPersons: 30,
      policeVehicles: 3,
      status: 'pending'
    },
    {
      id: '3',
      date: '2021-4-8',
      department: '内江市交警支队一大队',
      dutyPoints: 20,
      dutyPersons: 30,
      policeVehicles: 3,
      status: 'pending'
    },
    // 已审核数据（相同内容）
    {
      id: '4',
      date: '2021-4-8',
      department: '内江市交警支队一大队',
      dutyPoints: 20,
      dutyPersons: 30,
      policeVehicles: 3,
      status: 'approved'
    },
    {
      id: '5',
      date: '2021-4-8',
      department: '内江市交警支队一大队',
      dutyPoints: 20,
      dutyPersons: 30,
      policeVehicles: 3,
      status: 'approved'
    },
    {
      id: '6',
      date: '2021-4-8',
      department: '内江市交警支队一大队',
      dutyPoints: 20,
      dutyPersons: 30,
      policeVehicles: 3,
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


        Text('审批管理')
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
      }
      .backgroundColor('#F2F2F2').width('100%').height(50).margin({ top: 40 }); // 增加顶部外边距，值可根据实际需求调整
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
            .avoidance(AvoidanceMode.COVER_TARGET)
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
            .avoidance(AvoidanceMode.COVER_TARGET)
        }
        Blank()
      }
      .onClick(() => {
        router.pushUrl({
          url: 'pages/ShenPiGuanLi/dutyPlanDetail'
        });
      })
      .width('100%')
      .padding({ left: 16, right: 16, top: 10, bottom: 20 })

      // 状态标签
      Row() {
        Text('待审核')
          .fontSize(16)
          .fontColor(this.currentTab === 0 ? '#007AFF' : '#999999')
          .fontWeight(this.currentTab === 0 ? FontWeight.Medium : FontWeight.Normal)
          .onClick(() => this.currentTab = 0)

        Blank()

        Text('已审核')
          .fontSize(16)
          .fontColor(this.currentTab === 1 ? '#007AFF' : '#999999')
          .fontWeight(this.currentTab === 1 ? FontWeight.Medium : FontWeight.Normal)
          .onClick(() => this.currentTab = 1)
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 20 })
      .justifyContent(FlexAlign.SpaceAround)

      // 审批卡片列表
      List() {
        ForEach(this.dutyPlans.filter(plan =>
        this.currentTab === 0 ? plan.status === 'pending' : plan.status === 'approved'
        ), (plan: DutyPlan) => {
          ListItem() {
            this.buildDutyCard(plan)
          }
          .margin({ bottom: 12 })
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildDutyCard(plan: DutyPlan) {
    Column() {
      // 卡片头部
      Row() {
        Text(`执勤日期：`)
          .fontSize(14)
          .fontColor('#333333')

        Text(plan.date)
          .fontSize(14)
          .fontColor('#007AFF')

        Blank()

        // 只有待审核状态才显示审核按钮
        if (plan.status === 'pending') {
          Button('审核')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#007AFF')
            .borderRadius(4)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ShenPiGuanLi/dutyPlanApproval'
              });
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 执勤部门
      Row() {
        Text(`执勤部门：`)
          .fontSize(14)
          .fontColor('#333333')

        Text(plan.department)
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .margin({ bottom: 8 })

      // 统计信息
      Row() {
        Column() {
          Row() {
            Text(`执勤点：`)
              .fontSize(14)
              .fontColor('#333333')

            Text(`${plan.dutyPoints}个`)
              .fontSize(14)
              .fontColor('#666666')
          }
          .margin({ bottom: 4 })

          Row() {
            Text(`警车：`)
              .fontSize(14)
              .fontColor('#333333')

            Text(`${plan.policeVehicles}辆`)
              .fontSize(14)
              .fontColor('#666666')
          }
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(`值班人员：`)
          .fontSize(14)
          .fontColor('#333333')

        Text(`${plan.dutyPersons}个`)
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#00000010', offsetY: 1 })
  }
}