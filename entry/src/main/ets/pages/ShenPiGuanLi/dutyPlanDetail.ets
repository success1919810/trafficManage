//未绑定二级界面
import { router } from '@kit.ArkUI';

interface DutyDetail {
  location: string;
  dutyType: string;
  dutySubType: string;
  shiftName: string;
}

@Entry
@Component
struct DutyPlanDetail {
  @State planId: string = '';
  @State department: string = '内江市交警支队一大队';
  @State dutyDate: string = '2021-4-8';

  @State dutyDetails: DutyDetail[] = [
    {
      location: '内江收费站',
      dutyType: '部门值班',
      dutySubType: '常班领导',
      shiftName: '早班'
    },
    {
      location: '',
      dutyType: '',
      dutySubType: '值班民警',
      shiftName: '晚班'
    },
    {
      location: '汉安大道中段75',
      dutyType: '执法站勤务',
      dutySubType: '路面拦截',
      shiftName: '早班'
    },
    {
      location: '',
      dutyType: '',
      dutySubType: '指挥调度',
      shiftName: '晚班'
    },
    {
      location: '林海大桥',
      dutyType: '事故处理',
      dutySubType: '事故鉴定',
      shiftName: '早班'
    },
    {
      location: '',
      dutyType: '',
      dutySubType: '事故处理',
      shiftName: '晚班'
    }
  ];

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params.planId) {
      this.planId = params.planId as string;
    }
  }

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
      }.backgroundColor('#F2F2F2').width('100%').height(50).margin({ top: 40 }); // 增加顶部外边距，值可根据实际需求调整

      // 基本信息
      Column() {
        Row() {
          Text('勤务部门')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.department)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider()
          .color('#E5E5E5')

        Row() {
          Text('值班日期')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.dutyDate)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 可滑动表格
      Scroll(new Scroller()) {
        Column() {
          // 表格头部
          Row() {
            Text('执勤点')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width(120)
              .textAlign(TextAlign.Center)
              .padding(12)
              .backgroundColor('#F8F8F8')

            Text('勤务类型')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width(120)
              .textAlign(TextAlign.Center)
              .padding(12)
              .backgroundColor('#F8F8F8')

            Text('勤务子类型')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width(120)
              .textAlign(TextAlign.Center)
              .padding(12)
              .backgroundColor('#F8F8F8')

            Text('班次名称')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width(120)
              .textAlign(TextAlign.Center)
              .padding(12)
              .backgroundColor('#F8F8F8')

            Text('班次时段')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width(120)
              .textAlign(TextAlign.Center)
              .padding(12)
              .backgroundColor('#F8F8F8')

            Text('值班警员')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width(120)
              .textAlign(TextAlign.Center)
              .padding(12)
              .backgroundColor('#F8F8F8')

            Text('巡逻方式')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width(120)
              .textAlign(TextAlign.Center)
              .padding(12)
              .backgroundColor('#F8F8F8')

            Text('车牌号码')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width(120)
              .textAlign(TextAlign.Center)
              .padding(12)
              .backgroundColor('#F8F8F8')
          }
          .border({ width: { bottom: 1 }, color: '#E5E5E5' })

          // 表格内容
          ForEach(this.dutyDetails, (detail: DutyDetail, index: number) => {
            Row() {
              Text(detail.location)
                .fontSize(14)
                .fontColor('#333333')
                .width(120)
                .textAlign(TextAlign.Center)
                .padding(12)

              Text(detail.dutyType)
                .fontSize(14)
                .fontColor('#333333')
                .width(120)
                .textAlign(TextAlign.Center)
                .padding(12)

              Text(detail.dutySubType)
                .fontSize(14)
                .fontColor('#333333')
                .width(120)
                .textAlign(TextAlign.Center)
                .padding(12)

              Text(detail.shiftName)
                .fontSize(14)
                .fontColor('#333333')
                .width(120)
                .textAlign(TextAlign.Center)
                .padding(12)
            }
            .border({ width: { bottom: 1 }, color: '#E5E5E5' })
          })
        }
        .width(480) // 固定宽度以支持横向滚动
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.On)
      .margin({ top: 20 })
      .backgroundColor('#FFFFFF')

      Blank()


    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}