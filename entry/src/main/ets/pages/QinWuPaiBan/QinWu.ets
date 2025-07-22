import { rzhiban } from '../zujian/7rzhiban';
import { yzhiban } from '../zujian/1yzhiban';
import router from '@ohos.router'
@Entry
@Component
struct Qinwu {
  @State currentIndex: number = 0;
  @Builder
  myTabsBar(title: string, index: number) {
    Column({ space: 5 }) {
      //文字
      Text(title)
        .fontSize(20)
        .fontColor(this.currentIndex == index ? '#0099FF' : '#000000')
    }
  }
  @StorageProp('bottomRectHeight')
  bottomRectHeight:number = 0;
  @StorageProp('topRectHeight')
  topRectHeight:number = 0;
  build() {
    Column(){
      Stack(){
      Text('值班计划列表')
        .fontColor('#000000')
        .fontSize(20)
        .width('100%')
        .height(50)
        .backgroundColor('#F2F2F2')
        .textAlign(TextAlign.Center)
      Text('<')
        .fontSize(50)
        .onClick(() => router.back())
        .width('100%')
        .textAlign(TextAlign.Start)
    }
      Stack(){
        Tabs({barPosition:BarPosition.Start}){
          TabContent() {
            rzhiban()
          }.tabBar(this.myTabsBar( '近七日值班', 0))

          TabContent() {
            yzhiban()
          }.tabBar(this.myTabsBar( '近一月值班', 1))
        }
        .width('100%')
        .onChange(index =>{
          this.currentIndex = index
        })
        Text('历史值班')
          .fontColor('#ffffff')
          .fontSize(20)
          .width('100%')
          .height(50)
          .borderRadius(5)
          .backgroundColor('#0099ff')
          .textAlign(TextAlign.Center)
          .position({bottom:25})
      }

    }
    .padding({top: px2vp(this.topRectHeight),bottom:px2vp(this.bottomRectHeight)})
    .width('100%')
    .height('100%')
  }
}