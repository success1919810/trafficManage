import router from '@ohos.router';

@Entry
@Component
struct SaoMa {
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
      Image($r('app.media.erweima'))
        .width(250)
        .height(250)
        .margin({top:180})
      Text('扫描下载警务APP')
        .fontSize(20)
        .fontColor('#000000')
    }
    .width('100%')
    .height('100%')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight)})
  }
}