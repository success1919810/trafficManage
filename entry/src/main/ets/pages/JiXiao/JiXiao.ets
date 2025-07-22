import router from '@ohos.router';

interface Item1{
  date:number
  time:string
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
    {date:93,time:'2021-4',type:'待反馈'},
    {date:93,time:'2021-4',type:'待确认'},
    {date:93,time:'2021-4',type:'已完成'},
    {date:93,time:'2021-4',type:'已完成'},
    {date:93,time:'2021-4',type:'已完成'}
  ]
  @Builder
  myItemUI(item:Item1){

    Column({space:10}){
      Row(){
        Text('绩效分数:')
          .fontSize(15)
          .fontColor('#0099FF')
        Text(this.datas[0].date+"")
          .fontSize(15)
          .fontColor('#0099FF')
        if (item.type=='待反馈'){
          Button('反馈')
            .width(60)
            .height(30)
            .fontSize(15)
            .padding(6)
            .fontColor('#ffffff')
            .backgroundColor('#0099FF')
            .type(ButtonType.Normal)
            .onClick(()=>{
              router.pushUrl({url:'pages/JiXiao/JiXiaoFanKui'})
            })
        }
        else{
          Text('>')
            .width(60)
            .height(40)
            .fontSize(25)
            .fontColor('#0099FF')
            .backgroundColor('#ffffff')
            .padding({left:30})
            .onClick(()=>{
              router.pushUrl({url:'pages/JiXiao/JiXiaoXiangXi'})
            })
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
        Text('考核周期：')
          .fontSize(15)
          .fontColor('#000000')
        Text(item.time)
          .fontSize(15)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({left:60})
      Row(){}
      .height(10)
      .width('100%')
      .backgroundColor('#ffffff')
      Row(){
        Text('结果状态：')
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
          Text('绩效考核')
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


    }


}