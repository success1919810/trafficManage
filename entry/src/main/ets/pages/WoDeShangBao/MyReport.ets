import router from '@ohos.router';
import { errorSubmitService } from '../../utils/ErrorSubmitService';
import { getCurrentUser, getToken } from '../../utils/TokenUtils';
import { promptAction } from '@kit.ArkUI';
import http from '@ohos.net.http';

// 后端返回的数据接口
interface MyReportCardVO {
  id:number;
  errorType: string;
  location: string;
  equipmentCode: string;
  equipmentType: string;
  reportTime: string;
}

// 列表显示接口
interface ReportItem {
  id: number;
  text1: string;  // 设备类型 + 设备编码
  text2: string;  // 故障类型
  text3: string;  // 设备位置
  text4: string;  // 上报时间
  month: number;
  originalReportTime: string;
}

// API响应接口
interface ReportApiResponse {
  code: number;
  msg: string;
  data: MyReportCardVO[];
}

// 路由参数接口
interface RouterParams {
  reportData: ReportItem;
}

interface EditRouterParams {
  orderId: number;
  reporterName: string;
}
// Select选项类
class MonthSelectOption {
  value: string;

  constructor(value: string) {
    this.value = value;
  }
}

interface DeleteApiResponse {
  code: number;
  msg: string;
}

// 上报内容组件
@Component
struct ReportListComponent {
  @State allDatas: ReportItem[] = [];
  @State filteredDatas: ReportItem[] = [];
  @State selectedMonth: number = 0;
  @State isLoading: boolean = false;

  aboutToAppear() {
    this.fetchReportData();
  }

  // 从后端获取数据
  async fetchReportData() {
    this.isLoading = true;
    try {
      const context = getContext(this);
      // const token = await getToken(context);
      const currentUser = getCurrentUser();

      if (!currentUser) {
        promptAction.showToast({ message: '请先登录' });
        return;
      }
      // const httpRequest = http.createHttp()
      // const response = await httpRequest.request(`http://26.120.165.93:8080/errorSubmit/getByName?reporterName=${encodeURIComponent(currentUser)}`,{
      //   method:http.RequestMethod.GET,
      //   header:{
      //     "Content-Type":"application/json",
      //     "Authorization":`Bearer ${token}`,
      //     "Accept":"application/json"
      //   }
      // })
      // const result = JSON.parse(response.result as string)as T;
      const result = await errorSubmitService<ReportApiResponse>(
        `http://26.120.165.93:8080/errorSubmit/getByName?reporterName=${encodeURIComponent(currentUser)}`,
        context
      );

      if (result.code === 200) {
        this.allDatas = result.data.map((item: MyReportCardVO, index: number): ReportItem => {
          const reportItem: ReportItem = {
            id: item.id,
            text1: `${item.equipmentType} - ${item.equipmentCode}`,
            text2: `故障类型：${item.errorType}`,
            text3: `设备位置：${item.location}`,
            text4: `上报时间：${item.reportTime}`,
            month: this.extractMonthFromDate(item.reportTime),
            originalReportTime: item.reportTime
          };
          return reportItem;
        });

        this.filteredDatas = this.allDatas;
      } else {
        promptAction.showToast({ message: result.msg || '获取数据失败' });
        this.allDatas = [];
        this.filteredDatas = [];
      }
    } catch (error) {
      console.error('获取上报数据失败:', error);
      promptAction.showToast({ message: '网络请求失败' });
      this.allDatas = [];
      this.filteredDatas = [];
    } finally {
      this.isLoading = false;
    }
  }

