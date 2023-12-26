/**
 * 我的设置页面
 */
import CommonConstants from '../commons/CommonConstants'
import router from '@ohos.router'
import DataModel from '../model/DataModel'
import ItemData from '../model/ItemData'


@Component
export default struct Home{

  private swiperController: SwiperController = new SwiperController();



  build(){
    Scroll(){
      Column({space: CommonConstants.COMMON_SPACE}){

        //轮播图片
        Swiper(this.swiperController){
          ForEach(DataModel.getSwiperImages(),(item:Resource)=>{
              //构建每一张图片组件
              Image(item)
                .borderRadius($r('app.float.home_swiper_borderRadius'))
          })
        }
        .autoPlay(true)//轮播组件

        //菜单列表
        Grid(){
          ForEach(DataModel.getFirstGridData(),(item:ItemData)=>{
            GridItem(){
              Column(){
                Image(item.img)
                  .width($r('app.float.home_homeCell_size'))
                  .height($r('app.float.home_homeCell_size'))
                Text(item.title)
                  .fontSize($r('app.float.little_text_size'))
                  .margin({top:$r('app.float.home_homeCell_margin')})
              }
            }
          })
        }
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .columnsGap($r('app.float.home_grid_columnsGap'))
        .rowsGap($r('app.float.home_grid_rowGap'))
        .padding({
          top:$r('app.float.home_grid_padding'),
          bottom:$r('app.float.home_grid_padding')
        })
        .height($r('app.float.home_grid_height'))
        .backgroundColor(Color.White)
        .borderRadius($r('app.float.home_grid_borderRadius'))

        Grid(){
          ForEach(DataModel.getSecondGridData(),(item:ItemData)=>{
            GridItem(){
              Column(){
                Text(item.title)
                  .fontSize($r('app.float.normal_text_size'))
                  .fontWeight(FontWeight.Medium)
                Text(item.others)
                  .margin({
                    top:$r('app.float.home_list_margin')
                  })
                  .fontSize($r('app.float.little_text_size'))
                  .fontColor($r('app.color.home_grid_fontColor'))
              }
              .alignItems(HorizontalAlign.Start)
            }
            .padding({
              top:$r('app.float.home_list_padding'),
              left:$r('app.float.home_list_padding')
            })
            .borderRadius($r('app.float.home_backgroundImage_borderRadius'))
            .align(Alignment.TopStart)
            .backgroundImage(item.img)
            .backgroundImageSize(ImageSize.Cover)
            .width(CommonConstants.FULL_PARENT)
            .height(CommonConstants.FULL_PARENT)
          })
        }
        .width(CommonConstants.FULL_PARENT)
        .height($r('app.float.home_secondGrid_height'))
        .columnsTemplate('1fr 1fr')
        .columnsGap($r('app.float.home_grid_columnsGap'))
        .rowsTemplate('1fr 1fr')
        .rowsGap($r('app.float.home_grid_rowGap'))
        .margin({
          bottom:$r('app.float.home_secondGrid_margin')
        })
      }
    }
    .height(CommonConstants.FULL_PARENT)
  }
}