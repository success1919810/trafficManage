import { router } from '@kit.ArkUI';

@Entry
@Component
struct AbnormalWarningFeedback {
  @State recordId: string = '';
  @State feedbackContent: string = '';

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params.recordId) {
      this.recordId = params.recordId as string;
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(40)
          .margin({ bottom: 30 })
          .width('10%')
          .onClick(() => {
            router.back();
          })

        Text('异常警情反馈')
          .fontSize(20)
          .margin({ bottom: 0 })
          .textAlign(TextAlign.Center)
          .width('80%')

        Text('<')
          .fontSize(26)
          .fontColor('#F2F2F2')
          .margin({ bottom: 20 })
          .width('10%')
      }
      .backgroundColor('#F2F2F2')
      .width('100%')
      .height(50)
      .margin({ top: 40 })

      // 滚动内容区域
      Scroll() {
        Column() {
          // 异常信息标题
          Text('异常信息')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 16 })

          // 异常信息详情
          this.buildInfoRow('异常类型', '超时未签收')
          this.buildInfoRow('人员名称', '张亚飞')
          this.buildInfoRow('所属部门', '内江市交警支队一大队')
          this.buildInfoRow('异常时间', '2021-4-11\n10:25:45')

          // 调度单信息标题
          Text('调度单信息')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: 24, bottom: 16 })

          // 调度单信息详情
          this.buildInfoRow('派单单位', '内江市交警支队')
          this.buildInfoRow('派单时间', '2021-4-11 10:35:45')
          this.buildInfoRow('派单人员', '李刚')
          this.buildInfoRow('联系电话', '15889126789')

          // 警情基本信息标题
          Text('警情基本信息')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: 24, bottom: 16 })

          // 警情基本信息详情
          this.buildInfoRow('所属部门', '内江市交警支队一大队')
          this.buildInfoRow('报警时间', '2021-4-11 8:30:40')
          this.buildInfoRow('警情地点', '内江市东兴区汉安大道中段25')
          this.buildInfoRow('警情来源', '96122接处警')
          this.buildInfoRow('警情分类', '应急警情')
          this.buildInfoRow('警情类型', '交通事故现场处置')
          this.buildInfoRow('警情级别', '一般')
          this.buildInfoRow('警情描述', '该路段发生一起车祸，两车追尾，暂无人员伤亡')

          // 视频图片标题
          Text('视频图片')
            .fontSize(16)
            .fontColor('#666666')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: 16, bottom: 12 })

          // 图片展示区域
          Row({ space: 8 }) {
            ForEach([1, 2, 3], (index: number) => {
              Image($r('app.media.tu'))
                .width(100)
                .height(80)
                .backgroundColor('#F0F0F0')
                .borderRadius(4)
                .onClick(() => {
                  console.log(`查看图片 ${index}`);
                })
            })
          }
          .width('100%')
          .margin({ bottom: 16 })

          // 扩充信息
          this.buildInfoRow('接警民警', '张亚飞')
          this.buildInfoRow('报警人', '刘磊')
          this.buildInfoRow('报警人性别', '男')
          this.buildInfoRow('联系电话', '15889126789')
          this.buildInfoRow('报警方式', '电话报警')

          // 反馈信息标题
          Text('反馈信息')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: 24, bottom: 16 })

          // 反馈内容标签
          Text('反馈内容：')
            .fontSize(16)
            .fontColor('#666666')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 8 })

          // 反馈内容输入框
          TextArea({ placeholder: '输入反馈内容......' })
            .width('100%')
            .height(120)
            .backgroundColor('#F8F8F8')
            .borderRadius(4)
            .fontSize(16)
            .onChange((value: string) => {
              this.feedbackContent = value;
            })
            .margin({ bottom: 16 })

          // 图片上传标签
          Text('图片：')
            .fontSize(16)
            .fontColor('#666666')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 8 })

          // 图片上传区域
          Column() {
            Text('+')
              .fontSize(40)
              .fontColor('#CCCCCC')
          }
          .width(80)
          .height(80)
          .backgroundColor('#F8F8F8')
          .borderRadius(4)
          .border({
            width: 1,
            color: '#E0E0E0',
            style: BorderStyle.Dashed
          })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            console.log('选择图片');
          })
          .margin({ bottom: 30 })

          // 底部按钮区域
          Row({ space: 16 }) {
            Button('取消')
              .fontSize(16)
              .fontColor('#666666')
              .backgroundColor('#F0F0F0')
              .borderRadius(4)
              .width(120)
              .height(44)
              .onClick(() => {
                router.back();
              })

            Button('提交')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .backgroundColor('#007AFF')
              .borderRadius(4)
              .width(120)
              .height(44)
              .onClick(() => {
                console.log('提交反馈');
                // 处理提交逻辑
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: 30 })
        }
      }
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildInfoRow(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(16)
        .fontColor('#666666')
        .width(80)
        .textAlign(TextAlign.Start)

      Text(value)
        .fontSize(16)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .border({
      width: { bottom: 1 },
      color: '#F0F0F0'
    })
  }
}