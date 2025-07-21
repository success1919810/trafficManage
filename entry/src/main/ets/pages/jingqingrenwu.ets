import router from '@ohos.router';

// 统一任务状态接口（合并重复接口，减少冗余）
interface TaskBase {
  title: string;
  createdAt: Date;
  contents: string;
  timeRemaining?: string; // 已完成状态可无此字段
  actionText1?: string;   // 操作按钮1文本
  actionText2?: string;   // 操作按钮2文本（可选）
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
struct Jingqingrenwu {
  swiper: SwiperController = new SwiperController();
  @State currentIndex: number = 0; // 标签索引（0-待签收 1-中途中 2-处理中 3-已反馈 4-已完成）

  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Column() {
      // 顶部导航栏（美化版）
      Row() {
        // 返回按钮
        Button('<')
          .fontSize(22)
          .backgroundColor('#007AFF') // 主色调背景
          .fontColor('#FFFFFF')
          .borderRadius(5)
          .padding({ left: 10, right: 10 })
          .onClick(() => router.back());

        // 标题（居中）
        Text('警情任务')
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

      // 月份标题（优化样式）
      Text('6月')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ top: 20, left: 15 }) // 左对齐，与内容区对齐
        .width('100%')



      //点击跳转
      Row() {
        Text('待签收')
          .fontSize(20)
          .fontWeight(700)
          // 文字颜色：当前索引为0时变蓝
          .fontColor(this.currentIndex === 0 ? '#0000FF' : '#000000')
          // 下划线：当前索引为0时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(0);
          });
        Text('中途中')
          .fontSize(20)
          .fontWeight(700)
          // 文字颜色：当前索引为0时变蓝
          .fontColor(this.currentIndex === 1 ? '#0000FF' : '#000000')
          // 下划线：当前索引为0时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(1);
          });
        Text('处理中')
          .fontSize(20)
          .fontWeight(700)
          // 文字颜色：当前索引为0时变蓝
          .fontColor(this.currentIndex === 2 ? '#0000FF' : '#000000')
          // 下划线：当前索引为0时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(2);
          });
        Text('已反馈')
          .fontSize(20)
          .fontWeight(700)
          // 文字颜色：当前索引为0时变蓝
          .fontColor(this.currentIndex === 3 ? '#0000FF' : '#000000')
          // 下划线：当前索引为0时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(3);
          });
        Text('已完成')
          .fontSize(20)
          .fontWeight(700)
          // 文字颜色：当前索引为0时变蓝
          .fontColor(this.currentIndex === 4 ? '#0000FF' : '#000000')
          // 下划线：当前索引为0时显示蓝色下划线

          .onClick(() => {
            this.swiper.changeIndex(4);
          });
      }.justifyContent(FlexAlign.SpaceAround)
      .width('100%')
      // 内容切换区域（优化高度和过渡）
      Swiper(this.swiper) {
        daiqianshou()
        zhongtuzhong()
        chulizhong()
        yifankui()
        yiwancheng()
      }

      .onChange(index => {
        this.currentIndex = index; // 切换时同步更新状态
      })
      .onChange(index => this.currentIndex = index)
      .width('100%')
      .height('70%')
      .borderRadius(10)
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5') // 页面背景色

    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight)})
  }

  // 构建单个标签（带选中样式）
  @Builder
  buildTab(text: string, index: number) {
    Text(text)
      .fontSize(18)
      .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.currentIndex === index ? '#007AFF' : '#666666')
      // 选中时下划线

  }
}

// 待签收组件（美化）
@Component
struct daiqianshou {
  datas: TaskBase[] = [
    {
      title: 'XX市XX区汉安大道中段25',
      createdAt: new Date('2021-04-21'),
      contents: '该路段发生一起车祸，造成人员受伤，需紧急处理',
      timeRemaining: '10分30秒',
      actionText1: '签收',
      actionText2: '退回'
    },
    {
      title: 'XX市XX区汉安大道中段25',
      createdAt: new Date('2021-04-21'),
      contents: '该路段发生一起车祸，造成人员受伤，需紧急处理',
      timeRemaining: '10分30秒',
      actionText1: '签收',
      actionText2: '退回'
    },
    {
      title: 'XX市XX区汉安大道中段25',
      createdAt: new Date('2021-04-21'),
      contents: '该路段发生一起车祸，造成人员受伤，需紧急处理',
      timeRemaining: '10分30秒',
      actionText1: '签收',
      actionText2: '退回'
    },
    {
      title: 'XX市XX区汉安大道中段25',
      createdAt: new Date('2021-04-21'),
      contents: '该路段发生一起车祸，造成人员受伤，需紧急处理',
      timeRemaining: '10分30秒',
      actionText1: '签收',
      actionText2: '退回'
    }
  ];

