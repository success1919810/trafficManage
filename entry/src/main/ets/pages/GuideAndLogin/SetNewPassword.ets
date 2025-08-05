import router from '@ohos.router';
import { promptAction } from '@kit.ArkUI';
import { postJsonLogin } from '../../utils/HttpLoginService';

interface setNewRequest {
  phone: string;
  password: string;
}

interface setNewResult {
  code: number;
  msg: string;
  data?: object;
}

@Entry
@Component
struct setNewPassword {
  @State phoneNumber: string = '';
  @State newPassword: string = '';
  @State confirmPassword: string = '';
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params.phone) {
      this.phoneNumber = params.phone as string;
    }
  }

  // 密码强度验证
  private isValidPassword(password: string): boolean {
    // 至少6位，包含字母和数字
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$/;
    return passwordRegex.test(password);
  }

  async setNewPassword(): Promise<void> {
    if (!this.newPassword.trim()) {
      promptAction.showToast({ message: '请输入新的密码' });
      return;
    }

    if (!this.isValidPassword(this.newPassword)) {
      promptAction.showToast({ message: '密码至少6位，需包含字母和数字' });
      return;
    }

    if (!this.confirmPassword.trim()) {
      promptAction.showToast({ message: '请再次确认新的密码' });
      return;
    }

    if (this.confirmPassword !== this.newPassword) {
      promptAction.showToast({ message: '两次输入的密码不一致' });
      return;
    }

    if (!this.phoneNumber) {
      promptAction.showToast({ message: '手机号信息丢失，请重新操作' });
      router.back();
      return;
    }

    try {
      const setNewRequest: setNewRequest = {
        phone: this.phoneNumber,
        password: this.confirmPassword
      };

      const result = await postJsonLogin<setNewResult>('http://26.120.165.93:8080/login/setNew', setNewRequest);

      if (result.code === 200) {
        promptAction.showToast({ message: '密码重置成功，请重新登录' });
        // 延迟跳转，让用户看到成功提示
        setTimeout(() => {
          router.replaceUrl({
            url: 'pages/GuideAndLogin/Login'
          });
        }, 1500);
      } else {
        promptAction.showToast({ message: result.msg || '密码重置失败' });
      }
    } catch (error) {
      console.error('重置密码异常:', error);
      promptAction.showToast({ message: '网络请求失败，请检查连接' });
    }
  }

  build() {
    Column({ space: 15 }) {
      // 返回按钮 + 标题
      Row() {
        Text('<')
          .fontSize(26)
          .margin({ bottom: 20 })
          .onClick(() => router.back())
          .width('10%')

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
          .margin({ bottom: 20 })
          .width('10%')
      }

      Row().width("100%").height(1).backgroundColor('#f0f0f0')

      Row() {
        Text('1.验证手机号码')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ right: 20 });
        Text('2.设置新密码')
          .fontSize(14)
          .fontColor('#007AFF');
      }
      .width('60%')
      .margin({ bottom: 5 })
      .justifyContent(FlexAlign.SpaceBetween);

      Column({ space: 15 }) {
        // 显示手机号（只读）
        if (this.phoneNumber) {
          Text(`手机号：${this.phoneNumber}`)
            .fontSize(16)
            .fontColor('#666666')
            .margin({ top: 10 })
            .width('90%')
        }

        // 新密码输入
        TextInput({
          placeholder: '请设置新密码（至少6位，包含字母和数字）'
        })
          .type(InputType.Password)
          .margin({ top: 10 })
          .width('90%')
          .onChange((val) => this.newPassword = val);

        // 确认密码输入
        TextInput({
          placeholder: '请再次输入新密码'
        })
          .type(InputType.Password)
          .width('90%')
          .onChange((val) => this.confirmPassword = val);

        // 确认按钮
        Button('确认')
          .width("90%")
          .backgroundColor('#007AFF')
          .onClick(() => {
            this.setNewPassword();
          });
      }
      .backgroundColor('#f0f0f0')
      .width('100%')
      .height('100%')
    }
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
    .height('100%')
    .width('100%');
  }
}