import router from '@ohos.router';
import { Prompt } from '@kit.ArkUI';

@Entry
@Component
struct ErrorSubmit {
  @State currentIndex:number = 0
  swiper:SwiperController = new SwiperController()
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;




  build() {
   Column({space:10}){

     Row(){
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
         .onClick(()=>{
              router.pushUrl({
                url:'pages/map'
              })
         })
     }.justifyContent(FlexAlign.SpaceBetween)
     .width('100%')

     Search({placeholder: '搜地点'})
       .height(40)
       .width(360)


    //切换卡
    Row({space:40}){
        Text("待处理")
          .fontSize(25)
          .fontColor(this.currentIndex == 0 ? '#d5d121':'#000000')
          .onClick(()=>{
            this.swiper.changeIndex(0)
          })
        Text("处理中")
          .fontSize(25)
          .fontColor(this.currentIndex == 1 ? '#d5d121':'#000000')
          .onClick(()=>{
            this.swiper.changeIndex(1)
          })
        Text("已完成")
          .fontSize(25)
          .fontColor(this.currentIndex == 2 ? '#d5d121':'#000000')
          .onClick(()=>{
            this.swiper.changeIndex(2)
          })
        Text("待评价")
          .fontSize(25)
          .fontColor(this.currentIndex == 3 ? '#d5d121':'#000000')
          .onClick(()=>{
            this.swiper.changeIndex(3)
          })
    } .width('100%')
     .justifyContent(FlexAlign.SpaceAround)

    //选项卡切换
     Swiper(this.swiper){
       daichuli()
       chulihzong()
       daipingjia()
       yiwancheng()
     }.width("100%")
     .height("100%")
     .onChange(index=>{
       this.currentIndex = index
     })

   }
   .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
   .width('100%')
   .height('100%')
  }
}


interface Item1{
  text1:string
  text2:string
  text3:string
  text4:string
  text5:string
}

@Component
struct daichuli{
  @State Refresh:boolean = false;
  @State Loading:boolean = false;
  datas:Item2[] = [
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'普通枪机 - BH3356',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
  ]
  @Builder
  myItemUI(item1:Item1){
      Column({space:10}){
        Text(item1.text1)
          .fontSize(20)
          .fontWeight(10)
          .width('100%')

        Text(item1.text2)
          .width('100%')
          .fontColor('#666666')

        Text(item1.text3)
          .width('100%')
          .fontColor('#666666')

        Text(item1.text4)
          .width('100%')
          .fontColor('#666666')

        Text(item1.text5)
          .width('100%')
          .fontColor('#666666')

      }.width('95%')
      .backgroundColor('#ffffff')
      .margin({top:15,left:5,right:5})
      .padding(20)
      .borderRadius(15)

  }

  build() {
    Column(){
      Refresh({refreshing:this.Refresh,promptText:'正在加载中'}){

        List(){
          //遍历加载图
          ForEach(this.datas,(item1:Item1)=>{
            ListItem(){
              this.myItemUI(item1)
            }
          })
          //下拉刷新
          if(this.Loading){
            ListItem(){
              Row(){
                Text('松开加载更多')
                LoadingProgress().width(20).height(20)
              }
              .width("100%")
              .justifyContent(FlexAlign.Center)
              .padding({top:10})
            }
          }

        }
        .onScrollIndex((start:number,end:number) =>{
          if(end == this.datas.length-1 && this.Loading == false){
            this.Loading = true
            setTimeout(()=>{
              this.Loading =false
            },2000)
          }
        })

      }
      .onRefreshing(()=>{
        this.Refresh = true
        setTimeout(()=>{
            this.Refresh = false
        },2000)
      })//上拉刷新
    }
    .backgroundColor('#f2f2f2')
    .layoutWeight(1)
    .padding({bottom:80})
  }
}

interface Item2{
  text1:string
  text2:string
  text3:string
  text4:string
  text5:string
}

@Component
struct chulihzong{
  datas:Item2[] = [
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'普通枪机 - BH3356',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
    {text1:'高点球机 - BH58Z1',text2:'故障类型：未知离线',text3:'设备位置：市中区汉安大道 988 号',text4:'报修时间：2021 年 7 月 1 日 11:08:22',text5:'报修人：刘全'},
  ]
  @Builder
  myItemUI(item2:Item2){
    Column({space:3}){
      Text(item2.text1)
        .fontSize(20)
        .fontWeight(10)
        .width('100%')
      Text(item2.text2)
        .width('100%')
      Text(item2.text3)
        .width('100%')
      Text(item2.text4)
        .width('100%')
      Text(item2.text5)
        .width('100%')
    }.width('100%')
  }
  build() {
      Column(){

        List(){
          ForEach(this.datas,(item2:Item2)=>{
            ListItem(){
              this.myItemUI(item2)
            }
          })
        }
        .layoutWeight(1) // 限制在一个区域

      }
  }
}

@Component
struct daipingjia{
  build() {
    Text('已完成')
  }
}

@Component
struct yiwancheng{
  build() {
    Text('待评价')
  }
}