  @Builder
  myItemUI(item: TaskBase) {
    Column({ space: 12 }) {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .flexGrow(1);

        Text(formatDate(item.createdAt))
          .fontSize(12)
          .fontColor('#999999');
      }

      Text(item.contents)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(20);

      Text(`剩余时间：${item.timeRemaining}`)
        .fontSize(14)
        .fontColor('#FF3B30')

      Row({ space: 15 }) {
        Button(item.actionText1)
          .width('45%')
          .height(40)
          .fontSize(16)
          .backgroundColor('#007AFF')
          .fontColor('#FFFFFF')
          .borderRadius(6)
          .onClick(() => {
            // 跳转至签收详情页
            router.pushUrl({ url: 'pages/jingqingqianshou' })
          })

        Button(item.actionText2)
          .width('45%')
          .height(40)
          .fontSize(16)
          .backgroundColor('#F5F5F5')
          .fontColor('#333333')
          .borderRadius(6)
          .onClick(() => {
            // 跳转至退回原因填写页
            router.pushUrl({ url: 'pages/jingqingtuidan' })
          });
      }
      .width('100%')
    }
    .padding(18)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 6, color: '#00000010', offsetY: 2 })
    .margin({ top: 15 });
  }

  @State isRefresh: boolean = false

  build() {
    Refresh({ refreshing: this.isRefresh, promptText: '努力加载中...' }) {
      List() {
        ForEach(this.datas, (item: TaskBase) => {
          ListItem() { this.myItemUI(item) }
        });
      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 });
    }
    .onRefreshing(() => {
      this.isRefresh = true
      setTimeout(() => { this.isRefresh = false }, 2000)
    })
  }
}

// 中途中组件
@Component
struct zhongtuzhong {
  datas: TaskBase[] = [
    {
      title: 'XX市XX区汉安大道中段25',
      createdAt: new Date('2021-04-21'),
      contents: '该路段发生一起车祸，造成人员受伤，正在前往处理',
      timeRemaining: '10分30秒',
      actionText1: '到场反馈'
    }
  ];

  @Builder
  myItemUI(item: TaskBase) {
    Column({ space: 12 }) {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .flexGrow(1);

        Text(formatDate(item.createdAt))
          .fontSize(12)
          .fontColor('#999999');
      }

      Text(item.contents)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(20);

      Text(`剩余时间：${item.timeRemaining}`)
        .fontSize(14)
        .fontColor('#FF3B30')

      Button(item.actionText1)
        .width('100%')
        .height(40)
        .fontSize(16)
        .backgroundColor('#007AFF')
        .fontColor('#FFFFFF')
        .borderRadius(6)
        .onClick(() => {
          // 跳转至到场反馈页
          router.pushUrl({ url: 'pages/jingqingfankui' })
        })
    }
    .padding(18)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 6, color: '#00000010', offsetY: 2 })
    .margin({ top: 15 });
  }

  @State isRefresh: boolean = false

  build() {
    Refresh({ refreshing: this.isRefresh, promptText: '努力加载中...' }) {
      List() {
        ForEach(this.datas, (item: TaskBase) => {
          ListItem() { this.myItemUI(item) }
        });
      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 });
    }
    .onRefreshing(() => {
      this.isRefresh = true
      setTimeout(() => { this.isRefresh = false }, 2000)
    })
  }
}

// 处理中组件（与中途中样式统一）
@Component
struct chulizhong {
  datas: TaskBase[] = [
    {
      title: 'XX市XX区汉安大道中段25',
      createdAt: new Date('2021-04-21'),
      contents: '该路段发生一起车祸，正在现场处理中',
      timeRemaining: '10分30秒',
      actionText1: '处置反馈'
    }
  ];

