import { router } from '@kit.ArkUI';
interface AbnormalDutyRecord {
  id: string;
  name: string;
  department: string;
  supervisionResult: string;
  abnormalType: string;
  abnormalDate: string;
  status: 'pending' | 'feedback'| 'confirm' | 'completed';
}

@Entry
@Component
struct AbnormalDutyApproval {
  @State currentTab: number = 0; // 0-待审核, 1-待反馈, 2-待反馈, 3-已完成
  @State searchText: string = '';
  @State text1: string = "月份";
  @State text2: string = "选择部门";
  @State index: number = 2;
  @State space: number = 8;
  @State arrowPosition: ArrowPosition = ArrowPosition.END;
  @State selectAllChecked: boolean = false;
  @State checkedItems: Set<string> = new Set();

  private abnormalRecords: AbnormalDutyRecord[] = [
    {
      id: '1',
      name: '张飞飞',
      department: '内江市交警支队一大队',
      supervisionResult: '异常',
      abnormalType: '脱岗',
      abnormalDate: '2021-4-11',
      status: 'pending'
    },
    {
      id: '2',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      supervisionResult: '异常',
      abnormalType: '脱岗',
      abnormalDate: '2021-4-11',
      status: 'feedback'
    },
    {
      id: '3',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      supervisionResult: '异常',
      abnormalType: '脱岗',
      abnormalDate: '2021-4-11',
      status: 'confirm'
    },
    {
      id: '4',
      name: '张亚飞',
      department: '内江市交警支队一大队',
      supervisionResult: '异常',
      abnormalType: '脱岗',
      abnormalDate: '2021-4-11',
      status: 'completed'
    }
  ];

