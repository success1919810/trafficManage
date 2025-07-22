import router from '@ohos.router';
// 定义参数类型接口
interface ShiftParams {
  date: string;
  location: string;
  shiftName: string;
  time: string;
}

@Entry
@Component
struct Qinwutijiao {
  private date: string = '';
  private location: string = '';
  private shiftName: string = '';
  private time: string = '';
  private description: string = '';
  private imagePaths: string[] = [
    'common/images/default_img.png', // 替换成真实默认图片路径
    'common/images/default_img.png'
  ];
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
        Text('提交值班')
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
          Text('值班结果信息').fontWeight(FontWeight.Bold).textAlign(TextAlign.Start)
        // 1. 输入描述文本框
        TextInput({ placeholder: '输入描述......' })
          .width('100%')
          .height('10%') // 可根据需求调整高度
          .border({ width: 1, color: '#ffffff', radius: 5 })
          .onChange((value: string) => {
            this.description = value;
          })

        // 2. 图片区域：标题 + 已有图片 + 加号 + 角标
        Column() {
          Text('图片')
            .fontSize(16)
            .margin({ bottom: 5 });

          Row({ space: 10 }) {
            // 遍历已选图片，展示预览
            ForEach(this.imagePaths, (imgPath: string) => {
              Image(imgPath)
                .width(80)
                .height(80)
                .border({ width: 1, color: '#999999' });
            }, (item: string) => item);

            // 加号 + 角标布局
            Stack() {
              Button('+')
                .width(80)
                .height(80)
                .border({ width: 1, color: '#999999', radius: 3 });
              // 角标
              Text('1')
                .fontSize(12)
                .fontColor('#ffffff')
                .backgroundColor('#FF0000')
                .width(20)
                .height(20)
                .borderRadius(10)
                .textAlign(TextAlign.Center)
                .position({ x: 65, y: -5 });
            }.margin({left:0})
            .onClick(() => {
              console.log('点击了添加图片按钮');
            });
          }
        }.justifyContent(FlexAlign.Start)
        Column(){
          Text('共同提交')
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
