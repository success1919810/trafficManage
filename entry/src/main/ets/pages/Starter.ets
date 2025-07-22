import router from '@ohos.router'; // 引入路由模块
@Entry
@Component
struct Starter {
  @State message: string = 'Hello World';

  @State account: string = '';
  // 密码输入框绑定变量（密码类型会自动隐藏输入内容）
  @State password: string = '';
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  build() {
    Column() {
      // 轮播图
      Swiper() {
        Image($r('app.media.DB6B40FD13B662CE83F18E3AE9D0F6ED'))
          .width('95%')
          .height('30%')

      }.margin({ bottom: 30 })

      TextInput({ placeholder: '请输入账号' })
        .type(InputType.Normal) // 普通文本输入
        .margin({ bottom: 15 })
        .height('50')
        .onChange((value: string) => {
          this.account = value;
        });

      // 密码输入框（自动隐藏输入内容）
      TextInput({ placeholder: '请输入密码' })
        .type(InputType.Password) // 密码类型
        .margin({ bottom: 20 })
        .height('50')
        .onChange((value: string) => {
          this.password = value;
        });

      // 登录按钮（放在上方）
      Text('登录')
        .fontColor('#ffffff')
        .fontSize(18) // 增加字体大小
        .padding(10)
        .backgroundColor('#00FFFF')
        .borderRadius(10)
        .margin({ top: 50 })
        .width('90%')
        .textAlign(TextAlign.Center) // 文字居中
        .onClick(() => {
          router.replaceUrl({ url: 'pages/Index' }); // 清除当前页面
        })
        .height(50) // 设置固定高度，使按钮更饱满
        .shadow({ radius: 2, color: '#007DFF' })


      // 忘记密码（放在下方）
      Text('忘记密码')
        .fontColor('#666666') // 建议添加颜色，更清晰
        .margin({ top: 15 }) // 与登录按钮保持间距
        .width('90%')
        .onClick(()=>{
          //跳转页面
          router.replaceUrl({url:'pages/forgrtPassword'})//清除当前页面
        })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5') // 添加背景色，区分元素
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight)})
  }
}
