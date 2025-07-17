import router from '@ohos.router';
interface Item1 {
  contents: string;
  location: string;
  createdAt: Date;
  actionText1: string;
  actionText2: string;
}

interface Item2 {
  contents: string;
  location: string;
  createdAt: Date;
  actionText1: string;
}
interface Item3 {
  contents: string;
  location: string;
  createdAt: Date;
}

// 格式化日期工具函数
function formatDate(date: Date): string {
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const day = date.getDate();
  return `${year}年${month}月${day}日`;
}
@Entry
@Component
struct Teqinrenwu {
  swiper: SwiperController = new SwiperController();
  @State currentIndex: number = 0;

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(22)
          .backgroundColor('#007AFF') // 主色调背景
          .fontColor('#FFFFFF')
          .borderRadius(5)
          .padding({ left: 10, right: 10 })
          .onClick(() => router.back());
        Text('特勤任务')
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


      // 消息/公告标签栏（核心修改部分）
      Row() {
        // 消息标签
        Text('待签收')
          .fontSize(26)
          .fontWeight(700)
          // 文字颜色：当前索引为0时变蓝
          .fontColor(this.currentIndex === 0 ? '#0000FF' : '#000000')
          // 下划线：当前索引为0时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(0);
          });

        // 公告标签
        Text('待反馈')
          .fontSize(26)
          .fontWeight(700)
          // 文字颜色：当前索引为1时变蓝
          .fontColor(this.currentIndex === 1 ? '#0000FF' : '#000000')
          // 下划线：当前索引为1时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(1);
          });

        Text('已完成')
          .fontSize(26)
          .fontWeight(700)
          // 文字颜色：当前索引为0时变蓝
          .fontColor(this.currentIndex === 2 ? '#0000FF' : '#000000')
          // 下划线：当前索引为0时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(2);
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .margin({ top: 20 });

      // 内容切换区域
      Swiper(this.swiper) {
        daiqianshou()
        daifankui()
        yiwancheng()
      }
      .onChange(index => {
        this.currentIndex = index; // 切换时同步更新状态
      })
      .width('100%')
      .height('70%'); // 调整高度避免内容溢出
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5');
  }
}

@Component
struct daiqianshou {
  datas: Item1[] = [
    { createdAt: new Date('2021-04-21'),contents: '任务名称： 12月份领导视察',location:'任务地点： 金科北路122号',actionText1:'签收',actionText2:'返回'  },
  ];

  @Builder
  myItemUI(item: Item1) {
    Row() {
      Column() {
        Text(formatDate(item.createdAt))
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontColor('#0000ff');
        Text(item.contents)
          .fontSize(16)
          .fontColor('#999999');
        Column({ space: 10 }) {
          Text(item.location)
            .fontSize(16)
            .fontWeight(FontWeight.Bold);
          Row({space:15}){
            Button(item.actionText1)
              .width('45%')
              .height(40)
              .fontSize(16)
              .backgroundColor('#007AFF')
              .fontColor('#FFFFFF')
              .borderRadius(6)

            Button(item.actionText2)
              .width('45%')
              .height(40)
              .fontSize(16)
              .backgroundColor('#007AFF')
              .fontColor('#FFFFFF')
              .borderRadius(6)
          }
        }
      }
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#FFFFFF') // 改用白色背景更美观
    .borderRadius(15)
    .margin({ top: 20 })
    .shadow({ radius: 3, color: '#00000010' });
  }

  @State isRefresh:boolean =false

  build() {
    Refresh({refreshing:this.isRefresh,promptText:'努力加载中...'}){
      List() {
        ForEach(this.datas, (item: Item1) => {
          ListItem(){this.myItemUI(item)}
        })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 });
    }.onRefreshing(()=>{this.isRefresh=true
      setTimeout(()=>{this.isRefresh=false},2000)})

  }
}

// 公告组件
@Component
struct daifankui {
  datas: Item2[] = [
    { createdAt: new Date('2021-04-21'),contents: '任务名称： 12月份领导视察',location:'任务地点： 金科北路122号',actionText1:'反馈'  },
  ];

  @Builder
  myItemUI(item: Item2) {
    Row() {
      Column({ space: 10 }) {
        Text(formatDate(item.createdAt))
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontColor('#0000ff');
        Text(item.contents)
          .fontSize(16)
          .fontColor('#999999')
          .maxLines(3)
        Text(item.location)
          .fontSize(16)
          .fontWeight(FontWeight.Bold);
        Button(item.actionText1)
          .width('45%')
          .height(40)
          .fontSize(16)
          .backgroundColor('#007AFF')
          .fontColor('#FFFFFF')
          .borderRadius(6)
      }
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#FFFFFF') // 改用白色背景更美观
    .borderRadius(15)
    .margin({ top: 20 })
    .shadow({ radius: 3, color: '#00000010' });
  }

  @State isRefresh:boolean =false

  build() {
    Refresh({refreshing:this.isRefresh,promptText:'努力加载中...'}){
      List(){
        ForEach(this.datas, (item: Item2) => {
          ListItem(){this.myItemUI(item)}
        });


      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 });
    }.onRefreshing(()=>{this.isRefresh=true
      setTimeout(()=>{this.isRefresh=false},2000)})

  }
}

@Component
struct yiwancheng {
  datas: Item3[] = [
    { createdAt: new Date('2021-04-21'),contents: '任务名称： 12月份领导视察',location:'任务地点： 金科北路122号' },
  ];

  @Builder
  myItemUI(item: Item3) {
    Row() {
      Column({ space: 10 }) {

        Text(formatDate(item.createdAt))
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontColor('#0000ff');
        Text(item.contents)
          .fontSize(16)
          .fontColor('#999999')
          .maxLines(3)
        Text(item.location)
          .fontSize(16)
          .fontWeight(FontWeight.Bold);
      }
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#FFFFFF') // 改用白色背景更美观
    .borderRadius(15)
    .margin({ top: 20 })
    .shadow({ radius: 3, color: '#00000010' });
  }

  @State isRefresh:boolean =false

  build() {
    Refresh({refreshing:this.isRefresh,promptText:'努力加载中...'}){
      List(){
        ForEach(this.datas, (item: Item3) => {
          ListItem(){this.myItemUI(item)}
        });

      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 });
    }.onRefreshing(()=>{this.isRefresh=true
      setTimeout(()=>{this.isRefresh=false},2000)})

  }
}