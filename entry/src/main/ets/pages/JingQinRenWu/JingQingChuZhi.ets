import router from '@ohos.router';



@Entry
@Component
struct Jingqingqianshou {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @State message: string = 'Hello World';

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
        Text('警情处置')
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
      Scroll(){
        Column(){
          Text('调度单信息')
            .fontWeight(20)
            .width('95%')
            .fontSize(20)
            .margin(15)
          Row(){
            Text('派单单位')
            Text('内江市交警支队')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('派单时间')
            Text('2021-4-11 8:30:45')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('派单人员')
            Text('李刚')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('联系电话')
            Text('15889126789')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Text('警情基本信息')
            .fontWeight(20)
            .width('95%')
            .fontSize(20)
            .margin(15)
          Row(){
            Text('所属部门')
            Text('内江市交警支队一大队')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('报警时间')
            Text('2021-4-11 8:30:40')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('警情地点')
            Text('内江省东兴区汉安大道中段25')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('警情来源')
            Text('96122接处警')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('警情分类')
            Text('应急警情')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('警情类型')
            Text('交通事故现场处置')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('警情级别')
            Text('一般')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row({space:20}){
            Text('警情描述')
            Column(){
              Text('该路段发生一起车祸，两车')
              Text('追尾，暂无人员伤亡')
            }
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Column(){
            Text('视频图片')
              .width('90%')
            Row(){
              Image($r('app.media.background'))
                .width(80)
                .height(80)
              Image($r('app.media.background'))
                .width(80)
                .height(80)
              Image($r('app.media.background'))
                .width(80)
                .height(80)
            }.justifyContent(FlexAlign.SpaceBetween)
            .width('90%')
          }
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('接警民警')
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
            Text('报警人')
            Text('刘磊')
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('90%')
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('报警人性别')
            Text('男')
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('90%')
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('联系电话')

            Text('15889126789')

          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('90%')
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row(){
            Text('报警方式')
            Text('电话报警')
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('90%')
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Text('反馈信息')
            .fontWeight(20)
            .width('95%')
            .fontSize(18)
            .margin(25)
          Row(){
            Text('增员数量')
            Text('无需增员')
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('90%')
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Row({space:20}){
            Text('情况描述')
            Column(){
              Text('现场情况自己可以解决')
              Text('无需在增派人员')
            }
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('3')
            .width('90%')
            .backgroundColor('#f0f0f0')
            .margin(10)
          Text('处置信息')
            .fontWeight(20)
            .width('95%')
            .fontSize(18)
            .margin(25)
          Text('处置描述:')
            .width('90%')
          Text('输入描述内容...')
            .width('100%')
            .height('100%')
            .padding(10) // 文本与边框的内边距
            .fontColor('#666666') // 文本颜色设为灰色，更符合提示文字风格
            .width('90%')
            .height(100)
            .margin(15)
            .border({
              width: 1,
              color: '#E5E5E5', // 浅灰色边框，常见于输入提示区域
              style: BorderStyle.Solid
            })
          Row(){
            Text('语音反馈:')
              .margin(15)
            Button('点击说话')
              .width('30%')
              .height(20)
              .fontSize(16)
              .backgroundColor('#ffffff') // 保持白色背景
              .fontColor('#000000') // 文字改为黑色
              .border({ width: 1, color: '#000000'})
              .borderRadius(2)
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          Text('视频图片:')
            .width('90%')
          Button('+')
            .width(80)
            .height(80)
            .border({ width: 1, color: '#CCCCCC' })
            .onClick(() => {
              // 这里可调用图片选择、上传逻辑，比如唤起系统相册等
            });
          Row(){
            Button('取消')
              .width('40%')
              .height(40)
              .fontSize(16)
              .backgroundColor('#ffffff')
              .fontColor('#007aff')
              .borderRadius(6)
              .border({ width: 1, color: '#007aff' })
            Button('处置反馈')
              .width('40%')
              .height(40)
              .fontSize(16)
              .backgroundColor('#007aff')
              .fontColor('#ffffff')
              .borderRadius(6) .border({ width: 1, color: '#007aff' })
          }
          .width('90%')
          .margin(20)
          .justifyContent(FlexAlign.SpaceBetween)
          Row()
            .height('10%')
        }
      }
      .height('100%')
    }
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight)})
  }
}