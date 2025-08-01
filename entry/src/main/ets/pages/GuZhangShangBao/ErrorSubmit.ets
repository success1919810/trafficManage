import router from '@ohos.router';
import { Prompt } from '@kit.ArkUI';
import {WorkOrderStatus,WorkOrderItem,ApiResponse} from "../../utils/ErrorSubmitType"
import {errorSubmitService} from "../../utils/ErrorSubmitService"


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
          .fontColor('#0000000')

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
        daichuli()
        chulihzong()
        daipingjia()
        yiwancheng()
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
struct daichuli {
  @State Refresh: boolean = false;
  @State Loading: boolean = false;
  @State workOrder: WorkOrderItem[] = []

  async fetchData() {
    this.Loading = true
    try {
      const result = await errorSubmitService<ApiResponse>("http://26.195.0.245:8080/errorSubmit/pending")
      if (result.code === 200) {
        this.workOrder = result.data as WorkOrderItem[]
      }
    } catch (error) {
      console.error('获取数据失败:', error)
    } finally {
      this.Loading = false
    }
  }

  aboutToAppear() {
    this.fetchData()
  }

  @Builder
  myItemUI(item: WorkOrderItem) {
    Column({ space: 10 }) {
      Text(`${item.equipmentType} - ${item.equipmentCode}`)
        .fontSize(20)
        .fontWeight(10)
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
          ForEach(this.workOrder, (item: WorkOrderItem) => {
            ListItem() {
              this.myItemUI(item)
            }
          })
          if (this.Loading) {
            ListItem() {
              Row() {
                Text('松开加载更多')
                LoadingProgress().width(20).height(20)
              }
              .width("100%")
              .justifyContent(FlexAlign.Center)
              .padding({ top: 10 })
            }
          }
        }
        .onScrollIndex((start: number, end: number) => {
          if (end == this.workOrder.length - 1 && this.Loading == false) {
            this.Loading = true
            setTimeout(() => {
              this.Loading = false
            }, 2000)
          }
        })
      }
      .onRefreshing(() => {
        this.Refresh = true
        this.fetchData()
        setTimeout(() => {
          this.Refresh = false
        }, 2000)
      })
    }
    .backgroundColor('#f2f2f2')
    .layoutWeight(1)
    .padding({ bottom: 80 })
  }
}

@Component
struct chulihzong {
  @State workOrder: WorkOrderItem[] = []

  async fetchData() {
    try {
      const result = await errorSubmitService<ApiResponse>("http://26.195.0.245:8080/errorSubmit/processing")
      if (result.code === 200) {
        this.workOrder = result.data as WorkOrderItem[]
      }
    } catch (error) {
      console.error('获取数据失败:', error)
    }
  }

  aboutToAppear() {
    this.fetchData()
  }

  @Builder
  myItemUI(item: WorkOrderItem) {
    Column({ space: 10 }) {
      Text(`${item.equipmentType} - ${item.equipmentCode}`)
        .fontSize(20)
        .fontWeight(10)
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
        ForEach(this.workOrder, (item: WorkOrderItem) => {
          ListItem() {
            this.myItemUI(item)
          }
        })
      }
      .layoutWeight(1)
    }
    .backgroundColor('#f2f2f2')
  }
}

@Component
struct daipingjia {
  @State workOrder: WorkOrderItem[] = []

  async fetchData() {
    try {
      const result = await errorSubmitService<ApiResponse>("http://26.195.0.245:8080/errorSubmit/completed")
      if (result.code === 200) {
        this.workOrder = result.data as WorkOrderItem[]
      }
    } catch (error) {
      console.error('获取数据失败:', error)
    }
  }

  aboutToAppear() {
    this.fetchData()
  }

  @Builder
  myItemUI(item: WorkOrderItem) {
    Column({ space: 10 }) {
      Text(`${item.equipmentType} - ${item.equipmentCode}`)
        .fontSize(20)
        .fontWeight(10)
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
        ForEach(this.workOrder, (item: WorkOrderItem) => {
          ListItem() {
            this.myItemUI(item)
          }
        })
      }
      .layoutWeight(1)
    }
    .backgroundColor('#f2f2f2')
  }
}

@Component
struct yiwancheng {
  @State workOrder: WorkOrderItem[] = []

  async fetchData() {
    try {
      const result = await errorSubmitService<ApiResponse>("http://26.195.0.245:8080/errorSubmit/evaluated")
      if (result.code === 200) {
        this.workOrder = result.data as WorkOrderItem[]
      }
    } catch (error) {
      console.error('获取数据失败:', error)
    }
  }

  aboutToAppear() {
    this.fetchData()
  }

  @Builder
  myItemUI(item: WorkOrderItem) {
    Column({ space: 10 }) {
      Text(`${item.equipmentType} - ${item.equipmentCode}`)
        .fontSize(20)
        .fontWeight(10)
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
        ForEach(this.workOrder, (item: WorkOrderItem) => {
          ListItem() {
            this.myItemUI(item)
          }
        })
      }
      .layoutWeight(1)
    }
    .backgroundColor('#f2f2f2')
  }
}