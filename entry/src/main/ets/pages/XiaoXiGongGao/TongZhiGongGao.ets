import router from '@ohos.router';

@Entry
@Component
struct Tongzhigonggao {
  @State message: string = 'Hello World';

  build() {
Column() {
  Column().height('30')
    .width('100%')
    .backgroundColor('#ffffff')
  Row() {
    Button('<')
      .fontSize(22)
      .backgroundColor('#007AFF') // 主色调背景
      .fontColor('#FFFFFF')
      .borderRadius(5)
      .padding({ left: 10, right: 10 })
      .onClick(() => router.back());

    // 标题（居中）
    Text('通知公告')
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

Column(){
  Text('2021年劳动节假日通知')
    .fontSize(20)
    .margin('10')
  Row() {
    Text('袁诗诗-行政部发布')
      .fontColor('#800080')
    Text('2021年4月24日15:11:25')
      .fontColor('#808080')
  }.justifyContent(FlexAlign.SpaceBetween)
  .width('95%')
  .margin('10')
}.backgroundColor('#FFFFFF')
Text('这里是通知内容这里是通知内容这里是通知内容这里是通知内容这里是通知内容这里是通知内容这里是通知内容这里是通知内容这里是通知内容这里是通知内容这里是通知内容')
  .width('95%')
  .height('50%')
  .backgroundColor('#ffffff')
  .borderRadius(15)
  .margin(10)

  Row(){
    Text('附件：')
      .fontColor('#000000')
    Text('2021年劳动节放假通知.pdf')
      .fontColor('#0000ff')
  }.width('100%')
  .margin(20)

}.backgroundColor('#f0f0f0')
    .height('100%')
  }
}