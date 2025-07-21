import router from '@ohos.router';

@Entry
@Component
struct Gongdanpingjia {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  @State jiedanRating: number = 0;
  @State weixiuRating: number = 0;
  @State zhiliangRating: number = 0;
  @State evaluationText: string = '';

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(30)
          .fontColor('#000000')
          .borderRadius(5)
          .padding({ left: 10, right: 10 })
          .onClick(() => router.back());

        Text('工单评价')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000');

        Row().width(40)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 15, right: 15 })

      // 内容区域
      Column() {
        // 标题文字
        Column({ space: 10 }) {
          Text('本次运维服务您还满意吗')
            .fontSize(20)
            .fontColor('#FF8C00')
            .fontWeight(FontWeight.Bold)
            .margin({ top: 40 })

          Text('请对本次服务做出评价')
            .fontSize(16)
            .fontColor('#999999')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // 评分区域
        Column({ space: 25 }) {
          // 接单速度
          this.RatingItem('接单速度', this.jiedanRating, (rating: number) => {
            this.jiedanRating = rating;
          })

          // 维修速度
          this.RatingItem('维修速度', this.weixiuRating, (rating: number) => {
            this.weixiuRating = rating;
          })

          // 维修质量
          this.RatingItem('维修质量', this.zhiliangRating, (rating: number) => {
            this.zhiliangRating = rating;
          })
        }
        .width('100%')
        .margin({ top: 40 })
        .padding({ left: 20, right: 20 })

        // 服务评价文本框
        Column({ space: 10 }) {
          Row() {
            Text('服务评价')
              .fontSize(16)
              .fontColor('#333333')
            Blank()
          }
          .width('100%')

          TextArea({
            placeholder: '请输入您的评价...',
            text: this.evaluationText
          })
            .width('100%')
            .height(120)
            .fontSize(14)
            .backgroundColor('#F8F8F8')
            .borderRadius(8)
            .border({ width: 1, color: '#E5E5E5' })
            .onChange((value: string) => {
              this.evaluationText = value;
            })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .margin({ top: 30 })
        .padding({ left: 20, right: 20 })

        // 提交按钮
        Button('提交')
          .width('90%')
          .height(45)
          .backgroundColor('#4FC3F7')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .borderRadius(8)
          .margin({ top: 40 })
          .onClick(() => {
            // 提交评价逻辑
            console.log('接单速度评分:', this.jiedanRating);
            console.log('维修速度评分:', this.weixiuRating);
            console.log('维修质量评分:', this.zhiliangRating);
            console.log('评价内容:', this.evaluationText);

            // 可以在这里添加提交到服务器的逻辑
            router.back();
          })

      }
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .margin({ top: 10 })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }

  @Builder
  RatingItem(label: string, currentRating: number, onRatingChange: (rating: number) => void) {
    Row() {
      Text(label)
        .fontSize(16)
        .fontColor('#333333')
        .width(80)

      Blank()

      Row({ space: 8 }) {
        ForEach([1, 2, 3, 4, 5], (star: number) => {
          Text('★')
            .fontSize(24)
            .fontColor(star <= currentRating ? '#FFD700' : '#E5E5E5')
            .onClick(() => {
              onRatingChange(star);
            })
        })
      }
    }
    .width('100%')
    .height(50)
    .alignItems(VerticalAlign.Center)
  }
}