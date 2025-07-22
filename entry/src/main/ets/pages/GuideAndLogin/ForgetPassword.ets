import router from '@ohos.router';
import { prompt } from '@kit.ArkUI'; // 如果需要使用prompt

@Entry
@Component
struct forgetPassword {
  // 手机号码输入框绑定的变量
  @State phoneNumber: string = '';
  // 验证码输入框绑定的变量
  @State verifyCode: string = '';
  // 控制“发送验证码”按钮是否可点击（简单做个60秒倒计时逻辑演示，实际可优化）
  @State canSendCode: boolean = true;
  // 倒计时秒数
  @State countDownSeconds: number = 60;
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Column() {
        Row(){
          Text('<')
            .fontSize(26)
            .margin({bottom:20})
            .width('10%')
            .onClick(() => router.back())

          // 标题
          Text('找回密码')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 20 })
              .textAlign(TextAlign.Center)
              .width('80%');
              Text('<')
                .fontSize(26)
                .fontColor('#ffffff')
                .margin({bottom:20})
                .width('10%')
          // Row().width(26).height(26)
        }
        Row().width("100%").height(1).backgroundColor('#f0f0f0')
      // 步骤导航（简单文字示意，实际可做更精致的进度条或分段UI）
      Row() {
        Text('1.验证手机号码')
          .fontSize(14)
          .fontColor('#007AFF')
          .margin({ right: 20 });
        Text('2.设置新密码')
          .fontSize(14)
          .fontColor('#999999');
      }
      .margin({ bottom: 15,top:20 })
      .width('60%')
      .justifyContent(FlexAlign.SpaceBetween);
      Column(){

        TextInput({ placeholder: '请输入手机号码' })
          .type(InputType.PhoneNumber)
          .margin({ bottom: 10,top:15 })
          .onChange((value: string) => {
            this.phoneNumber = value;
          }).width('90%');

        // 验证码输入 + 发送按钮 行布局
        Row() {
          TextInput({ placeholder: '请输入短信验证码' })
            .type(InputType.Number)
            .flexGrow(1)
            .margin({ right: 10 })
            .width('70%')
            .onChange((value: string) => {
              this.verifyCode = value;
            });

          Button('发送验证码')
            .fontSize(14)
            .width('30%')
            .backgroundColor(this.canSendCode ? '#007AFF' : '#999999')
            .onClick(() => {
              if (this.canSendCode && this.phoneNumber.length === 11) {
                // 这里可调用实际的短信验证码发送接口，比如调用后端接口
                console.log(`向手机号码 ${this.phoneNumber} 发送验证码`);
                this.startCountDown();
              }
            });
        }
        .width('90%')
        .margin({ bottom: 20 });

        // 下一步按钮
        Button('下一步')
          .width('90%')
          .backgroundColor('#007AFF')
          .onClick(() => {
            if (this.phoneNumber && this.verifyCode) {
              router.pushUrl({
                url: 'pages/GuideAndLogin/SetNewPassword',
                params: { phone: this.phoneNumber }
              });
            } else {
              prompt.showToast({ message: '请填写完整信息' });
            }
          });

      }
      .height('100%')
      .width('100%')
      .backgroundColor('#f0f0f0')
    }
    .width('100%')
    .height('100%')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
    .justifyContent(FlexAlign.Start);
  }

  // 倒计时方法
  startCountDown() {
    this.canSendCode = false;
    let timer = setInterval(() => {
      this.countDownSeconds--;
      if (this.countDownSeconds <= 0) {
        clearInterval(timer);
        this.canSendCode = true;
        this.countDownSeconds = 60;
      }
    }, 1000);
  }
}