  build() {
    Column() {
      // 标题栏
      Row(){
        Text('<')
          .fontSize(40)
          .margin({bottom:30})
          .width('10%')
          .onClick(() => {
            router.back();
          })

        Text('异常勤务审批')
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

      //筛选器区域
      Row() {
        // 月份选择
        Row() {
          Select([{ value: '一月' }, { value: '二月' },{ value: '三月' },{ value: '四月' },{ value: '五月' },{ value: '六月' },{ value: '七月' },{ value: '八月' },{ value: '九月' },{ value: '十月' },{ value: '十一月' },{ value: '十二月' }])
            .selected(this.index)
            .value(this.text1)
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
                this.text1 = text;
              }
            })
        }

        // 部门选择
        Row() {
          Select([{ value: '内江市交警支队一大队' }, { value: '内江市交警支队二大队' },{ value: '内江市交警支队三大队' },{ value: '内江市交警支队四大队' }])
            .selected(this.index)
            .value(this.text2)
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
                this.text2 = text;
              }
            })
        }

        Blank()

        // 搜索框
        Row() {
          Text('🔍')
            .fontSize(16)
            .fontColor('#999999')
            .margin({ right: 8 })

          Text('输入人员姓名进行搜索')
            .fontSize(14)
            .fontColor('#CCCCCC')
        }
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .backgroundColor('#FFFFFF')
        .borderRadius(4)
        .width('100%')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor('#F5F5F5')

      // 状态标签
      Row() {
        this.buildTabItem('待审核', 0, 1)
        this.buildTabItem('待反馈', 1, 2)
        this.buildTabItem('待反馈', 2, 0)
        this.buildTabItem('已完成', 3, 0)
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.SpaceAround)

      //记录列表
      List() {
        ForEach(this.getFilteredRecords(), (record: AbnormalDutyRecord) => {
          ListItem() {
            this.buildRecordCard(record)
          }
          .margin({ bottom: 12 })
        })

        // 全选和批量审核
        if (this.currentTab === 0) {
          ListItem() {
            Row() {
              Row() {
                Checkbox({ name: 'selectAll', group: 'checkboxGroup' })
                  .select(this.selectAllChecked)
                  .onChange((value: boolean) => {
                    this.selectAllChecked = value;
                  })

                Text('全选')
                  .fontSize(16)
                  .margin({ left: 8 })

                Text(`共${this.getFilteredRecords().length}条异常勤务记录`)
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ left: 16 })
              }

              Blank()

              Button('审核')
                .fontSize(14)
                .fontColor('#FFFFFF')
                .backgroundColor('#007AFF')
                .borderRadius(4)
                .padding({ left: 16, right: 16, top: 6, bottom: 6 })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ShenPiGuanLi/abnormalServiceApproval'
                  });
                })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
          }
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')

  }

  @Builder
  buildTabItem(title: string, tabIndex: number, badgeCount: number) {
    Column() {
      Stack() {
        Text(title)
          .fontSize(16)
          .fontColor(this.currentTab === tabIndex ? '#007AFF' : '#999999')
          .fontWeight(this.currentTab === tabIndex ? FontWeight.Medium : FontWeight.Normal)

        if (badgeCount > 0) {
          Text(badgeCount.toString())
            .fontSize(12)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF3B30')
            .borderRadius(8)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .position({ x: 20, y: -8 })
        }
      }
    }
    .onClick(() => {
      this.currentTab = tabIndex;
    })
  }

  @Builder
  buildRecordCard(record: AbnormalDutyRecord) {
    Column() {
      Row() {
        if (this.currentTab === 0) {
          Checkbox({ name: record.id, group: 'checkboxGroup' })
            .select(this.checkedItems.has(record.id))
            .onChange((value: boolean) => {
              if (value) {
                this.checkedItems.add(record.id);
              } else {
                this.checkedItems.delete(record.id);
              }
            })
            .margin({ right: 12 })
        }

        Column() {
          Row() {
            Text(record.name)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#007AFF')

            Blank()

            if (record.status === 'pending') {
              Button('审核')
                .fontSize(14)
                .fontColor('#FFFFFF')
                .backgroundColor('#007AFF')
                .borderRadius(4)
                .padding({ left: 16, right: 16, top: 6, bottom: 6 })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ShenPiGuanLi/abnormalServiceApproval'
                  });
                })
            } else if (record.status === 'feedback') {
              Button('反馈')
                .fontSize(14)
                .fontColor('#FFFFFF')
                .backgroundColor('#007AFF')
                .borderRadius(4)
                .padding({ left: 16, right: 16, top: 6, bottom: 6 })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ShenPiGuanLi/abnormalServiceFeedBack'
                  });
                })
            } else if (record.status === 'confirm') {
              Button('确认')
                .fontSize(14)
                .fontColor('#FFFFFF')
                .backgroundColor('#007AFF')
                .borderRadius(4)
                .padding({ left: 16, right: 16, top: 6, bottom: 6 })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ShenPiGuanLi/abnormalServiceConfirm'
                  });
                })
            }else {
              Text('>')
                .fontSize(20)
                .fontColor('#CCCCCC')
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ShenPiGuanLi/abnormalServiceDetail'
                  });
                })
            }
          }
          .width('100%')
          .margin({ bottom: 12 })

          Column({ space: 8 }) {
            Row() {
              Text('所属部门：')
                .fontSize(14)
                .fontColor('#333333')
                .width(80)

              Text(record.department)
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Row() {
              Text('监督结果：')
                .fontSize(14)
                .fontColor('#333333')
                .width(80)

              Text(record.supervisionResult)
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Row() {
              Text('异常类型：')
                .fontSize(14)
                .fontColor('#333333')
                .width(80)

              Text(record.abnormalType)
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Row() {
              Text('异常日期：')
                .fontSize(14)
                .fontColor('#333333')
                .width(80)

              Text(record.abnormalDate)
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
        }
        .layoutWeight(1)
      }
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#00000010', offsetY: 1 })
  }

  getFilteredRecords(): AbnormalDutyRecord[] {
    return this.abnormalRecords.filter(record => {
      if (this.currentTab === 0) return record.status === 'pending';
      if (this.currentTab === 1) return record.status === 'feedback';
      if (this.currentTab === 2) return record.status === 'confirm';
      if (this.currentTab === 3) return record.status === 'completed';
      return true;
    });
  }
}