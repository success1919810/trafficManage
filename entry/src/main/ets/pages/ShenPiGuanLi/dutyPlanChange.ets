import { router } from '@kit.ArkUI';

@Entry
@Component
struct DutyPlanAdjust {
  @State selectedPerson: string = '赵四';
  @State department: string = '成都市公安局交警大队';
  @State duty: string = '辅警';
  @State dutyPoint: string = '巡区一区';
  @State dutyDate: string = '2021-4-11';
  @State dutyCategory: string = '部门值班';
  @State dutySubCategory: string = '带班领导';
  @State shiftName: string = '早高峰巡逻';
  @State shiftTime: string = '8:00:00-18:00:00';
  @State coWorkers: string = '刘能、邓杰、黎明';

  // 人员选择选项
  @State personOptions: string[] = ['赵四', '张三', '李四', '王五', '刘能'];

  build() {
    Column() {
      // 标题栏 - 使用您提供的模板
      Row(){
        Text('<')
          .fontSize(40)
          .margin({bottom:30})
          .width('10%')
          .onClick(() => {
            router.back();
          })

        Text('值班计划调整')
          .fontSize(20)
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('80%')

        Text('<')
          .fontSize(26)
          .fontColor('#F2F2F2')
          .margin({bottom:20})
          .width('10%')
      }.backgroundColor('#F2F2F2').width('100%').height(50).margin({ top: 40 });


      // 表单内容
      Column() {
        // 值班人员选择
        Row() {
          Text('值班人员')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Select([
            { value: '赵四' },
            { value: '张三' },
            { value: '李四' },
            { value: '王五' },
            { value: '刘能' }
          ])
            .selected(0)
            .value(this.selectedPerson)
            .font({ size: 16, weight: 400 })
            .fontColor('#666666')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .backgroundColor('#FFFFFF')
            .onSelect((index: number) => {
              this.selectedPerson = this.personOptions[index];
            })
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Divider().color('#E5E5E5')

        // 所属部门
        Row() {
          Text('所属部门')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Text(this.department)
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Divider().color('#E5E5E5')

        // 职务
        Row() {
          Text('职    务')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Text(this.duty)
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Divider().color('#E5E5E5')

        // 执勤点
        Row() {
          Text('执勤点')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Text(this.dutyPoint)
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Divider().color('#E5E5E5')

        // 勤务日期
        Row() {
          Text('勤务日期')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Text(this.dutyDate)
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Divider().color('#E5E5E5')

        // 勤务分类
        Row() {
          Text('勤务分类')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Text(this.dutyCategory)
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Divider().color('#E5E5E5')

        // 勤务子分类
        Row() {
          Text('勤务子分类')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Text(this.dutySubCategory)
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Divider().color('#E5E5E5')

        // 班次名称
        Row() {
          Text('班次名称')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Text(this.shiftName)
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Divider().color('#E5E5E5')

        // 班次时段
        Row() {
          Text('班次时段')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Text(this.shiftTime)
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Center)

        Divider().color('#E5E5E5')

        // 共同值班警员
        Row() {
          Text('共同值班警员')
            .fontSize(16)
            .fontColor('#333333')
            .width(100)

          Blank()

          Text(this.coWorkers)
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
            .maxLines(2)
        }
        .width('100%')
        .padding({ top: 20, bottom: 20 })
        .alignItems(VerticalAlign.Top)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .backgroundColor('#FFFFFF')
      .margin({ top: 10 })

      Blank()

      // 底部确定按钮
      Button('确定')
        .fontSize(18)
        .fontColor('#FFFFFF')
        .backgroundColor('#007AFF')
        .borderRadius(8)
        .width('80%')
        .height(50)
        .margin({ bottom: 40 })
        .onClick(() => {
          // 保存调整后的值班计划
          console.log('保存值班计划调整');
          router.back();
        })
    }
    .width('100%')
    .height('100%')
  }
}