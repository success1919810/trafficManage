import router from '@ohos.router'
import { sg0 } from './zujian/sg0';
import { sg1 } from './zujian/sg1';
import { sg2 } from './zujian/sg2';

@Entry
@Component
struct Shigong {
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
    Column({space:15}){
      Stack(){
        Text('施工占道')
          .fontColor('#000000')
          .fontSize(20)
          .width('100%')
          .height(30)
          .backgroundColor('#ffffff')
          .textAlign(TextAlign.Center)
        Text('<')
          .fontSize(30)
          .onClick(() => router.back())
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .backgroundColor('#ffffff')
      Search({placeholder:'输入路段名称搜索'})
        .height(40)
        .backgroundColor('#FAFAFA')
        .borderRadius(10)
        .textAlign(TextAlign.Start)
      Tabs({barPosition:BarPosition.Start}){
        TabContent() {
        sg0()
        }.tabBar(this.myTabsBar( '全部', 0))
        .backgroundColor('#FAFAFA')
        TabContent() {
          sg1()
        }.tabBar(this.myTabsBar( '正常', 1))
        .backgroundColor('#FAFAFA')
        TabContent() {
          sg2()
        }.tabBar(this.myTabsBar( '隐患', 2))
        .backgroundColor('#FAFAFA')
      }
      .backgroundColor('#FFFFFF')
      .width('100%')
      .onChange(index =>{
        this.currentIndex = index
      })
    }
    .padding({top: px2vp(this.topRectHeight),bottom:px2vp(this.bottomRectHeight)})
    .height('100%')
    .width('100%')
  }
}