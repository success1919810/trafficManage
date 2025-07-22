import router from '@ohos.router';


interface Item1{
  name:string
  bumen:string
  date:string
  fenshu:number
  suggestion:string
}
@Entry
@Component
struct JiXiaoFanKui {
  @State message: string = 'Hello World';
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @State datas:Item1[]=[
    {name:'温迪',bumen:'蒙德城骑兵队第一支队',date:'2021-4',fenshu:93,suggestion:'请输入反馈意见'}
  ]
  @State
  private data:string[][]=[
    ['栏目类型','规则','单次扣分','考核数据','绩效扣分'],
    ['标准','迟到','2','3次','6分'],
    ['标准','早退','1','0次','0分'],
    ['标准','里程未达标','1次','7km','1'],
    ['标准','越界','1','0次','0'],
    ['自定义','帮助儿童','2','无','0']
  ]
  @Builder
  myItemUI(data:string[][]){
    Column() {
      // 主横向滚动容器
      Scroll() {
        Column() {
          // 遍历二维数组的每一行
          ForEach(this.data, (row: string[], rowIndex: number) => {
            // 每行使用Row组件实现横向排列
            Row() {
              // 遍历当前行的每个元素
              ForEach(row, (item: string, colIndex: number) => {
                Text(item)
                  .fontSize(20)
                  .width(100)
                  .height(30)
                  .margin(5)
              }, (item: string) => item)
            }
            .margin({ bottom: 10 }) // 行间距

            .justifyContent(FlexAlign.SpaceBetween)
          }, (row: string[]) => row.toString())
        }
      }
      .scrollable(ScrollDirection.Horizontal) // 设置横向滚动
      .width('60%')
      .height(300)
    }

  }

  build() {
    Column({space:10}){
      Row() {
        Button()
          .width(30)
          .height(40)
          .backgroundImage($r('app.media.back'))
          .backgroundImageSize(ImageSize.Cover)
          .backgroundColor('#F2F2F2')
          .margin({ right: 100 })
          .onClick(() => {
            router.back()
          })
        Text('绩效反馈')
          .fontSize(17)
          .fontColor('#83000000')
          .padding(10)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#F2F2F2')
      Row() {
        Text('被考人员:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].name)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('考核部门:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].bumen)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('考核周期:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].date)
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Row() {
        Text('绩效分数:')
          .fontSize(20)
          .fontColor('#000000')
        Text(this.datas[0].fenshu+"")
          .fontSize(20)
          .fontColor('#999999')
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Text('明细')
        .fontSize(20)
        .fontColor('#000000')
      Row() {
        Column({space:26}){
          Text('考核栏目')
            .fontSize(20)
            .fontColor('#000000')
          Text('日常考勤')
            .fontSize(20)
            .fontColor('#000000')
          Text('日常考勤')
            .fontSize(20)
            .fontColor('#000000')
          Text('勤务值班')
            .fontSize(20)
            .fontColor('#000000')
          Text('勤务值班')
            .fontSize(20)
            .fontColor('#000000')
          Text('辖区助学')
            .fontSize(20)
            .fontColor('#000000')
        }
        .width('40%')
        .height(300)
        .margin({top:20})
        this.myItemUI(this.data)
      }
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')

      Row() {
        Text('反馈意见:')
          .fontSize(20)
          .fontColor('#000000')
        TextInput({ placeholder: this.datas[0].suggestion })
          .width(200)
          .height(40)
          .fontSize(20)
          .fontColor('#999999')
          .borderRadius(0)

      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
      Row() {
      }
      .width('90%')
      .height(1)
      .backgroundColor('#999999')
      Button('提交')
        .width(100)
        .height(60)
        .fontSize(20)
        .fontColor('#ffffff')
        .backgroundColor('#0000ff')
        .margin({top:40})


    }
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }
}