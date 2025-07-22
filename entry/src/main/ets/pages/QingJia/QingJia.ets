import router from '@ohos.router';
import { url } from '@kit.ArkTS';

interface Item1{
  date:string
  time:string
  kind:string
  type:string
}
@Entry
@Component
struct QingJia {
  @State message: string = 'Hello World';
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @State datas:Item1[]=[
    {date:'2021-4-15',time:'8小时',kind:'事假',type:'待审核'},
    {date:'2021-4-15',time:'8小时',kind:'事假',type:'待销假'},
    {date:'2021-4-15',time:'8小时',kind:'事假',type:'已驳回'},
    {date:'2021-4-15',time:'8小时',kind:'事假',type:'已销假'},
    {date:'2021-4-15',time:'8小时',kind:'事假',type:'待审核'}
  ]
  @Builder
  myItemUI(item:Item1){

    Column({space:10}){
      Row(){
        Text('请假日期:')
          .fontSize(15)
          .fontColor('#0099FF')
        Text(item.date)
          .fontSize(15)
          .fontColor('#0099FF')
        if (item.type=='待审核'||item.type=='已驳回'){
          Button('修改')
            .width(60)
            .height(30)
            .fontSize(15)
            .padding(6)
            .fontColor('#ffffff')
            .backgroundColor('#0099FF')
            .type(ButtonType.Normal)
            .onClick(()=>{
              router.pushUrl({url:('pages/QingJia/QingJiaXiuGai')})
            })
        }else if(item.type=='待销假'){
          Button('销假')
            .width(60)
            .height(30)
            .fontSize(15)
            .padding(6)
            .fontColor('#ffffff')
            .backgroundColor('#0099FF')
            .type(ButtonType.Normal)
            .onClick(()=>{
              router.pushUrl({url:('pages/QingJia/QingJiaXiaoJia')})
            })
        }else{
          Text('>')
            .width(60)
            .height(40)
            .fontSize(25)
            .fontColor('#0099FF')
            .backgroundColor('#ffffff')
            .onClick(()=>{
            router.pushUrl({url:('pages/QingJia/QingJiaXiangXI')})
          })
            .padding({left:30})

        }
      }
      .width('100%')
      .height(30)
      .margin({top:10})
      .justifyContent(FlexAlign.SpaceAround)
      Row(){}
      .height(2)
      .width('90%')
      .backgroundColor('#999999')
      Row(){
        Text('请假时长：')
          .fontSize(15)
          .fontColor('#000000')
        Text(item.time)
          .fontSize(15)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({left:60})
      Row(){
        Text('请假类型：')
          .fontSize(15)
          .fontColor('#000000')
        Text(item.kind)
          .fontSize(15)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({left:60})
      Row(){
        Text('状态：')
          .fontSize(15)
          .fontColor('#000000')
        Text(item.type)
          .fontSize(15)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({left:60})
    }
        .borderWidth(2)
        .height(143)
        .borderColor('#FAFAFA')
        .borderRadius(12)
        .margin(10)



}
  build() {
    Stack({alignContent:Alignment.Bottom}){
      Column(){
      Row(){
        Button()
          .width(30)
          .height(40)
          .backgroundImage($r('app.media.back'))
          .backgroundImageSize(ImageSize.Cover)
          .backgroundColor('#F2F2F2')
          .margin({right:100})
          .onClick(()=>{
            router.back()
          })
        Text('请假列表')
          .fontSize(17)
          .fontColor('#83000000')
          .padding(10)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#F2F2F2')
      List(){
         ForEach(this.datas,(item:Item1)=>{
           ListItem(){
              this.myItemUI(item)
           }
      })
      }
      .width('100%')
      .height('100%') // 关键修改：设置明确高度
      .scrollBar(BarState.Off) // 显式启用滚动条
      .scrollBarColor('#0099FF') // 设置滚动条颜色
      .scrollBarWidth(10) // 设置滚动条宽度


    }
      .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight)})
      Button('申请')
        .fontSize(15)
        .padding(10)
        .fontColor('#ffffff')
        .width(50)
        .height(50)
        .backgroundColor('#0000ff')
        .onClick(()=>{
          router.pushUrl({url:'pages/QingJia/QingJiaShengQing'})

        })

    }
    .width('100%')
    .height('100%') // 确保Stack也有明确高度
  }
}