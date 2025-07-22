import router from '@ohos.router'; // 引入路由模块
@Component
export struct home {
  build() {
    Scroll() {
      Column() {
        // 轮播图部分

        Stack(){

          Column({space:10}){
            Swiper() {
              Image($r('app.media.sya'))
              Image($r('app.media.syb'))
              Image($r('app.media.syc'))
              Image($r('app.media.syd'))
            }
            .autoPlay(true)
            .borderRadius(15)
            .width('120%')
            .height('35%')
            // 审批通知
            Row() {
              Column() {
                Image($r('app.media.syh'))
                  .width(20)
                  .height(20)
              }
              .margin({ right: 10 }) // 统一图标与文字间距

              Column() {
                Text('您有一条新的审批信息，请及时查看！')
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ left: 30 ,top:'15%'})
            .onClick(() => {
              // 跳转到审批信息页面
            })
            // 通知公告
            Row() {
              Column() {
                Image($r('app.media.syi'))
                  .width(20)
                  .height(20)
              }
              .margin({ right: 10 })

              Column() {
                Text('通知公告')
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ left: 30, top: 10 })

            // 通知内容
            Row() {
              Text('2021年劳动节放假通知')
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ left: 30, top: 10 }) // 缩进对齐内容

            // 重复通知公告
            Row() {
              Text('通知公告')
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ left: 30, top: 10 })

            // 今日排班（加粗）
            Row() {
              Text('今日排班')
                .fontWeight(FontWeight.Bold) // 加粗处理
                .fontSize(16) // 增大标题字号
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ left: 30, top: 10 })

            // 排班详情
            Row() {
              Column() {
                Image($r('app.media.syj'))
                  .width(70)
                  .height(50)
              }
              .margin({ right: 15 }) // 图标与文字间距

              Column() {
                Text('执勤点：巡区一区\n班次名称：早班\n班次时段：8:00-16:00')
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ left: 30, top: 10 })

            // 最新警情（加粗）
            Row() {
              Text('最新警情')
                .fontWeight(FontWeight.Bold) // 加粗处理
                .fontSize(16) // 增大标题字号
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ left: 30, top: 10 })

            // 警情列表区域
            Column() {
              // 封装警情项组件，确保样式统一
              this.JingqingItem()
              this.JingqingItem()
              this.JingqingItem()
              this.JingqingItem()
              this.JingqingItem()
            }
          }

          //中间浮空框
          Row() {
            Column() {
              Image($r('app.media.sye'))
                .width(40)
                .height(40)
              Text('警情任务')
                .fontSize(20)
            }
            .width('33%')
            .height(100)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              router.pushUrl({url:"pages/JingQinRenWu/JingQingRenWu"})// 跳转到警情任务页面
            })

            Column() {
              Image($r('app.media.syf'))
                .width(40)
                .height(40)
              Text('特情任务')
                .fontSize(20)
            }
            .width('33%')
            .height(100)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              // 跳转到特情任务页面
              router.pushUrl({url:"pages/TeQingRenWu/TeQinRenWu"})
            })

            Column() {
              Image($r('app.media.syg'))
                .width(40)
                .height(40)
              Text('问题上报')
                .fontSize(20)
            }
            .width('33%')
            .height(100)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              // 跳转到问题上报页面
              router.pushUrl({url:"pages/WenTiShangBao/QuestionSubmit"})
            })
          }
          .backgroundColor('#ffffff')
          .shadow({ radius: 20, color: '#666666' ,offsetX: 15, offsetY: 15 })
          .borderRadius(10)
          .position({top:'30%',right:'2%',left:'2%'})
          .width('96%')
          .height('12%')
        }
        // 图标和文字部分



      }
      .width('100%')
      .padding(15)
    }
    .scrollable(ScrollDirection.Vertical)
  }

  // 提取警情项为组件，确保样式统一
  @Builder JingqingItem() {
    Row() {
      Column() {
        Image($r('app.media.syk'))
          .width(60)
          .height(50)
      }
      .margin({ right: 15 }) // 固定图标与文字间距

      Column() {
        Text('交通事故现场处置')
          .fontSize(14)
          .fontWeight(FontWeight.Medium) // 标题稍加重
        Text('警情描述警情描述警情描述警情描述')
          .fontSize(14)
          .margin({ top: 5 }) // 增加内容间距
        Text('2021-06-08       15：19：00')
          .fontSize(10)
          .margin({ top: 5 }) // 增加时间间距
          .fontColor('#fd666666') // 时间灰色显示
      }
      .alignItems(HorizontalAlign.Start) // 文本左对齐
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .margin({ left: 30, top: 10 })
  }
}
