import { router } from '@kit.ArkUI';

interface DutySchedule {
  id: string;
  name: string;
  location: string;
  date: string;
  timeSlot: string;
}

@Entry
@Component
struct DutyPlan {
  @State dutySchedules: DutySchedule[] = [
    {
      id: '1',
      name: '张亚飞',
      location: '巡区一区',
      date: '2020-4-11',
      timeSlot: '8:30:00-12:00:00'
    },
    {
      id: '2',
      name: '张亚飞',
      location: '巡区一区',
      date: '2020-4-12',
      timeSlot: '8:30:00-12:00:00'
    }
  ];

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

        Text('值班计划')
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

      Row().height(2).backgroundColor('#F2F2F2').width('100%')

      // 值班计划列表
      List() {
        ForEach(this.dutySchedules, (schedule: DutySchedule) => {
          ListItem() {
            this.buildDutyCard(schedule)
          }
          .margin({ bottom: 16 })
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 20 })

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
          // 确定逻辑
          router.back();
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildDutyCard(schedule: DutySchedule) {
    Column() {
      // 姓名和调整按钮
      Row() {
        Text(schedule.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007AFF')

        Blank()

        Button('调整')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .backgroundColor('#007AFF')
          .borderRadius(4)
          .padding({ left: 16, right: 16, top: 6, bottom: 6 })
          .onClick(() => {
            // 调整逻辑
            console.log(`调整值班计划: ${schedule.id}`)
          })
      }
      .width('100%')
      Row().height(2).backgroundColor('#F2F2F2').width('100%')
      // 详细信息
      Column({ space: 12 }) {
        Row() {
          Text('执勤点：')
            .fontSize(16)
            .fontColor('#333333')
            .width(80)

          Text(schedule.location)
            .fontSize(16)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('值班日期：')
            .fontSize(16)
            .fontColor('#333333')
            .width(80)

          Text(schedule.date)
            .fontSize(16)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('班次时段：')
            .fontSize(16)
            .fontColor('#333333')
            .width(80)

          Text(schedule.timeSlot)
            .fontSize(16)
            .fontColor('#666666')
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#00000010', offsetY: 1 })
  }
}