import router from '@ohos.router';

// 定义参数类型接口
interface ShiftParams {
  date: string;
  location: string;
  shiftName: string;
  time: string;
}

// 定义Select选项类型
interface SelectOption {
  value: string;
  label?: string;
}

@Entry
@Component
struct Qinwushenqing {
  private date: string = '';
  private location: string = '';
  private shiftName: string = '';
  private time: string = '';
  // 修正：将字符串数组改为SelectOption数组
  private adjustPersons: SelectOption[] = [
    { value: '张磊' },
    { value: '王强' },
    { value: '赵敏' },
    { value: '李军' }
  ];
  private selectedPerson: string = '张磊';
  private adjustReason: string = '';

  aboutToAppear() {
    // 类型断言为定义的接口类型
    const params = router.getParams() as ShiftParams;

    if (params) {
      this.date = params.date;
      this.location = params.location;
      this.shiftName = params.shiftName;
      this.time = params.time;
    }
  }
  @StorageProp('bottomRectHeight')
  bottomRectHeight:number = 0;
  @StorageProp('topRectHeight')
  topRectHeight:number = 0;
  build() {
    Column() {
      Stack(){
        Text('申请调整')
          .fontColor('#000000')
          .fontSize(20)
          .width('100%')
          .height(50)
          .backgroundColor('#F2F2F2')
          .textAlign(TextAlign.Center)
        Text('<')
          .fontSize(50)
          .onClick(() => router.back())
          .width('100%')
          .textAlign(TextAlign.Start)
      }

      Column({space:10}){
        Column(){
          Row(){
            Text('值班人员').fontColor('#000000')
            Text('张亚飞').fontColor('#999999')
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          Row().width('100%').height(1).backgroundColor('#999999')
        }

        Column(){
          Row(){
            Text('所属部门').fontColor('#000000')
            Text('XXX公安局交警大队').fontColor('#999999')
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          Row().width('100%').height(1).backgroundColor('#999999')
        }

        Column(){
          Row(){
            Text('执勤点').fontColor('#000000')
            Text(`${this.location}`).fontColor('#999999')
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          Row().width('100%').height(1).backgroundColor('#999999')
        }

        Column(){
          Row(){
            Text('勤务日期').fontColor('#000000')
            Text(`${this.date}`).fontColor('#999999')
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          Row().width('100%').height(1).backgroundColor('#999999')
        }

        Column(){
          Row(){
            Text('勤务分类').fontColor('#000000')
            Text('部门值班').fontColor('#999999')
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          Row().width('100%').height(1).backgroundColor('#999999')
        }

        Column(){
          Row(){
            Text('勤务子分类').fontColor('#000000')
            Text('带班领导').fontColor('#999999')
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          Row().width('100%').height(1).backgroundColor('#999999')
        }

        Column(){
          Row(){
            Text('班次名称').fontColor('#000000')
            Text(`${this.shiftName}`).fontColor('#999999')
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          Row().width('100%').height(1).backgroundColor('#999999')
        }

        Column(){
          Row(){
            Text('班次时段').fontColor('#000000')
            Text(`${this.time}`).fontColor('#999999')
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          Row().width('100%').height(1).backgroundColor('#999999')
        }

        Column(){
          Row(){
            Text('共同值班警员').fontColor('#000000')
            Text('刘能、邓杰、黎明').fontColor('#999999')
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          Row().width('100%').height(1).backgroundColor('#999999')
        }
          Text('调整信息').fontWeight(FontWeight.Bold).textAlign(TextAlign.Start)
        // 修正：调整信息（下拉选择框）
        Column (){
          Row (){
            Text ('调整人员').fontColor ('#000000')
            Select (this.adjustPersons)
              .value (this.selectedPerson)
              // 修正：添加参数value并正确赋值
              .onSelect ((index: number, value: string) => {
                this.selectedPerson = value;
              })
              .fontColor ('#999999')
              .backgroundColor('#ffffff')
          }.justifyContent (FlexAlign.SpaceBetween)
          .width ('100%')
          Row ().width ('100%').height (1).backgroundColor ('#999999')
        }.justifyContent(FlexAlign.Start)

        // 调整原因（输入框）
        Column (){
          Row (){
            Text ('调整原因：').fontColor ('#000000')
            TextInput ({ placeholder: '输入调整原因......' })
              .fontColor ('#999999')
              .backgroundColor('#ffffff')
              .width ('100%')
              .onChange ((value: string) => {
                this.adjustReason = value;
              })
          }.justifyContent (FlexAlign.SpaceBetween)
          .width ('100%')
          Row ().width ('100%').height (1).backgroundColor ('#999999')
        }.justifyContent(FlexAlign.Start)
        Column(){
          Text('提交')
            .width('100%')
            .height('5%')
            .fontColor('#ffffff')
            .backgroundColor('#0099FF')
            .margin({top:'30%'})
            .textAlign(TextAlign.Center)
            .borderRadius(5)
        }
      }.padding(16)
    }
    .padding({top: px2vp(this.topRectHeight),bottom:px2vp(this.bottomRectHeight)})
    .width('100%')
    .height('100%')
  }
}
