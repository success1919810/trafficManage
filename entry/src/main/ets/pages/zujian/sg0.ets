import router from '@ohos.router';
// 1. 定义施工信息接口
interface ConstructionInfo {
  location: string;       // 施工地点
  progress: string;       // 进度百分比
  company: string;        // 施工单位
  timeRange: string;      // 施工时间范围
  status: string;         // 状态文本
  statusColor: string;    // 状态颜色
}

@Component
export struct sg0 {
  // 2. 施工数据数组（对应3个卡片）
  private constructionList: ConstructionInfo[] = [
    {
      location: '汉安大道985号',
      progress: '80%',
      company: '中铁三局',
      timeRange: '2021-3-30 - 2021-5-30',
      status: '异常：渣土遗留',
      statusColor: '#FF0000'
    },
    {
      location: '汉安大道985号',
      progress: '80%',
      company: '中铁三局',
      timeRange: '2021-3-30 - 2021-5-30',
      status: '正常：施工中',
      statusColor: '#0000FF'
    },
    {
      location: '汉安大道985号',
      progress: '80%',
      company: '中铁三局',
      timeRange: '2021-3-30 - 2021-5-30',
      status: '已完成',
      statusColor: '#666666'
    }
  ];

  // 3. 提取卡片组件
  @Builder
  private renderConstructionCard(item: ConstructionInfo) {
    Column({ space: 10 }) {
      // 顶部：地点和进度
      Row() {
        Text(item.location)
          .fontSize(20)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)

        Text(`进度: ${item.progress}`)
          .fontSize(16)
          .fontColor('#666666')
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')

      // 中间：施工单位和时间
      Row() {
        Text(`施工单位：${item.company}\n施工时间：${item.timeRange}\n施工时间：${item.timeRange}\n`)
          .fontSize(16)
          .fontColor('#666666')
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')

      // 底部：状态
      Row() {
        Text(item.status)
          .fontSize(14)
          .fontColor(item.statusColor)
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
    }
    .onClick(() => {
      router.pushUrl({
        url: 'pages/ShiGong/ShigongXiangqing'
      });
    })
    .margin({ top: 10 })
    .backgroundColor('#ffffff')
    .borderRadius(10)
  }

  build() {
    // 4. 使用List实现滚动列表
    List() {
      ForEach(
        this.constructionList,
        (item: ConstructionInfo) => {
          ListItem() {
            this.renderConstructionCard(item)
          }
        }
      )
    }
    .margin({ left: '5%', right: '5%', top: 0 })
    .width('90%')
    .height('100%')
  }
}