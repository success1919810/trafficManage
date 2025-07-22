import router from '@ohos.router';



@Entry
@Component
struct Jingqingqianshou {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @State message: string = 'Hello World';

  private selectedType: string = 'all';
  @State text: string = "请假中";
  @State index: number = 2;
  @State space: number = 8;

  build() {
    Column(){
      Row(){
        Button('<')
          .fontSize(22)
          .backgroundColor('#007AFF') // 主色调背景
          .fontColor('#FFFFFF')
          .borderRadius(5)
          .padding({ left: 10, right: 10 })
          .onClick(() => router.back());

        // 标题（居中）
        Text('任务退回')
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

      Row(){
        Text('任务编号')

        Text('TZ20211230001')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      .margin({top:10})
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('任务人员')

        Text('张亚飞')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('所属部门')

        Text('内江市交警支队一大队')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('任务名称')

        Text('12月份领导视察')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('任务地点')

        Text('金科北路122号')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('任务时间')

        Text('2021-12-30 14:00:00')

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('退回原因:')

      Select([{ value: '请假中' }, { value: '任务中' }, { value: '其他原因' }])
        .selected(this.index)
        .value(this.text)
        .width(150)
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
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      Row()
        .height('3')
        .width('90%')
        .backgroundColor('#f0f0f0')
        .margin(10)
      Row(){
        Text('其他原因')
       Text('填写其他原因...')
         .fontColor('#666666')
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('90%')

    }
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight)})
  }
}