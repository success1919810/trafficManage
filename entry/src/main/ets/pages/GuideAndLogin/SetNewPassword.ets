import router from '@ohos.router';
import { prompt } from '@kit.ArkUI';

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
    const params = router.getParams();
    // if (params.phone) {
    //   this.phoneNumber = params.phone;
    // }
  }

  build() {
    Column({space:15}) {
      // 返回按钮 + 标题
      Row(){
        Text('<')
          .fontSize(26)
          .margin({bottom:20})
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
          .margin({bottom:20})
          .width('10%')
        // Row().width(26).height(26)
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

      Column({space:15}){
        // 新密码输入
        TextInput({
          placeholder: '请设置新密码',
          // type: InputType.Password
        })
          .margin({top:10})
          .width('90%')
          .onChange((val) => this.newPassword = val);

        // 确认密码输入
        TextInput({
          placeholder: '请再次输入新密码',
          // type: InputType.Password
        })
          .width('90%')
          .onChange((val) => this.confirmPassword = val);



        // 确认按钮
        Button('确认')
          .width("90%")
          .onClick(() => {
            if (this.newPassword === this.confirmPassword) {
              console.log(`重置密码成功: ${this.phoneNumber}`);
              // 跳转到登录页或返回上一页
              router.pushUrl({ url: 'pages/start' }); // 假设登录页路径
            } else {
              prompt.showToast({ message: '两次输入的密码不一致' });
            }
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