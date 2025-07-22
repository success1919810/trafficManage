import router from '@ohos.router';

@Entry
@Component
struct Version {
  @State message: string = 'Hello World';
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  build() {
    Column(){
        Button()
          .width(30)
          .height(30)
          .backgroundImage($r('app.media.back'))
          .backgroundImageSize(ImageSize.Cover)
          .backgroundColor('#FFFFFF')
          .margin({right:338})
          .onClick(()=>{
            router.back()
          })
      Image($r('app.media.12123'))
        .width('85%')
        .height(200)
        .margin({top:55,left:8})
      Text('当前版本V1.0')
        .fontSize(30)
        .fontColor('#000000')
        .margin(15)
      Text('已是最新版本')
        .fontSize(20)
        .fontColor('#999999')
    }
    .width('100%')
    .height('100%')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight)})
  }
}