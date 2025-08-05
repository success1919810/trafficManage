
import router from '@ohos.router';
import { Prompt } from '@kit.ArkUI';
import { WorkOrderItem, ApiResponse, PageData } from "../../utils/ErrorSubmitType"
import { errorSubmitService } from "../../utils/ErrorSubmitService"
import { getToken } from '../../utils/TokenUtils'
@Entry
@Component
struct ErrorSubmit {
  @State currentIndex: number = 0
  swiper: SwiperController = new SwiperController()
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Column({ space: 10 }) {
      Row() {
        Text('<')
          .fontSize(26)
          .width('10%')
          .onClick(() => router.back())

        Text('故障上报')
          .fontSize(25)
          .fontColor('#000000')

        Text('地图')
          .fontColor('#007AFF')
          .fontSize(20)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/map'
            })
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      Search({ placeholder: '搜地点' })
        .height(40)
        .width(360)

      // 切换卡 - 添加点击事件
      Row({ space: 40 }) {
        Text("待处理")
          .fontSize(25)
          .fontColor(this.currentIndex == 0 ? '#d5d121' : '#000000')
          .onClick(() => {
            this.currentIndex = 0
            this.swiper.changeIndex(0)
          })

        Text("处理中")
          .fontSize(25)
          .fontColor(this.currentIndex == 1 ? '#d5d121' : '#000000')
          .onClick(() => {
            this.currentIndex = 1
            this.swiper.changeIndex(1)
          })

        Text("待评价")
          .fontSize(25)
          .fontColor(this.currentIndex == 2 ? '#d5d121' : '#000000')
          .onClick(() => {
            this.currentIndex = 2
            this.swiper.changeIndex(2)
          })

        Text("已完成")
          .fontSize(25)
          .fontColor(this.currentIndex == 3 ? '#d5d121' : '#000000')
          .onClick(() => {
            this.currentIndex = 3
            this.swiper.changeIndex(3)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)

      // 选项卡切换
      Swiper(this.swiper) {
        Daichuli()
        Chulihzong()
        Daipingjia()
        Yiwancheng()
      }
      .width("100%")
      .height("100%")
      .onChange(index => {
        this.currentIndex = index
      })
    }
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
    .width('100%')
    .height('100%')
  }
}

@Component
struct Daichuli {
  @State Refresh: boolean = false;
  @State Loading: boolean = false;
  @State workOrder: WorkOrderItem[] = []
  @State currentPage: number = 1;
  @State hasMore: boolean = true;

  async fetchData(reset: boolean = false) {
    if (reset) {
      this.currentPage = 1;
      this.hasMore = true;
      this.Loading = true; // 重置时也要显示加载状态
    }

    if (!this.hasMore && !reset) {
      return;
    }

    try {
      const context = getContext(this)
      const result = await errorSubmitService<ApiResponse>(`http://26.120.165.93:8080/errorSubmit/pending?pageNum=${this.currentPage}`,context);
      if (result.code === 200) {
        const pageData = result.data as PageData;

        if (reset) {
          this.workOrder = pageData.records;
        } else {
          this.workOrder = [...this.workOrder, ...pageData.records];
        }

        if (this.workOrder.length >= pageData.total) {
          this.hasMore = false;
        } else {
          this.currentPage++;
        }
      }
    } catch (error) {
      console.error('获取数据失败:', error);
    } finally {
      this.Loading = false;
    }
  }

  aboutToAppear() {
    this.fetchData(true);
  }

  @Builder
  myItemUI(item: WorkOrderItem) {
    Column({ space: 10 }) {
      Text(`${item.equipmentType} - ${item.equipmentCode}`)
        .fontSize(20)
        .fontWeight(FontWeight.Normal)
        .width('100%')

      Text(`故障类型：${item.faultType}`)
        .width('100%')
        .fontColor('#666666')

      Text(`设备位置：${item.location}`)
        .width('100%')
        .fontColor('#666666')

      Text(`报修时间：${item.reportTime}`)
        .width('100%')
        .fontColor('#666666')

      Text(`报修人：${item.reporterName}`)
        .width('100%')
        .fontColor('#666666')
    }
    .width('95%')
    .backgroundColor('#ffffff')
    .margin({ top: 15, left: 5, right: 5 })
    .padding(20)
    .borderRadius(15)
    .onClick(() => {
      router.pushUrl({
        url: "pages/GuZhangShangBao/GongDanXingXi",
        params: { orderId: item.id, orderData: item }
      })
    })
  }

  build() {
    Column() {
      Refresh({ refreshing: this.Refresh, promptText: '正在加载中' }) {
        List() {
          ForEach(this.workOrder, (item: WorkOrderItem, index: number) => {
            ListItem() {
              this.myItemUI(item)
            }
          }, (item: WorkOrderItem, index: number) => {
            return item.id.toString(); // 提供唯一的key
          })

          if (this.Loading && this.workOrder.length > 0) {
            ListItem() {
              Row() {
                Text('加载中...')
                LoadingProgress().width(20).height(20)
              }
              .width("100%")
              .justifyContent(FlexAlign.Center)
              .padding({ top: 10 })
            }
          }
        }
        .onScrollIndex((start: number, end: number) => {
          if (end >= this.workOrder.length - 1 && !this.Loading && this.hasMore) {
            this.Loading = true; // 先设置加载状态
            this.fetchData(false); // 然后加载数据
          }
        })
      }
      .onRefreshing(() => {
        this.Refresh = true;
        this.fetchData(true); // 刷新时重新加载第一页
        setTimeout(() => {
          this.Refresh = false;
        }, 2000);
      })
    }
    .backgroundColor('#f2f2f2')
    .layoutWeight(1)
    .padding({ bottom: 80 })
  }
}

