import router from '@ohos.router';
import { promptAction } from '@kit.ArkUI';
import { postJsonLogin } from '../../utils/HttpLoginService';

// 定义接口类型
interface LoginRequest {
  account: string;
  password: string;
}

interface LoginResult {
  code: number;
  msg: string;
  data?: object;
}

@Entry
@Component
struct Starter {
  @State message: string = 'Hello World';
  @State account: string = '';
  @State password: string = '';
  @State isLoading: boolean = false;

  // 登录请求方法
  async login(): Promise<void> {
    // 验证输入
    if (!this.account.trim()) {
      promptAction.showToast({ message: '请输入账号' });
      return;
    }
    if (!this.password.trim()) {
      promptAction.showToast({ message: '请输入密码' });
      return;
    }

    this.isLoading = true;

    try {
      const requestData: LoginRequest = {
        account: this.account,
        password: this.password
      };

      const result = await postJsonLogin<LoginResult>('http://26.195.0.245:8080/login', requestData);

      if (result.code === 200) {
        promptAction.showToast({ message: '登录成功' });
        router.replaceUrl({ url: 'pages/Index' });
      } else {
        promptAction.showToast({ message: result.msg || '登录失败' });
      }
    } catch (e) {
      promptAction.showToast({ message: '网络请求失败，请检查连接' });
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    Column() {
      Swiper() {
        Image($r('app.media.oneforall'))
          .width('90%')
          .height('22%')
          .borderRadius(10)
          .margin({top:30})
      }.margin({ top:10,bottom: 30 })

      TextInput({ placeholder: '请输入账号或手机号' })
        .type(InputType.Normal)
        .margin({ bottom: 15 })
        .height('50')
        .width('90%')
        .onChange((value: string) => {
          this.account = value;
        });

      TextInput({ placeholder: '请输入密码' })
        .type(InputType.Password)
        .margin({ bottom: 20 })
        .height('50')
        .width('90%')
        .onChange((value: string) => {
          this.password = value;
        });

      // 登录按钮
      Button() {
        if (this.isLoading) {
          Row({ space: 10 }) {
            LoadingProgress()
              .width(20)
              .height(20)
              .color('#ffffff')
            Text('登录中...')
              .fontColor('#ffffff')
              .fontSize(18)
          }
        } else {
          Text('登录')
            .fontColor('#ffffff')
            .fontSize(18)
        }
      }
      .width('90%')
      .height(50)
      .backgroundColor(this.isLoading ? '#999999' : '#0079FE')
      .borderRadius(10)
      .margin({ top: 50 })
      .enabled(!this.isLoading)
      .onClick(() => {
        this.login();
      })
      .shadow({ radius: 20, color: '#666666', offsetX: 15, offsetY: 15 })

      Text('忘记密码')
        .fontColor('#0079FE')
        .margin({ top: 25 })
        .width('90%')
        .onClick(() => {
          router.pushUrl({url:'pages/GuideAndLogin/ForgetPassword'});
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}