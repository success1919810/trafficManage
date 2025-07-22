import router from '@ohos.router';
@Entry
@Component
struct Starter {

  @State count:number = 5
  taskId:number = -1
  aboutToAppear(): void {
    //开启定义任务  setTime()   setInterval()
    //参数1：定时任务的执行的操作  参数2：周期时间(毫秒)
    this.taskId = setInterval(()=>{
      if(this.count == 0){
        //1、结束当前定时器
        clearInterval(this.taskId)
        //2、跳转到登录页面
        //router.pushUrl({url:'pages/Index'})   //保留当前页面
        router.replaceUrl({url:'pages/GuideAndLogin/Login'}) //清除当前页面
      }
      this.count--
    },1000)
  }

  build() {
    Column(){
      Stack({alignContent:Alignment.TopEnd}){
      //
        //轮播图
        Swiper(){
          Image($r('app.media.s1'))
          Image($r('app.media.s2'))
        }
        .autoPlay(true) //设置为自动轮播
        .loop(false)    //禁止循环播放
        .duration(500)     //轮播切换的时间
        .interval(1000)    //切换的周期
        .width('100%')
        .height('100%')

      Text('跳过 '+this.count)
        .margin({top:40,right:10})
        .fontColor('#ffffff')
        .padding(10)
        .backgroundColor('#3E5063')
        .borderRadius(15)
        .onClick(()=>{
          //1、清除定时器
          clearInterval(this.taskId)
          //2、跳转到登录页面
          router.replaceUrl({url:'pages/GuideAndLogin/Login'})
        })
      }
    }
    .width("100%")
    .height('100%')
  }
}