  @Builder
  myItemUI(item: TaskBase) {
    // 复用中途中的UI结构，保持统一
    Column({ space: 12 }) {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .flexGrow(1);

        Text(formatDate(item.createdAt))
          .fontSize(12)
          .fontColor('#999999');
      }

      Text(item.contents)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(20);

      Text(`剩余时间：${item.timeRemaining}`)
        .fontSize(14)
        .fontColor('#FF3B30')

      Button(item.actionText1)
        .width('100%')
        .height(40)
        .fontSize(16)
        .backgroundColor('#007AFF')
        .fontColor('#FFFFFF')
        .borderRadius(6)
        .onClick(() => {
          // 跳转至到场反馈页
          router.pushUrl({ url: 'pages/jingqingchuzhi' })
        })
    }
    .padding(18)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 6, color: '#00000010', offsetY: 2 })
    .margin({ top: 15 });
  }

  @State isRefresh:boolean =false

  build() {
    Refresh({refreshing:this.isRefresh,promptText:'努力加载中...'}){
      List(){
        ForEach(this.datas, (item: TaskBase) =>{ListItem(){this.myItemUI(item)}});
      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 });
    }.onRefreshing(()=>{this.isRefresh=true
      setTimeout(()=>{this.isRefresh=false},2000)})

  }
}

// 已反馈组件
@Component
struct yifankui {
  datas: TaskBase[] = [
    {
      title: 'XX市XX区汉安大道中段25',
      createdAt: new Date('2021-04-21'),
      contents: '该路段车祸已反馈，等待进一步指示',
      timeRemaining: '10分30秒',
      actionText1: '完成'
    }
  ];

  @Builder
  myItemUI(item: TaskBase) {
    // 样式与处理中统一
    Column({ space: 12 }) {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .flexGrow(1);

        Text(formatDate(item.createdAt))
          .fontSize(12)
          .fontColor('#999999');
      }

      Text(item.contents)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(20);

      Text(`剩余时间：${item.timeRemaining}`)
        .fontSize(14)
        .fontColor('#FF3B30')

      Button(item.actionText1)
        .width('100%')
        .height(40)
        .fontSize(16)
        .backgroundColor('#007AFF')
        .fontColor('#FFFFFF')
        .borderRadius(6)
        .onClick(() => console.log(`${item.actionText1}：${item.title}`));
    }
    .padding(18)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 6, color: '#00000010', offsetY: 2 })
    .margin({ top: 15 });
  }

  @State isRefresh:boolean =false

  build() {
    Refresh({refreshing:this.isRefresh,promptText:'努力加载中...'}){
      List(){
        ForEach(this.datas, (item: TaskBase) =>{ListItem(){this.myItemUI(item)}});
      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 });
    }.onRefreshing(()=>{this.isRefresh=true
      setTimeout(()=>{this.isRefresh=false},2000)})

  }
}

// 已完成组件（无剩余时间，添加详情按钮）
@Component
struct yiwancheng {
  datas: TaskBase[] = [
    {
      title: 'XX市XX区汉安大道中段25',
      createdAt: new Date('2021-04-21'),
      contents: '该路段车祸已处理完毕，现场已清理',
      actionText1: '详情'
    }
  ];

  @Builder
  myItemUI(item: TaskBase) {
    Column({ space: 12 }) {
      Row({space:15}) {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .flexGrow(1);
        Text('详情>')
          .fontColor('#0000ff')
          .fontSize(18)
          .onClick(() => {
            // 跳转至到场反馈页
            router.pushUrl({ url: 'pages/jingqingxiangqing' })
          })
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
        Text(formatDate(item.createdAt))
          .fontSize(12)
          .fontColor('#999999');


      Text(item.contents)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(20);

      // 已完成无剩余时间，直接显示详情按钮
      Button(item.actionText1)
        .width('100%')
        .height(40)
        .fontSize(16)
        .backgroundColor('#F5F5F5')
        .fontColor('#333333')
        .borderRadius(6)
        .onClick(() => console.log(`查看${item.actionText1}：${item.title}`));
    }
    .padding(18)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 6, color: '#00000010', offsetY: 2 })
    .margin({ top: 15 });
  }

  @State isRefresh:boolean =false

  build() {
    Refresh({refreshing:this.isRefresh,promptText:'努力加载中...'}){
      List(){
        ForEach(this.datas, (item: TaskBase) =>{ListItem(){this.myItemUI(item)}});
      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 });
    }.onRefreshing(()=>{this.isRefresh=true
      setTimeout(()=>{this.isRefresh=false},2000)})

  }
}
