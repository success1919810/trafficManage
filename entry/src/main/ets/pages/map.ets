import { MapComponent, mapCommon, map } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';


@Component
@Entry
export struct mapinindex{
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
      Column(){
        Stack() {
          MapComponent({ mapOptions: this.mapOptions, mapCallback: this.callback }).width('100%').height('100%');
          // // 底层：地图（占满容器）
          // Image($r('app.media.map'))
          //   .height('100%')
          //   .width('100%');

          Search({placeholder: '输入设备名称搜索'})
            .height(40)
            .width(360)
            // 添加上边距和水平边距，使其浮在顶部
            .position({ top: 20 ,left:5})

          // 图层选择按钮
          Column({space:13}){
            Column({space:3}){
              Button() {
                Image($r('app.media.tu')) // 图层图标
                  .width(30)
                  .height(30)
              }
              Text('图层')
            }
            .width(40)
            .height(40)


            // 上报按钮
            Column({space:2}){
              Button() {
                Image($r('app.media.warning')) // 上报图标
                  .width(30)
                  .height(30)
                  .backgroundColor('#FFFFFF80')
              }
              Text('上报')
            }
            .width(40)
            .height(40)
          }
          .width(40)
          .height(110)
          .position({ top: 80, right: 10 })
          .borderWidth(1)
        }
        .height('100%') // 让Stack占满父容器高度
        .width('100%')
        .backgroundColor('#0000000')// 让Stack占满父容器宽度
      }
    }
}