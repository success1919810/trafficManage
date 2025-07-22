import router from '@ohos.router';


interface Item1{
  name:string
  id:string
  bumen:string
  job:string
  date:string
  time:string
  reason:string
}
@Entry
@Component
struct QingJiaXiuGai {
  @State message: string = 'Hello World';
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @State datas:Item1[]=[
    {name:'温迪',id:'qj2020411001',bumen:'蒙德城骑兵队第一支队',job:'辅警',date:'2021-4-11 10:01:20',time:'8小时',reason:'家中有事请假一天'}
  ]
  private selectedType: string = 'all';
  @State text: string = "    事假    ";
  @State index: number = 2;
  @State space: number = 8;
  @State finish:string =this.datas[0].date
  @State currentTime: string = this.getCurrentTime()

  timer: number = 0

  getCurrentTime(): string {
    const date = new Date()
    return date.toLocaleString()
  }

  onPageShow() {
    this.timer = setInterval(() => {
      this.currentTime = this.getCurrentTime()
    }, 1000)
  }

  onPageHide() {
    clearInterval(this.timer)
  }
  build() {

    Column({ space: 10 }) {
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
        Text('请假销假')
          .fontSize(17)
          .fontColor('#83000000')
          .padding(10)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#F2F2F2')

      Row() {
        Text('请假编号:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].id)
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
        Text('请假人员:')
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
        Text('职务:')
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
        Text('申请时间:')
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
        Text('请假类型:')
          .fontSize(20)
          .fontColor('#000000')
        Select([{ value: '事假' }, { value: '婚假' }, { value: '出差' }])
          .selected(this.index)
          .value(this.text)
          .font({ size: 16, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 16, weight: 400 })
          .optionFont({ size: 16, weight: 400 })
          .space(this.space)
          .borderRadius(0)
          .menuAlign(MenuAlignType.START, { dx: 0, dy: 0 })
          .optionWidth(120)
          .optionHeight(300)
          .onSelect((index: number, text?: string | undefined) => {
            console.info('Select:' + index);
            this.index = index;
            if (text) {
              this.text = text;
            }
          })
          .avoidance(AvoidanceMode.COVER_TARGET)
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')

      Row() {
        Text('请假开始时间:')
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
        Text('请假结束时间')
          .fontSize(20)
          .fontColor('#000000')
        TextInput({ placeholder: this.finish })
          .width(200)
          .height(40)
          .fontSize(20)
          .fontColor('#999999')
          .borderRadius(0)
          .onChange((value: string) => {
            this.finish = value
          })
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')

      Row() {
        Text('请假时长')
          .fontSize(20)
          .fontColor('#000000')
        TextInput({ placeholder: this.datas[0].time })
          .width(200)
          .height(40)
          .fontSize(20)
          .fontColor('#999999')
          .borderRadius(0)
          .onChange((value: string) => {
            this.datas[0].time = value
          })
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')

      Row() {
        Text('请假原因')
          .fontSize(20)
          .fontColor('#000000')
        TextInput({ placeholder: this.datas[0].reason })
          .width(200)
          .height(40)
          .fontSize(20)
          .fontColor('#999999')
          .borderRadius(0)

      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Text('销假信息')
        .fontColor('#000000')
        .fontSize(20)
        .width('90%')
      Row() {
        Text('请假结束时间')
          .fontSize(20)
          .fontColor('#000000')
        TextInput({ placeholder: '请输入结束时间'})
          .width(200)
          .height(40)
          .fontSize(20)
          .fontColor('#999999')
          .borderRadius(0)
          .onChange((value: string) => {
            this.finish = value
          })
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
      Row() {
        Text('请假时长')
          .fontSize(20)
          .fontColor('#000000')
        TextInput({ placeholder: '请输入请假时长' })
          .width(200)
          .height(40)
          .fontSize(20)
          .fontColor('#999999')
          .borderRadius(0)
          .onChange((value: string) => {
            this.datas[0].time = value
          })
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
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
}