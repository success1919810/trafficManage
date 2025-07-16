@Component
@Entry
export struct map{
    build() {
      Column(){
        Stack() {
          // 底层：地图（占满容器）
          Image($r('app.media.map'))
            .height('100%')
            .width('100%');

          Search({placeholder: '输入设备名称搜索'})
            .height(40)
            .width(360)
            // 添加上边距和水平边距，使其浮在顶部
            .position({ top: 20 ,left:5})

          // 图层选择按钮
          Column({space:13}){
            Column({space:3}){
              Button() {
                Image($r('app.media.tu')) // 图层图标
                  .width(30)
                  .height(30)
              }
              Text('图层')
            }
            .width(40)
            .height(40)


            // 上报按钮
            Column({space:2}){
              Button() {
                Image($r('app.media.warning')) // 上报图标
                  .width(30)
                  .height(30)
                  .backgroundColor('#FFFFFF80')
              }
              Text('上报')
            }
            .width(40)
            .height(40)
          }
          .width(40)
          .height(110)
          .position({ top: 80, right: 10 })
          .borderWidth(1)
        }
        .height('100%') // 让Stack占满父容器高度
        .width('100%')
        .backgroundColor('#0000000')// 让Stack占满父容器宽度
      }
    }
}