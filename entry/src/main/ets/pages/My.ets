import router from '@ohos.router';
import { url } from '@kit.ArkTS';
import {DialogHelper} from '@pura/harmony-dialog'
import text from '@ohos.graphics.text';
@Component
export struct  My{
 /* @Builder
  myDialog(){
    Column(){
      Text('是否清除缓存')
        .fontColor(30)
        .fontColor('#ffffff')

      Row(){
        Button('否')
          .fontSize(30)
          .width(156)
          .fontColor('#FFFFFF')
          .backgroundColor('#000000')
          .borderColor('#ffffff')
          .borderWidth(2)
          .type(ButtonType.Normal)
        Button('是')
          .fontSize(30)
          .width(156)
          .fontColor('#ffffff')
          .backgroundColor('#000000')
          .type(ButtonType.Normal)
          .borderWidth(2)
          .borderColor('#ffffff')
      }
    }
    .backgroundColor('#000000')

  }*/

  build() {
    Column(){
      //个人中心
      Row(){
        Row().width(40)
        Text('个人中心')
          .fontColor('#FFFFFF')
          .fontSize(40)
        Row().width(40)
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
      .padding(30)
      .backgroundColor("#f000a6ff")
      //头像名字
      Row(){
        Image($r('app.media.ffb4540e96c3365822f0a692d9fe199a'))
          .borderRadius(50)
          .width(100)
          .height(100)
        Column({space:10}){
          Row({space:30}){
            Text('温迪')
              .fontSize(35)
              .fontColor('#FFFFFF')
            Text('中队长')
              .fontSize(17)
              .fontColor('#FFFFFF')
          }
          Row(){
            Text('蒙德市交通警察支队   |指挥中心')
              .fontSize(17)
              .fontColor('#FFFFFF')
          }
        }
      }
      .backgroundColor("#f000a6ff")
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      //请假管理
        Row(){
          Column({space:3}){
            Image($r('app.media.qingjia'))
              .width(65)
              .height(65)
              .onClick(()=>{
                router.pushUrl({url:'pages/QingJia/QingJia'})
              })
            Button('请假管理')
              .fontSize(16)
              .fontColor('#000000')
              .backgroundColor('#FAFAFA')
              .onClick(()=>{
                router.pushUrl({url:'pages/QingJia/QingJia'})
              })
          }
          Column({space:3}){
            Image($r('app.media.wodejixiao1'))
              .width(65)
              .height(65)
              .onClick(()=>{
                router.pushUrl({url:'pages/JiXiao/JiXiao'})
              })
            Button('我的绩效')
              .fontSize(16)
              .fontColor('#000000')
              .backgroundColor('#FAFAFA')
              .onClick(()=>{
                router.pushUrl({url:'pages/JiXiao/JiXiao'})
              })
          }
          Column({space:3}){
            Image($r('app.media.yichang'))
              .width(65)
              .height(65)
              .onClick(()=>{
                router.pushUrl({url:'pages/YiChangQingWu/YiChang'})
              })
            Button('异常勤务')
              .fontSize(16)
              .fontColor('#000000')
              .backgroundColor('#FAFAFA')
              .onClick(()=>{
                router.pushUrl({url:'pages/YiChangQingWu/YiChang'})
              })
          }
        }
        .width('100%')
        .backgroundColor('#FAFAFA')
        .justifyContent(FlexAlign.SpaceAround)
        .margin(10)
      //值班记录
      Row(){
        Column({space:5}){
          Text('值班记录')
            .fontSize(20)
            .fontStyle(10)
            .fontColor('#999999')
          Text('22')
            .fontStyle(500)
            .fontSize(40)
        }
        Column({space:5}){
          Text('警情处理')
            .fontSize(20)
            .fontStyle(10)
            .fontColor('#999999')
          Text('8')
            .fontStyle(500)
            .fontSize(40)
        }
        Column({space:5}){
            Text('请假调休')
            .fontSize(20)
            .fontStyle(10)
            .fontColor('#999999')
          Text('1')
            .fontStyle(500)
            .fontSize(40)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .margin(10)
      Row(){}
      .width('100%')
      .height(25)
      .backgroundColor('#FAFAFA')
      Row() {
       Row()
         .width('2.5%')
         .backgroundColor('#fafafa')
        Column({ space: 10 }) {
          Row() {
            Button('个人设置')
              .fontSize(20)
              .fontColor('#000000')
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                //跳转页面
                router.pushUrl({ url: 'pages/PersonalInformation' })
              })
            Button('>')
              .fontSize(20)
              .fontColor('#999999')
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                //跳转页面
                router.pushUrl({ url: 'pages/PersonalInformation' })
              })
          }
          .borderRadius(12)
          .width('95%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row() {
          }
          .width('90%')
          .height(2)
          .backgroundColor('#FAFAFA')

          Row() {
            Button('版本号')
              .fontSize(20)
              .fontColor('#000000')
              .backgroundColor('#ffffff')
              .onClick(() => {
                router.pushUrl({ url: 'pages/Version' })
              })
            Button('V1.0')
              .fontSize(20)
              .fontColor('#000000')
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                router.pushUrl({ url: 'pages/Version' })
              })
          }
          .width('95%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row() {
          }
          .width('90%')
          .height(2)
          .backgroundColor('#FAFAFA')

          Row() {
            Button('扫码下载')
              .fontSize(20)
              .fontColor('#000000')
              .backgroundColor('#ffffff')
              .onClick(() => {
                router.pushUrl({ url: 'pages/SaoMa' })
              })

            Button()
              .width(30)
              .height(30)
              .backgroundImage($r('app.media.erweima'))
              .backgroundImageSize(ImageSize.Cover)
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                router.pushUrl({ url: 'pages/SaoMa' })
              })

          }
          .width('95%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row() {
          }
          .width('90%')
          .height(2)
          .backgroundColor('#FAFAFA')

          Row() {
            Button('清除缓存')
              .fontSize(20)
              .fontColor('#000000')
              .backgroundColor('#ffffff')
              .onClick(() => {
                //操作确认类弹出框
                DialogHelper.showAlertDialog({
                  content: "是否清除缓存",
                  onAction: (action) => {
                    if(action==-2){
                      DialogHelper.showToast("清理完成")
                    }
                  }
                })
              })
            Button()
              .width(30)
              .height(30)
              .backgroundImage($r('app.media.clean'))
              .backgroundImageSize(ImageSize.Cover)
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                //操作确认类弹出框
                DialogHelper.showAlertDialog({
                  content: "是否清除缓存",
                  onAction: (action) => {
                    if(action==-2){
                      DialogHelper.showToast("清理完成")
                    }
                  }
                })
              })
          }
          .width('95%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        Row()
          .width('2.5%')
          .backgroundColor('#fafafa')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
        Row() {
        }
        .width('100%')
        .height(200)
        .backgroundColor('#FAFAFA')

    }
    .width('100%')
    .height('100%')
    }

  }
