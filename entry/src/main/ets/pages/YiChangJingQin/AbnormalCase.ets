import { router } from '@kit.ArkUI';
import { text } from '@kit.ArkGraphics2D';

@Entry
@Component
struct AbnormalCase {
  @State message: string = 'Hello World';
  @State index: number = 2;
  @State space: number = 8;
  @State arrowPosition: ArrowPosition = ArrowPosition.END;
  @State text: string = "  月份 ";

  build() {
    Column() {
      // 顶部导航栏
      Row(){
        Text('<')
          .fontSize(40)
          .margin({bottom:30})
          .width('10%')
          .onClick(() => {
            // 调用路由返回方法，回到上一级页面（Workbench）
            router.back();
          })

        Text('异常勤务')
          .fontSize(20)
          // 去掉 bottom margin，避免干扰垂直居中
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('80%')
        Text('<')
          .fontSize(26)
          .fontColor('#F2F2F2')
          .margin({bottom:20})
          .width('10%')
      }.backgroundColor('#F2F2F2').width('100%').height(40).margin({ top: 40 }); // 增加顶部外边距，值可根据实际需求调整
      Row().height(2).backgroundColor('#f2f2f2').width('100%')

      Row(){
        Select([{ value: '一月' }, { value: '二月' },{ value: '三月' },{ value: '四月' },{ value: '五月' },{ value: '六月' },{ value: '七月' },{ value: '八月' },{ value: '九月' },{ value: '十月' },{ value: '十一月' },{ value: '十二月' }])
          .selected(this.index)
          .backgroundColor("#ffffff")
          .value(this.text)
          .font({ size: 16, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 16, weight: 400 })
          .optionFont({ size: 16, weight: 400 })
          .space(this.space)
          .arrowPosition(this.arrowPosition)
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
      }
      .width('100%')
      .margin({ top: 0 })
      .padding({ left: 10})


      // 使用正确的组件引用方式
      Report()
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffffff')
  }
}

// 列表接口定义
interface Item1 {
  text1: string;
  text2: string;
  text3: string;
  text4: string;
  text5: string;
  text6: string;
}

// 上报内容组件 - 类名首字母大写符合规范
@Component
struct Report {
  // 模拟数据
  datas: Item1[] = [
    { text1: '异常', text2: '反馈', text3: '异常类型： 脱岗', text4: '执勤点： 内江收费站', text5: '异常日期： 2021-4-11', text6: '状态： 待反馈' },
    { text1: '异常', text2: '反馈', text3: '异常类型： 脱岗', text4: '执勤点： 内江收费站', text5: '异常日期： 2021-4-11', text6: '状态： 待反馈' },
    { text1: '异常', text2: '反馈', text3: '异常类型： 脱岗', text4: '执勤点： 内江收费站', text5: '异常日期： 2021-4-11', text6: '状态： 待反馈' },
  ];

  // 列表项 UI 构建器
  @Builder
  myItemUI(item: Item1) {
    Column({ space: 10 }) {
      Row({space:10}) {
        Text(item.text1)
          .fontSize(20)
          .fontColor('#99ff00')

        Text(item.text2)
          .fontSize(20)
          .fontColor('#ADD8E6')
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row().height(2).backgroundColor('#F2F2F2').width('100%')

      Text(item.text3)
        .fontSize(18)
        .fontColor('#000000')

      Text(item.text4)
        .fontSize(18)
        .fontColor('#000000')

      Text(item.text5) // 修正：使用正确的属性名
        .fontSize(18)
        .fontColor('#000000')

      Text(item.text6) // 修正：使用正确的属性名
        .fontSize(18)
        .fontColor('#000000')
    }
    .width('95%')
    .borderColor('#f2f2f2')
    .borderWidth(3)
    .backgroundColor('#ffffff')
    .margin({ top: 15, left: 5, right: 5 })
    .padding(20)
    .borderRadius(15);
  }

  build() {
    List() {
      ForEach(this.datas, (item1: Item1) => {
        ListItem() {
          this.myItemUI(item1)
        }
      });
    }
    .width('100%')
    .backgroundColor('#ffffff')
    .width('100%')
    .height('100%');
  }
}