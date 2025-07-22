import { router } from '@kit.ArkUI';

@Entry
@Component
struct LeaveApprovalDetail {
  @State leaveId: string = '';
  @State leaveNumber: string = 'qj20210411001';
  @State applicantName: string = '张亚飞';
  @State department: string = '内江市交警支队一大队';
  @State duty: string = '辅警';
  @State applyTime: string = '2021-4-08 10:01:20';
  @State leaveType: string = '事假';
  @State startTime: string = '2021-4-11 08:30:00';
  @State endTime: string = '2021-4-11 17:30:00';
  @State duration: string = '8小时';
  @State reason: string = '家里有事请假1天';

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params.leaveId) {
      this.leaveId = params.leaveId as string;
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


        Text('审核')
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

      // 请假详情信息
      Column() {
        // 请假编号
        Row() {
          Text('请假编号')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.leaveNumber)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E5E5E5')

        // 请假人员
        Row() {
          Text('请假人员')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.applicantName)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E5E5E5')

        // 所属部门
        Row() {
          Text('所属部门')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.department)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E5E5E5')

        // 职务
        Row() {
          Text('职务')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.duty)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E5E5E5')

        // 请假时间
        Row() {
          Text('请假时间')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.applyTime)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E5E5E5')

        // 请假类型
        Row() {
          Text('请假类型')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.leaveType)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E5E5E5')

        // 请假起始时间
        Row() {
          Text('请假起始时间')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.startTime)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E5E5E5')

        // 请假结束时间
        Row() {
          Text('请假结束时间')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.endTime)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E5E5E5')

        // 请假时长
        Row() {
          Text('请假时长')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.duration)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E5E5E5')

        // 请假描述
        Row() {
          Text('请假描述')
            .fontSize(16)
            .fontColor('#333333')

          Blank()

          Text(this.reason)
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .alignItems(VerticalAlign.Top)
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .margin({ top: 10 })

      // 关联值班计划按钮
      Button('关联值班计划')
        .fontSize(16)
        .fontColor('#FFFFFF')
        .backgroundColor('#007AFF')
        .borderRadius(8)
        .width('90%')
        .height(44)
        .margin({ top: 30 })
        .onClick(() => {
          // 关联值班计划逻辑
          console.log('关联值班计划');
        })

      Blank()

      // 底部操作按钮
      Row() {
        Button('驳回')
          .fontSize(16)
          .fontColor('#666666')
          .backgroundColor('#E5E5E5')
          .borderRadius(8)
          .width('40%')
          .height(44)
          .onClick(() => {
            // 驳回逻辑
            router.back();
          })

        Button('通过')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .backgroundColor('#007AFF')
          .borderRadius(8)
          .width('40%')
          .height(44)
          .onClick(() => {
            // 通过逻辑
            router.back();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ left: 16, right: 16, bottom: 30 })
    }
    .width('100%')
    .height('100%')
  }
}