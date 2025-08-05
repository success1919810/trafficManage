import { router } from '@kit.ArkUI';
import http from '@ohos.net.http';
import promptAction from '@ohos.promptAction';
import { BusinessError } from '@ohos.base';

// 后端登录接口地址
const REGISTER_API_URL = '26.120.165.93:8080/login/register';
// 定义登录响应数据的类型接口
// interface UserInfo {
//   id: number;
//   username: string;
//
// }
//
// interface LoginResponseData {
//   token: string;
//   userInfo: UserInfo;
// }

interface LoginResponse {
  code: number;
  msg: string;
  data: object;
}
@Entry
@Component
struct Register {
  @State message: string = 'Hello World';
  @State username: string = '';
  @State password: string = '';
  @State phone:string='';
  @State isLoading: boolean = false; // 登录状态加载指示器
  private isValidPhone(phone: string): boolean {
    const phoneRegex = /^1[3-9]\d{9}$/;
    return phoneRegex.test(phone);
  }
  private isValidPassword(password: string): boolean {
    // 至少6位，包含字母和数字
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$/;
    return passwordRegex.test(password);
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

          TextInput({ placeholder: '请输入账号' })
            .type(InputType.Normal)
            .margin({ bottom: 15 })
            .height('50')
            .width('90%')
            .onChange((value: string) => {
              this.username = value;
            });

          TextInput({ placeholder: '请输入手机号' })
            .type(InputType.Normal)
            .margin({ bottom: 15 })
            .height('50')
            .width('90%')
            .onChange((value: string) => {
              this.phone = value;
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
          Button(this.isLoading ? '注册中...' : '注册')
            .width('90%')
            .height(50)
            .backgroundColor(this.isLoading ? '#999999' : '#0079FE')
            .borderRadius(10)
            .margin({ top: 50 })
            .enabled(!this.isLoading)
            .onClick(() => {
              this.handleRegister();
            })
            .shadow({ radius: 20, color: '#666666', offsetX: 15, offsetY: 15 })
        }
        .width('100%')
        .height('100%')
  }

  // 创建第三方登录按钮
  @Builder
  createSocialButton(icon: Resource, bgColor: string) {
    Button() {
      Image(icon)
        .width(24)
        .height(24)
        .fillColor('#FFFFFF')
    }
    .width(56)
    .height(56)
    .backgroundColor(bgColor)
    .borderRadius(28)
    .shadow({ radius: 8, color: bgColor + '40', offsetX: 0, offsetY: 4 })
    .onClick(() => {
      promptAction.showToast({ message: '第三方登录功能开发中' });
    })
  }

  // 处理登录逻辑
  private async handleRegister() {
    // 简单验证
    if (!this.username.trim()) {
      promptAction.showToast({ message: '请输入用户名' });
      return;
    }
    if (!this.phone.trim()) {
      promptAction.showToast({ message: '请输入手机号' });
      return;
    }
    if (!this.isValidPhone(this.phone)) {
      promptAction.showToast({ message: '请按照手机号正确格式输入' });
      return;
    }
    if (!this.password.trim()) {
      promptAction.showToast({ message: '请输入密码' });
      return;
    }
    if (!this.isValidPassword(this.password)) {
      promptAction.showToast({ message: '密码至少6位，需包含字母和数字' });
      return;
    }

    this.isLoading = true;
    try {
      // 创建HTTP请求
      let request = http.createHttp();

      // 发送POST请求
      let response = await request.request(
        REGISTER_API_URL,
        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json'
          },
          extraData: {
            phone:this.phone.trim(),
            username: this.username.trim(),
            password: this.password.trim()
          },
          connectTimeout: 60000,
          readTimeout: 60000
        }
      );

      // 处理响应结果
      if (response.responseCode === 200) {
        // 解析响应数据
        const result = JSON.parse(response.result.toString()) as LoginResponse;

        if (result.code === 200) {
          // 注册成功
          promptAction.showToast({ message: '注册成功' });
          // 跳转到首页
          router.pushUrl({ url: 'pages/GuideAndLogin/Login' });
        } else {
          // 后端返回错误信息
          promptAction.showToast({ message: result.msg || '注册失败' });
        }
      } else {
        // HTTP请求失败
        promptAction.showToast({ message: `请求失败，状态码: ${response.responseCode}` });
      }
    } catch (error) {
      // 捕获异常
      console.error('注册请求异常:', error);
      const err = error as BusinessError;
      promptAction.showToast({
        message: `注册失败: ${err.message || '网络错误'}`
      });
    } finally {
      // 无论成功失败，都结束加载状态
      this.isLoading = false;
    }
  }
}