@Component
struct Chulihzong {
  @State workOrder: WorkOrderItem[] = []

  async fetchData() {
    try {
      const context = getContext(this)
      const result = await errorSubmitService<ApiResponse>("http://26.120.165.93:8080/errorSubmit/processing",context);
      if (result.code === 200) {
        const pageData = result.data as PageData;
        this.workOrder = pageData.records;
      }
    } catch (error) {
      console.error('获取数据失败:', error);
    }
  }

  aboutToAppear() {
    this.fetchData();
  }

  @Builder
  myItemUI(item: WorkOrderItem) {
    Column({ space: 10 }) {
      Text(`${item.equipmentType} - ${item.equipmentCode}`)
        .fontSize(20)
        .fontWeight(FontWeight.Normal)
        .width('100%')

      Text(`故障类型：${item.faultType}`)
        .width('100%')
        .fontColor('#666666')

      Text(`设备位置：${item.location}`)
        .width('100%')
        .fontColor('#666666')

      Text(`报修时间：${item.reportTime}`)
        .width('100%')
        .fontColor('#666666')

      Text(`报修人：${item.reporterName}`)
        .width('100%')
        .fontColor('#666666')
    }
    .width('95%')
    .backgroundColor('#ffffff')
    .margin({ top: 15, left: 5, right: 5 })
    .padding(20)
    .borderRadius(15)
    .onClick(() => {
      router.pushUrl({
        url: "pages/GuZhangShangBao/GongDanXingXiIng",
        params: { orderId: item.id, orderData: item }
      })
    })
  }

  build() {
    Column() {
      List() {
        ForEach(this.workOrder, (item: WorkOrderItem, index: number) => {
          ListItem() {
            this.myItemUI(item)
          }
        }, (item: WorkOrderItem, index: number) => {
          return item.id.toString(); // 提供唯一的key
        })
      }
      .layoutWeight(1)
    }
    .backgroundColor('#f2f2f2')
  }
}

@Component
struct Daipingjia {
  @State workOrder: WorkOrderItem[] = []

  async fetchData() {
    try {
      const context = getContext(this)
      const result = await errorSubmitService<ApiResponse>("http://26.120.165.93:8080/errorSubmit/completed",context);
      if (result.code === 200) {
        const pageData = result.data as PageData;
        this.workOrder = pageData.records;
      }
    } catch (error) {
      console.error('获取数据失败:', error);
    }
  }

  aboutToAppear() {
    this.fetchData();
  }

  @Builder
  myItemUI(item: WorkOrderItem) {
    Column({ space: 10 }) {
      Text(`${item.equipmentType} - ${item.equipmentCode}`)
        .fontSize(20)
        .fontWeight(FontWeight.Normal)
        .width('100%')

      Text(`故障类型：${item.faultType}`)
        .width('100%')
        .fontColor('#666666')

      Text(`设备位置：${item.location}`)
        .width('100%')
        .fontColor('#666666')

      Text(`报修时间：${item.reportTime}`)
        .width('100%')
        .fontColor('#666666')

      Text(`报修人：${item.reporterName}`)
        .width('100%')
        .fontColor('#666666')
    }
    .width('95%')
    .backgroundColor('#ffffff')
    .margin({ top: 15, left: 5, right: 5 })
    .padding(20)
    .borderRadius(15)
    .onClick(() => {
      router.pushUrl({
        url: "pages/GuZhangShangBao/GongDanXingXiDone",
        params: { orderId: item.id, orderData: item }
      })
    })
  }

  build() {
    Column() {
      List() {
        ForEach(this.workOrder, (item: WorkOrderItem, index: number) => {
          ListItem() {
            this.myItemUI(item)
          }
        }, (item: WorkOrderItem, index: number) => {
          return item.id.toString(); // 提供唯一的key
        })
      }
      .layoutWeight(1)
    }
    .backgroundColor('#f2f2f2')
  }
}

@Component
struct Yiwancheng {
  @State workOrder: WorkOrderItem[] = []

  async fetchData() {
    try {
      const context = getContext()
      const result = await errorSubmitService<ApiResponse>("http://26.120.165.93:8080/errorSubmit/evaluated",context);
      if (result.code === 200) {
        const pageData = result.data as PageData;
        this.workOrder = pageData.records;
      }
    } catch (error) {
      console.error('获取数据失败:', error);
    }
  }

  aboutToAppear() {
    this.fetchData();
  }

  @Builder
  myItemUI(item: WorkOrderItem) {
    Column({ space: 10 }) {
      Text(`${item.equipmentType} - ${item.equipmentCode}`)
        .fontSize(20)
        .fontWeight(FontWeight.Normal)
        .width('100%')

      Text(`故障类型：${item.faultType}`)
        .width('100%')
        .fontColor('#666666')

      Text(`设备位置：${item.location}`)
        .width('100%')
        .fontColor('#666666')

      Text(`报修时间：${item.reportTime}`)
        .width('100%')
        .fontColor('#666666')

      Text(`报修人：${item.reporterName}`)
        .width('100%')
        .fontColor('#666666')
    }
    .width('95%')
    .backgroundColor('#ffffff')
    .margin({ top: 15, left: 5, right: 5 })
    .padding(20)
    .borderRadius(15)
    .onClick(() => {
      router.pushUrl({
        url: "pages/GuZhangShangBao/GongDanXingXiComment",
        params: { orderId: item.id, orderData: item }
      })
    })
  }

  build() {
    Column() {
      List() {
        ForEach(this.workOrder, (item: WorkOrderItem, index: number) => {
          ListItem() {
            this.myItemUI(item)
          }
        }, (item: WorkOrderItem, index: number) => {
          return item.id.toString(); // 提供唯一的key
        })
      }
      .layoutWeight(1)
    }
    .backgroundColor('#f2f2f2')
  }
}