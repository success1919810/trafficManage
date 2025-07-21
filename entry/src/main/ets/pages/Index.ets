import { mapinindex } from './map';
import { home } from './home';
import { Workbench } from './Workbench';


@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

  @Builder
  myTabsBar(img: Resource, title: string, index: number) {
    Column({ space: 5 }) {
      //图片
      Image(img)
        .fillColor(this.currentIndex == index ? '#000000' : '#0000ff')
        .width(30)
        .height(30)
      //文字
      Text(title)
        .fontSize(20)
        .fontColor('#999999')

    }
    .width('100%')
    .height('100%')
  }

  build() {

      Tabs({barPosition:BarPosition.End}) {
        TabContent() {
          home()
        }.tabBar(this.myTabsBar($r('app.media.home'), '首页', 0))

        TabContent() {
          Workbench()
        }.tabBar(this.myTabsBar($r('app.media.work'), '工作', 1))

        TabContent() {
          mapinindex()
        }.tabBar(this.myTabsBar($r("app.media.map2"), '地图', 2))

        TabContent() {
          Text('1')
        }.tabBar(this.myTabsBar($r('app.media.myy'), '我的', 3))

      }
      .onChange(index =>{
        this.currentIndex = index
      })

  }
}

function work() {
  throw new Error('Function not implemented.');
}