  // 删除工单
  async deleteWorkOrder(orderId: number) {
    try {
      const context = getContext(this);
      const token = await getToken(context);
      const httpRequest = http.createHttp();

      const response = await httpRequest.request(`http://26.120.165.93:8080/errorSubmit/deleteOrder/${orderId}`, {
        method: http.RequestMethod.DELETE,
        header: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": `Bearer ${token}`
        }
      });

      const result = JSON.parse(response.result as string) as DeleteApiResponse;
      httpRequest.destroy();

      if (result.code === 200) {
        promptAction.showToast({ message: '删除成功' });
        // 刷新数据
        await this.fetchReportData();
        this.filterByMonth(this.selectedMonth);
      } else {
        promptAction.showToast({ message: result.msg || '删除失败' });
      }
    } catch (error) {
      console.error('删除工单失败:', error);
      promptAction.showToast({ message: '删除失败' });
    }
  }

  // 从日期字符串提取月份
  extractMonthFromDate(dateString: string): number {
    if (!dateString) return 1;

    try {
      const date = new Date(dateString);
      return date.getMonth() + 1;
    } catch (error) {
      return 1;
    }
  }

  // 根据月份筛选数据
  filterByMonth(monthIndex: number) {
    this.selectedMonth = monthIndex;
    if (monthIndex === 0) {
      this.filteredDatas = this.allDatas;
    } else {
      this.filteredDatas = this.allDatas.filter((item: ReportItem): boolean => {
        return item.month === monthIndex;
      });
    }
  }

  // 刷新数据
  async refreshData() {
    await this.fetchReportData();
    this.filterByMonth(this.selectedMonth);
  }

  // 列表项 UI 构建器
  @Builder
  myItemUI(item: ReportItem) {
    Column({ space: 10 }) {
      Row() {
        Text(item.text1)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0099ff')
          .layoutWeight(1);

        Text('修改')
          .fontSize(14)
          .fontColor('#0099ff')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .border({ width: 1, color: '#0099ff', radius: 4 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/WoDeShangBao/EditWorkOrder',
              params: {
                orderId: item.id,
                reporterName: getCurrentUser()
              } as EditRouterParams
            });
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween);

      Text(item.text2)
        .width('100%')
        .fontColor('#666666')
        .fontSize(14);

      Text(item.text3)
        .width('100%')
        .fontColor('#666666')
        .fontSize(14);

      Text(item.text4)
        .width('100%')
        .fontColor('#666666')
        .fontSize(14);
    }
    .width('95%')
    .backgroundColor('#ffffff')
    .margin({ top: 15, left: 5, right: 5 })
    .padding(20)
    .borderRadius(15)
    .gesture(
      LongPressGesture({ repeat: false })
        .onAction(() => {
          // 长按显示删除确认对话框
          AlertDialog.show({
            title: '删除确认',
            message: `确定要删除这条上报记录吗？\n${item.text1}`,
            primaryButton: {
              value: '取消',
              action: () => {}
            },
            secondaryButton: {
              value: '删除',
              fontColor: '#ff4444',
              action: () => {
                this.deleteWorkOrder(item.id);
              }
            }
          });
        })
    );
  }

  build() {
    Column() {
      // 月份筛选器和刷新按钮
      Row() {
        Select([
          new MonthSelectOption('全部月份'),
          new MonthSelectOption('一月'), new MonthSelectOption('二月'), new MonthSelectOption('三月'), new MonthSelectOption('四月'),
          new MonthSelectOption('五月'), new MonthSelectOption('六月'), new MonthSelectOption('七月'), new MonthSelectOption('八月'),
          new MonthSelectOption('九月'), new MonthSelectOption('十月'), new MonthSelectOption('十一月'), new MonthSelectOption('十二月')
        ])
          .selected(this.selectedMonth)
          .value(this.selectedMonth === 0 ? '全部月份' :
          ['', '一月', '二月', '三月', '四月', '五月', '六月',
            '七月', '八月', '九月', '十月', '十一月', '十二月'][this.selectedMonth])
          .onSelect((index: number, text: string | undefined) => {
            this.filterByMonth(index);
          })

        Text('刷新')
          .fontSize(14)
          .fontColor('#0099ff')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .border({ width: 1, color: '#0099ff', radius: 4 })
          .onClick(() => {
            this.refreshData();
          })
      }
      .width('100%')
      .padding({ left: 10, right: 10, bottom: 10 })
      .justifyContent(FlexAlign.SpaceBetween);

      if (this.isLoading) {
        Row() {
          LoadingProgress()
            .width(30)
            .height(30)
            .margin({ right: 10 });
          Text('加载中...')
            .fontColor('#666666');
        }
        .width('100%')
        .height(100)
        .justifyContent(FlexAlign.Center);
      } else if (this.filteredDatas.length === 0) {
        Column() {
          Text('暂无数据')
            .fontSize(16)
            .fontColor('#999999')
            .margin({ bottom: 10 });
          Text('点击刷新重新加载')
            .fontSize(14)
            .fontColor('#cccccc');
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center);
      } else {
        List() {
          ForEach(this.filteredDatas, (item1: ReportItem) => {
            ListItem() {
              this.myItemUI(item1)
            }
          });
        }
        .width('100%')
        .padding({ bottom: 20 })
        .backgroundColor('#f2f2f2')
        .layoutWeight(1);
      }
    }
    .width('100%')
    .height('100%');
  }
}

@Entry
@Component
struct MyReportPage {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Column() {
      Row() {
        Text('<')
          .fontSize(40)
          .width(50)
          .height(50)
          .textAlign(TextAlign.Center)
          .onClick(() => router.back());

        Text('我的上报')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .layoutWeight(1);

        Text('+')
          .fontSize(30)
          .fontColor('#0099ff')
          .width(50)
          .height(50)
          .textAlign(TextAlign.Center)
          .backgroundColor('#f0f8ff')
          .borderRadius(25)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/WoDeShangBao/AddWorkOrder'
            });
          })
      }
      .width('100%')
      .height(60)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#ffffff')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween);

      ReportListComponent()
        .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f2f2f2')
    .padding({
      top: px2vp(this.topRectHeight),
      bottom: px2vp(this.bottomRectHeight)
    });
  }
}