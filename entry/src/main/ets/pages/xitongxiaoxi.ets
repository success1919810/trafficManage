import router from '@ohos.router';

@Entry
@Component
struct Xitongxiaoxi {
  @State message: string = 'Hello World';

  build() {
    Column(){
      Row(){
        Button('<')
          .fontSize(22)
          .backgroundColor('#007AFF') // 主色调背景
          .fontColor('#FFFFFF')
          .borderRadius(5)
          .padding({ left: 10, right: 10 })
          .onClick(() => router.back());

        // 标题（居中）
        Text('系统消息')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF');

        // 占位（保持标题居中）
        Row().width(40)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#007AFF') // 导航栏主色调
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 15, right: 15 })
      .margin({ top: 20 }) // 顶部间距


      Text('这里是系统消息这里是系统消息这里是系统消息这里是系统消息这里是系统消息这里是系统消息这里是系统消息这里是系统消息这里是系统消息这里是系统消息这里是系统消息')
        .width('80%')
        .margin({top:40})
      Row(){
        Row().width('40')
        Text('2021年4月24日15:11:25')
          .margin({top:30})
      }.width('80%')
      .justifyContent(FlexAlign.SpaceBetween)

      }
    }
  }
