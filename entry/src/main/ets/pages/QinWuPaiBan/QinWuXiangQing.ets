import router from '@ohos.router';

// 定义值班数据接口
interface ZhiBanRecord {
  name: string; // 值班名称
  person: string; // 值班人员
  department: string; // 所属部门
  location: string; // 执勤点
  template: string; // 值班模板
  date: string; // 勤务日期
  category: string; // 勤务分类
  subCategory: string; // 勤务子分类
  shiftName: string; // 班次名称
  timeRange: string; // 班次时段
  members: string; // 共同值班警员
  resultDesc: string; // 值班结果描述
  images: string[]; // 图片路径数组
  status: string; // 状态
}

@Entry
@Component
struct QinWuXiangQing {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;

  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  // 定义为单个对象而非数组，因为详情页通常展示单条记录
  @State zhiBanData: ZhiBanRecord = {
    name: '带班领导',
    person: '张亚飞',
    department: '成都市公安局交警大队',
    location: '巡区一区',
    template: '模板一',
    date: '2021-4-11',
    category: '部门值班',
    subCategory: '带班领导',
    shiftName: '早高峰巡逻',
    timeRange: '8:00:00-18:00:00',
    members: '刘能、邓杰、黎明',
    resultDesc: '处理了5项临时任务',
    images: ['$r("app.media.work1")', '$r("app.media.work2")'],
    status: '待审核'
  };

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(24)
          .fontColor('#000000')
          .onClick(() => router.back())

        Blank()

        Text('值班记录详情')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Blank()
      }
      .width('100%')
      .height(50)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#FFFFFF')

      // 内容区域
      Scroll() {
        Column({ space: 0 }) {
          // 基本信息
          this.InfoRow('值班名称', this.zhiBanData.name)
          this.InfoRow('值班人员', this.zhiBanData.person)
          this.InfoRow('所属部门', this.zhiBanData.department)
          this.InfoRow('执勤点', this.zhiBanData.location)
          this.InfoRow('值班模板', this.zhiBanData.template)
          this.InfoRow('勤务日期', this.zhiBanData.date)
          this.InfoRow('勤务分类', this.zhiBanData.category)
          this.InfoRow('勤务子分类', this.zhiBanData.subCategory)
          this.InfoRow('班次名称', this.zhiBanData.shiftName)
          this.InfoRow('班次时段', this.zhiBanData.timeRange)
          this.InfoRow('共同值班警员', this.zhiBanData.members)

          // 值班结果信息标题
          Row() {
            Text('值班结果信息')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
          }
          .width('100%')
          .height(50)
          .padding({ left: 15 })
          .backgroundColor('#F8F8F8')
          .alignItems(VerticalAlign.Center)

          // 值班结果描述
          this.InfoRow('值班结果描述', this.zhiBanData.resultDesc)

          // 图片区域
          Column({ space: 10 }) {
            Row() {
              Text('图片')
                .fontSize(14)
                .fontColor('#666666')
                .width(80)

              Blank()
            }
            .width('100%')
            .padding({ left: 15, right: 15 })

            // 图片网格
            Row({ space: 10 }) {
              ForEach(this.zhiBanData.images, (image: string) => {
                Image(image) // 使用循环中的image变量而非固定值
                  .width(80)
                  .height(80)
                  .borderRadius(8)
                  .backgroundColor('#E3F2FD')
                  .objectFit(ImageFit.Cover)
              })
            }
            .width('100%')
            .padding({ left: 15, right: 15 })
          }
          .padding({ top: 15, bottom: 15 })
          .backgroundColor('#FFFFFF')
          .border({
            width: { bottom: 0.5 },
            color: '#E5E5E5'
          })

          // 状态
          this.InfoRow('状态', this.zhiBanData.status, '#FF9800')
        }
      }
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }

  @Builder
  InfoRow(label: string, value: string, valueColor?: string) {
    Row() {
      Text(label)
        .fontSize(14)
        .fontColor('#666666')
        .width(80)
        .textAlign(TextAlign.Start)

      Blank()

      Text(value)
        .fontSize(14)
        .fontColor(valueColor || '#333333')
        .textAlign(TextAlign.End)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)
    }
    .width('100%')
    .height(50)
    .padding({ left: 15, right: 15 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .border({
      width: { bottom: 0.5 },
      color: '#E5E5E5'
    })
  }
}
