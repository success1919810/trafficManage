import router from '@ohos.router';

interface Item1{
  name:string
  id:string
  bumen:string
  job:string//监督结果
  date:string
  time:string
  address:string
  kind:string
  qinWuKind:string
  qinWuZiKind:string
  chePaiNumber:string
}

@Entry
@Component
struct JiXiaoFanKui {
  @State message: string = 'Hello World';
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @State datas:Item1[]=[
    {name:'温迪',id:'qj2020411001',bumen:'蒙德城骑兵队第一支队',job:'异常',kind:'越界',date:'2021-4-11 10:01:20',time:'8小时',address:'汉安大道中段',qinWuKind:'路面勤务',qinWuZiKind:'指挥调度',chePaiNumber:'川K.2345警'}
  ]
  build() {
    Scroll(){
      Column({space:10}){
      Row() {
        Button()
          .width(30)
          .height(40)
          .backgroundImage($r('app.media.back'))
          .backgroundImageSize(ImageSize.Cover)
          .backgroundColor('#F2F2F2')
          .margin({ right: 100 })
          .onClick(() => {
            router.back()
          })
        Text('异常反馈')
          .fontSize(17)
          .fontColor('#83000000')
          .padding(10)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#F2F2F2')
      Text('异常信息')
        .fontSize(25)
        .fontColor('#000000')
        .width('90%')
        .margin(10)

      Row() {
        Text('异常人员:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].name)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('所属部门:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].bumen)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('监督结果:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].job)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('异常类型:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].kind)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('异常时间:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].date)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('执勤点:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].address)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Text('值班信息')
        .fontSize(25)
        .fontColor('#000000')
        .width('90%')
        .margin(10)
      Row() {
        Text('值班人员:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].name)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('异常类型:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].bumen)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('执勤点:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].address)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('值班日期:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].date)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('勤务类型:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].qinWuKind)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('勤务子类型:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].qinWuZiKind)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('班次名称:')
          .fontSize(20)
          .fontColor('#000000')
        Text('晚班')
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('班次时间:')
          .fontSize(20)
          .fontColor('#000000')
        Text('12:00-15:00')
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('出行方式:')
          .fontSize(20)
          .fontColor('#000000')
        Text('车巡')
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
        Row() {
          Text('车牌号码:')
            .fontSize(20)
            .fontColor('#000000')
          Text(this.datas[0].chePaiNumber)
            .fontSize(20)
            .fontColor('#999999')
        }
        .width('90%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
        }
        .width('90%')
        .height(1)
        .backgroundColor('#999999')
        Text('反馈意见:')
          .fontSize(20)
          .fontColor('#000000')
          .width('100%')
        TextInput({placeholder:'请输入反馈意见'})
          .width('90%')
          .height(40)
          .fontSize(20)
          .fontColor('#999999')
          .backgroundColor('#ffffff')
          .borderWidth(2)
          .borderColor('#999999')
          .borderRadius(0)

          Text('图片:')
            .fontSize(20)
            .fontColor('#000000')
            .width('100%')
          Button('+')
            .width(90)
            .height(90)
            .fontSize(20)
            .fontColor('#000000')
            .border({ width: 1, color: '#CCCCCC' })
            .backgroundColor('#ffffff')
            .margin({right:100})
            .onClick(() => {
              // 这里可调用图片选择、上传逻辑，比如唤起系统相册等
            })
          Button('提交')
          .width(100)
          .height(60)
          .fontSize(20)
          .fontColor('#ffffff')
          .backgroundColor('#0000ff')
          .margin({top:20})



    }
      .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
  }
}