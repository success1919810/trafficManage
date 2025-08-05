import router from '@ohos.router';
import { promptAction } from '@kit.ArkUI';
import { postJsonLogin } from '../../utils/HttpLoginService';

interface ForgetRequest {
  phone: string;
}

interface ForgetResult {
  code: number;
  msg: string;
  data?: object;
}

@Entry
@Component
struct forgetPassword {
  // 手机号码输入框绑定的变量
  @State phoneNumber: string = '';
  // 验证码输入框绑定的变量
  @State verifyCode: string = '';
  // 控制"发送验证码"按钮是否可点击
  @State canSendCode: boolean = true;
  // 倒计时秒数
  @State countDownSeconds: number = 60;
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  // 手机号格式验证方法
  private isValidPhoneNumber(phone: string): boolean {
    const phoneRegex = /^1[3-9]\d{9}$/;
    return phoneRegex.test(phone);
  }

  // 模拟发送验证码（先验证手机号是否存在）
  async sendVerificationCode(): Promise<void> {
    if (!this.phoneNumber.trim()) {
      promptAction.showToast({ message: '请先输入手机号码' });
      return;
    }

    if (!this.isValidPhoneNumber(this.phoneNumber)) {
      promptAction.showToast({ message: '请输入正确的手机号码' });
      return;
    }

    try {
      // 先验证手机号是否存在
      const forgetRequest: ForgetRequest = {
        phone: this.phoneNumber
      };

      const result = await postJsonLogin<ForgetResult>('http://26.120.165.93:8080/login/forget', forgetRequest);

      if (result.code === 200) {
        // 手机号存在，模拟发送验证码
        promptAction.showToast({ message: '验证码已发送（模拟发送，请输入123456）' });
        this.startCountDown();
      } else {
        promptAction.showToast({ message: result.msg || '该手机号未注册' });
      }
    } catch (error) {
      console.error('验证手机号异常:', error);
      promptAction.showToast({ message: '网络请求失败，请检查连接' });
    }
  }

  // 验证手机号和验证码
  async forgetPassword(): Promise<void> {
    if (!this.phoneNumber.trim()) {
      promptAction.showToast({ message: '请输入手机号' });
      return;
    }

    if (!this.isValidPhoneNumber(this.phoneNumber)) {
      promptAction.showToast({ message: '请输入正确的手机号格式' });
      return;
    }

    if (!this.verifyCode.trim()) {
      promptAction.showToast({ message: "请输入验证码" });
      return;
    }

    // 模拟验证码验证（固定为123456）
    if (this.verifyCode !== '123456') {
      promptAction.showToast({ message: '验证码错误，请输入123456' });
      return;
    }

    try {
      // 再次验证手机号是否存在
      const forgetRequest: ForgetRequest = {
        phone: this.phoneNumber
      };

      const result = await postJsonLogin<ForgetResult>('http://26.120.165.93:8080/login/forget', forgetRequest);

      if (result.code === 200) {
        promptAction.showToast({ message: '验证成功' });
        router.pushUrl({
          url: 'pages/GuideAndLogin/SetNewPassword',
          params: { phone: this.phoneNumber }
        });
      } else {
        promptAction.showToast({ message: result.msg || '验证失败' });
      }
    } catch (error) {
      console.error('验证异常:', error);
      promptAction.showToast({ message: '网络请求失败，请检查连接' });
    }
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

  build() {
    Column() {
      Row() {
        Text('<')
          .fontSize(26)
          .margin({ bottom: 20 })
          .width('10%')
          .onClick(() => router.back())

        Text('找回密码')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 20 })
          .textAlign(TextAlign.Center)
          .width('80%');

        Text('<')
          .fontSize(26)
          .fontColor('#ffffff')
          .margin({ bottom: 20 })
          .width('10%')
      }

      Row().width("100%").height(1).backgroundColor('#f0f0f0')

      Row() {
        Text('1.验证手机号码')
          .fontSize(14)
          .fontColor('#007AFF')
          .margin({ right: 20 });
        Text('2.设置新密码')
          .fontSize(14)
          .fontColor('#999999');
      }
      .margin({ bottom: 15, top: 20 })
      .width('60%')
      .justifyContent(FlexAlign.SpaceBetween);

      Column() {
        TextInput({ placeholder: '请输入手机号码' })
          .type(InputType.PhoneNumber)
          .margin({ bottom: 10, top: 15 })
          .onChange((value: string) => {
            this.phoneNumber = value;
          })
          .width('90%');

        Row() {
          TextInput({ placeholder: '请输入短信验证码（输入123456）' })
            .type(InputType.Number)
            .flexGrow(1)
            .margin({ right: 10 })
            .width('70%')
            .onChange((value: string) => {
              this.verifyCode = value;
            });

          Button(this.canSendCode ? '发送验证码' : `${this.countDownSeconds}s`)
            .fontSize(14)
            .width('30%')
            .backgroundColor(this.canSendCode ? '#007AFF' : '#999999')
            .enabled(this.canSendCode)
            .onClick(() => {
              this.sendVerificationCode();
            });
        }
        .width('90%')
        .margin({ bottom: 20 });

        Button('下一步')
          .width('90%')
          .backgroundColor('#007AFF')
          .onClick(() => {
            this.forgetPassword();
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
}