import { router } from '@kit.ArkUI';

@Entry
@Component
struct ApprovalManagement {
  @State message: string = 'Hello World';

  build() {
    Column(){
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
      Row().height(2).backgroundColor('#F2F2F2').width('100%')
      Row(){
        Text('值班计划审批')
          .fontSize(20)
          .margin({ bottom: 0, left: 10 }) // 左侧留 10px 空隙，可按需调整数值
          .width('80%')
        Text('>')
          .fontColor('#ADD8E6')
          .fontSize(30)
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('10%')
      }.backgroundColor('#ffffff').width('100%').height(50).justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        router.pushUrl({
          url: 'pages/ShenPiGuanLi/dutyListApproval'
        });
      })
      Row().height(2).backgroundColor('#F2F2F2').width('100%')
      Row(){
        Text('请假审批')
          .fontSize(20)
          .margin({ bottom: 0, left: 10 }) // 左侧留 10px 空隙，可按需调整数值
          .width('80%')
        Text('>')
          .fontSize(30)
          .fontColor('#ADD8E6')
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('10%')
      }.backgroundColor('#ffffff').width('100%').height(50).justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        router.pushUrl({
          url: 'pages/ShenPiGuanLi/leaveListApproval'
        });
      })
      Row().height(2).backgroundColor('#F2F2F2').width('100%')
      Row(){
        Text('值班记录审批')
          .fontSize(20)
          .margin({ bottom: 0, left: 10 }) // 左侧留 10px 空隙，可按需调整数值
          .width('80%')
        Text('>')
          .fontSize(30)
          .fontColor('#ADD8E6')
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('10%')
      }.backgroundColor('#ffffff').width('100%').height(50).justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        router.pushUrl({
          url: 'pages/ShenPiGuanLi/dutyRecordListApproval'
        });
      })
      Row().height(2).backgroundColor('#F2F2F2').width('100%')
      Row(){
        Text('异常勤务审批')
          .fontSize(20)
          .margin({ bottom: 0, left: 10 }) // 左侧留 10px 空隙，可按需调整数值
          .width('80%')
        Text('>')
          .fontSize(30)

          .fontColor('#ADD8E6')
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('10%')
      }.backgroundColor('#ffffff').width('100%').height(50).justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        router.pushUrl({
          url: 'pages/ShenPiGuanLi/abnormalServiceListApproval'
        });
      })
      Row().height(2).backgroundColor('#F2F2F2').width('100%')
      Row(){
        Text('绩效考核审批')
          .fontSize(20)
          .margin({ bottom: 0, left: 10 }) // 左侧留 10px 空隙，可按需调整数值
          .width('80%')
        Text('>')
          .fontSize(30)

          .fontColor('#ADD8E6')
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('10%')
      }
      .onClick(() => {
        router.pushUrl({
          url: 'pages/ShenPiGuanLi/performanceTestListApproval'
        });
      })
      .backgroundColor('#ffffff').width('100%').height(50).justifyContent(FlexAlign.SpaceBetween)
      Row().height(2).backgroundColor('#F2F2F2').width('100%')
      Row(){
        Text('异常警勤审批')
          .fontSize(20)
          .margin({ bottom: 0, left: 10 }) // 左侧留 10px 空隙，可按需调整数值
          .width('80%')
        Text('>')
          .fontSize(30)

          .fontColor('#ADD8E6')
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('10%')
      }
      .onClick(() => {
        router.pushUrl({
          url: 'pages/ShenPiGuanLi/abnormalCaseListApproval'
        });
      })
      .backgroundColor('#ffffff').width('100%').height(50).justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start);
  }
}