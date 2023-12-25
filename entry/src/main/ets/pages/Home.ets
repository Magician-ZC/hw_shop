/**
 * 我的设置页面
 */
import CommonConstants from './CommonConstants'
import router from '@ohos.router'
import DataModel from './DataModel'
import ItemData from './ItemData'


@Entry
@Component
struct Home{

  private swiperController: SwiperController = new SwiperController();

  build(){
    Scroll(){
      Column({space: CommonConstants.COMMON_SPACE}){
        Column(){//创建一个内嵌的列布局
          Text($r('app.string.mainPage_tabTitles_home'))
            .fontWeight(FontWeight.Medium)
            .fontSize($r('app.float.page_title_text_size'))
            .margin({
              top:$r('app.float.mainPage_tabTitles_margin')
            })
            .padding({
              left:$r('app.float.mainPage_tabTitles_padding')
            })
        }
        .width(CommonConstants.FULL_PARENT)
        .alignItems(HorizontalAlign.Start)

        //轮播图片
        Swiper(this.swiperController){
          ForEach(DataModel.getSwiperImages(),(item:Resource)=>{
              //构建每一张图片组件
              Image(item)
                .borderRadius($r('app.float.home_swiper_borderRadius'))
          })
        }
        .autoPlay(true)//轮播组件
        .margin({top :$r('app.float.home_swiper_margin')})

        //菜单列表
        Grid(){
          ForEach(DataModel.getFirstGridData(),(item:ItemData)=>{
            GridItem(){
              Column(){
                Image(item.img)
                  .width($r('app.float.home_homeCell_size'))
                  .height($r('app.float.home_homeCell_size'))
                Text(item.title)
                  .fontSize($r('app.float.home_homeCell_size'))
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

        //频道列表
        Text($r('app.string.home_list'))
          .fontSize($r('app.float.normal_text_size'))
          .fontWeight(FontWeight.Medium)
          .width(CommonConstants.FULL_PARENT)
          .margin({top :$r('app.float.home_text_margin')})

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
      }
    }
    .height(CommonConstants.FULL_PARENT)
  }
}