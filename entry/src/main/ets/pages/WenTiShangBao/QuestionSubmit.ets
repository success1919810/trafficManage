import router from '@ohos.router';
import { MapComponent, mapCommon, map } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';

@Entry
@Component
struct QuestionSubmit {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  @State isShow: boolean = true;
  @State hiddenType: string = '';
  @State checkTime: string = '';
  @State situation: string = '';
  @State currentLocation: string = '';

  // 地图相关 - 使用您的地图模板
  private mapOptions?: mapCommon.MapOptions;
  private callback?: AsyncCallback<map.MapComponentController>;
  private mapController?: map.MapComponentController;

  aboutToAppear(): void {
    // 地图初始化参数，设置地图中心点坐标及层级
    let target: mapCommon.LatLng = {
      latitude: 39.9181,
      longitude: 116.3970193
    }
    let cameraPosition: mapCommon.CameraPosition = {
      target: target,
      zoom: 15
    }
    this.mapOptions = {
      position: cameraPosition
    }

    // 地图初始化的回调
    this.callback = async (err, mapController) => {
      if (!err) {
        this.mapController = mapController;
        // 初始化marker（标记）参数
        let markerOptions: mapCommon.MarkerOptions = {
          position: {
            latitude: 39.9181,
            longitude: 116.3970193
          }
        };
        // 新建一个默认的marker图标
        await this.mapController?.addMarker(markerOptions);
      }
    }
  }

  build() {
    Stack() {
      // 使用您的地图模板
      Column(){
        Stack() {
          MapComponent({ mapOptions: this.mapOptions, mapCallback: this.callback }).width('100%').height('100%');

          // 顶部搜索栏 - 修改为返回按钮+搜索框
          Row({ space: 4 }) {
            Text('<')
              .fontSize(40)
              .height(40)
              .onClick(() => router.back())

            Search({ placeholder: '搜地点、搜路线' })
              .height(40)
              .width(340)
          }
          .position({ top: 5, left: 5 })



        }
        .height('100%')
        .width('100%')
        .backgroundColor('#0000000')
      }
      .bindSheet(this.isShow, this.mysheet(), {
        height: SheetSize.FIT_CONTENT,
        showClose: false
      })
    }
    .width('100%')
    .height('100%')
    .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }

  @Builder
  mysheet() {
    Column() {
      // 标题栏
      Row() {
        Text('检查记录')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Blank()

        Text('汉安大道925号')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 15, bottom: 15 })

      // 表单项
      Column({ space: 0 }) {
        // 隐患类型
        this.FormItem('隐患类型：', this.hiddenType, () => {
          console.log('选择隐患类型')
        }, true)

        // 整改时间
        this.FormItem('整改时间：', this.checkTime, () => {
          console.log('选择整改时间')
        }, false, $r('app.media.camera'))

        // 情况描述
        this.FormItem('情况描述：', this.situation, () => {
          console.log('输入情况描述')
        })

        // 现场照片
        this.FormItem('现场照片：', '', () => {
          console.log('选择现场照片')
        }, false, $r('app.media.camera'))
      }
      .width('100%')

      // 立即上报按钮
      Button('立即上报')
        .width('90%')
        .height(45)
        .backgroundColor('#4FC3F7')
        .fontColor('#FFFFFF')
        .fontSize(18)
        .borderRadius(8)
        .margin({ top: 30, bottom: 20 })
        .onClick(() => {
          console.log('立即上报');
          router.back();
        })
    }
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 15, topRight: 15 })
  }

  @Builder
  FormItem(label: string, value: string, onClick: () => void, showArrow: boolean = false, icon?: Resource) {
    Row() {
      Text(label)
        .fontSize(16)
        .fontColor('#333333')
        .width(80)

      Blank()

      if (value) {
        Text(value)
          .fontSize(16)
          .fontColor('#666666')
      }

      if (icon) {
        Image(icon)
          .width(20)
          .height(20)
          .margin({ left: 10 })
      }

      if (showArrow) {
        Text('>')
          .fontSize(16)
          .fontColor('#999999')
          .margin({ left: 10 })
      }
    }
    .width('100%')
    .height(50)
    .padding({ left: 20, right: 20 })
    .border({
      width: { bottom: 0.5 },
      color: '#E5E5E5'
    })
    .onClick(onClick)
  }
}