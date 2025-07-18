
import router from '@ohos.router'; // 引入路由模块
@Entry
@Component
struct Starter {
  @State message: string = 'Hello World';

  @State account: string = '';
  // 密码输入框绑定变量（密码类型会自动隐藏输入内容）
  @State password: string = '';

  build() {
    Column() {


      Swiper() {
        Image($r('app.media.oneforall'))
          .width('90%')
          .height('22%')
          .borderRadius(10)
          .margin({top:30})

      }.margin({ top:10,bottom: 30 })

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
        .backgroundColor('#0079FE')
        .borderRadius(10)
        .margin({ top: 50 })
        .width('90%')
        .textAlign(TextAlign.Center) // 文字居中
        .onClick(() => {
         router.replaceUrl({ url: 'pages/Index' }); // 清除当前页面
        })
        .height(50) // 设置固定高度，使按钮更饱满
        .shadow({ radius: 20, color: '#666666' ,offsetX: 15, offsetY: 15 })


      // 忘记密码（放在下方）
      Text('忘记密码')
        .fontColor('#0079FE') // 建议添加颜色，更清晰
        .margin({ top: 25 }) // 与登录按钮保持间距
        .width('90%')
        .onClick(()=>{
          //跳转页面
          router.pushUrl({url:'pages/forgetPassword'})//清除当前页面
        })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5') // 添加背景色，区分元素
  }
}


//router.pushUrl({url:'pages/Index'})//保留当前页面
//router.replaceUrl({url:'pages/Index'})//清除当前页面