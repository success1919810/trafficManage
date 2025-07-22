import router from '@ohos.router';



@Entry
@Component
struct Jingqingqianshou {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
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
        Text('任务签收')
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
      Row(){
        Text('任务编号')

        Text('TZ20211230001')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      .margin({top:10})
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('任务人员')

        Text('张亚飞')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('所属部门')

        Text('内江市交警支队一大队')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('任务名称')

        Text('12月份领导视察')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('任务地点')

        Text('金科北路122号')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('任务时间')

        Text('2021-12-30 14:00:00')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
    }
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight)})
  }
}