import router from '@ohos.router';

@Entry
@Component
struct PersonalInformation {
  @State message: string = 'Hello World';

  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  build() {
    Column(){
      Row(){
        Button()
          .width(30)
          .height(30)
          .backgroundImage($r('app.media.back'))
          .backgroundImageSize(ImageSize.Cover)
          .backgroundColor('#FFFFFF')
          .onClick(()=>{
            router.back()
          })
        Text('个人信息')
          .fontSize(30)
          .fontColor('#000000')
        Row(){}.width(30)

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Row(){
        Text('头像')
          .fontSize(25)
          .fontColor('##4BE4E4')
          .padding(20)
        Image($r('app.media.ffb4540e96c3365822f0a692d9fe199a'))
          .width(60)
          .height(60)
          .backgroundColor('#F0F0F0')
          .borderRadius(50)
          .margin({right:10})
      }
      .margin({top:30,bottom:20})
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Row(){
        Text('修改手机号')
          .fontSize(25)
          .fontColor('##4BE4E4')
          .padding(20)
        Image($r('app.media.go'))
          .width(30)
          .height(30)
          .padding({right:10})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Row(){
        Text('修改密码')
          .fontSize(25)
          .fontColor('##4BE4E4')
          .padding(20)
        Image($r('app.media.go'))
          .width(30)
          .height(30)
          .padding({right:10})
      }
      .width('100%')
      .margin({top:20})
      .justifyContent(FlexAlign.SpaceBetween)
      Row(){
        Button('退出登录')
          .type(ButtonType.Normal)
          .fontSize('25')
          .fontColor('#000000')
          .borderWidth(1)
          .borderColor('#999999')
          .width('90%')
          .height(50)
          .backgroundColor('#ffffff')
          .onClick(()=>{
              router.pushUrl({url:'pages/GuideAndLogin/Login'})
          })
      }
      .margin({top:400})
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight)})

  }
}