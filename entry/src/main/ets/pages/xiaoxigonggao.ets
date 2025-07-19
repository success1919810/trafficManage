import router from '@ohos.router';


interface Item1 {
  title: string;
  contents: string;
  createdAt: Date;
}

interface Item2 {
  title: string;
  contents: string;
  createdAt: Date;
}

function formatDate(date: Date): string {
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const day = date.getDate();
  return `${year}年${month}月${day}日`;
}

@Entry
@Component
struct Xiaoxigonggao {
  swiper: SwiperController = new SwiperController();
  @State currentIndex: number = 0; // 修正变量名拼写（currentIndeX → currentIndex）
  build() {
    Column(){
      Row() {
        Text('<')
          .padding(10)
          .onClick(() => {
            router.back();
          });
        Text('消息公告')
          .fontSize(18)
          .fontWeight(FontWeight.Bold);
        Row().width(24);
      }
      .width('100%')
      .margin({ top: 30 })
      .justifyContent(FlexAlign.SpaceBetween);

      // 搜索框
      Search({ placeholder: '输入公告标题搜索' })
        .height(40)
        .backgroundColor('#ffffff')
        .margin({ left: 15, right: 15, top: 10 });

      // 消息/公告标签栏（核心修改部分）
      Row() {
        // 消息标签
        Text('消息')
          .fontSize(26)
          .fontWeight(700)
          // 文字颜色：当前索引为0时变蓝
          .fontColor(this.currentIndex === 0 ? '#0000FF' : '#000000')
          // 下划线：当前索引为0时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(0);
          });

        // 公告标签
        Text('公告')
          .fontSize(26)
          .fontWeight(700)
          // 文字颜色：当前索引为1时变蓝
          .fontColor(this.currentIndex === 1 ? '#0000FF' : '#000000')
          // 下划线：当前索引为1时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(1);
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .margin({ top: 20 });

      Swiper(this.swiper) {
        xiaoxi()
        gonggao()
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

// 消息组件
@Component
struct xiaoxi {
  datas: Item1[] = [
    { title: '系统消息', contents: '您有新的审批需要处理', createdAt: new Date('2021-04-21') },
    { title: '系统消息', contents: '您有新的审批需要处理', createdAt: new Date('2021-04-21') },
    { title: '系统消息', contents: '您有新的审批需要处理', createdAt: new Date('2021-04-21') },
    { title: '系统消息', contents: '您有新的审批需要处理', createdAt: new Date('2021-04-21') },
    { title: '系统消息', contents: '您有新的审批需要处理', createdAt: new Date('2021-04-21') },
    { title: '系统消息', contents: '您有新的审批需要处理', createdAt: new Date('2021-04-21') },
    { title: '系统消息', contents: '您有新的审批需要处理', createdAt: new Date('2021-04-21') },
  ];

  @Builder
  myItemUI(item: Item1) {
    Row() {
      Column({ space: 10 }) {
        Text(item.title)
          .fontSize(24)
          .fontWeight(FontWeight.Bold);
        Text(item.contents)
          .fontSize(14)
          .fontColor('#999999');
        Text(formatDate(item.createdAt))
          .width('100%')
          .textAlign(TextAlign.End)
          .fontSize(12)
          .fontColor('#999999');
      }
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#FFFFFF') // 改用白色背景更美观
    .borderRadius(15)
    .margin({ top: 20 })
    .shadow({ radius: 3, color: '#00000010' })
    .onClick(()=>{
      router.pushUrl({url:"pages/xitongxiaoxi"})
    })

  }

  @State isRefresh:boolean =false

  build() {
    Refresh({refreshing:this.isRefresh,promptText:'努力加载中...'}){
      List() {
        ForEach(this.datas, (item: Item1) => {
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

// 公告组件
@Component
struct gonggao {
  datas: Item2[] = [
    { title: '关于XX同志的人事任免', contents: '人事任免内容...', createdAt: new Date('2025-04-21') },
    { title: '2025年最新考勤统计', contents: '考勤统计内容...', createdAt: new Date('2025-04-21') },
  ];

  @Builder
  myItemUI(item: Item2) {
    Row() {
      Column({ space: 10 }) {
        Text(item.title)
          .fontSize(24)
          .fontWeight(FontWeight.Bold);
        Text(item.contents)
          .fontSize(14)
          .fontColor('#999999')
          .maxLines(3)
        Text(formatDate(item.createdAt))
          .width('100%')
          .textAlign(TextAlign.End)
          .fontSize(12)
          .fontColor('#999999');
      }
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#FFFFFF') // 改用白色背景更美观
    .borderRadius(15)
    .margin({ top: 20 })
    .shadow({ radius: 3, color: '#00000010' })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/tongzhigonggao', // 目标页面的路由地址
        params: {
          title: '异常上报' // 可选参数，传递给目标页面
        }
      });
    })
  }

  @State isRefresh:boolean =false

  build() {
    Refresh({ refreshing: this.isRefresh, promptText: '努力加载中...' }) {
      List() {
        ForEach(this.datas, (item: Item2) => {
          ListItem() {
            this.myItemUI(item)
          }
        });

      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 });
    }.onRefreshing(() => {
      this.isRefresh = true
      setTimeout(() => {
        this.isRefresh = false
      }, 2000)
    })
  }
}