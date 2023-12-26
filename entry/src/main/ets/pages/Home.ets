/**
 * 我的设置页面
 */
import CommonConstants from '../commons/CommonConstants'
import router from '@ohos.router'
import DataModel from '../model/DataModel'
import ItemData from '../model/ItemData'
import { PicData } from '../model/PicData'
import promptAction from '@ohos.promptAction'
import SearchResult from '../model/SearchResult'
import http from '@ohos.net.http'
import hilog from '@ohos.hilog'

let dataSource = new PicData()

@Component
export default struct Home{

  @State pageNo: number = 0
  total: number = 0
  @State running: boolean = true
  @State columnsTemplate: string = '1fr 1fr'
  @State imageHeight: string = '20%'


  private swiperController: SwiperController = new SwiperController();

  private scrollerMain: Scroller = new Scroller();
  private scrollerWaterFlow: Scroller = new Scroller();

  @Builder
  loadDataFooter() {
    LoadingProgress()
      .width(px2vp(150))
      .height(px2vp(150))
      .color(Color.Orange)
  }

  aboutToAppear(){
    this.requestData()
  }

  build(){
    Scroll(this.scrollerMain){
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
        Stack(){
          WaterFlow({scroller:this.scrollerWaterFlow}) {
            LazyForEach(dataSource, item => {
              FlowItem() {
                Column({ space: 10 }) {
                  Image(item.coverUrl).objectFit(ImageFit.Cover)
                    .width('100%')
                    .height(this.imageHeight)
                  Text(item.title)
                    .fontSize(px2fp(50))
                    .fontColor(Color.Black)
                    .width('100%')
                }.onClick(() => {
                  router.pushUrl({ url: 'custompages/waterflow/Detail', params: item })
                })
              }
            }, item => item)
          }
          .columnsTemplate(this.columnsTemplate)
          .columnsGap(5)
          .rowsGap(5)
          .onReachStart(() => {
            this.scrollerWaterFlow = this.scrollerMain
          })
          .onReachEnd(() => {
            if (!this.running) {
              if ((this.pageNo + 1) * 15 < this.total) {
                this.pageNo++
                this.running = true

                setTimeout(() => {
                  this.requestData()
                }, 2000)
              }
            }

          })
          .width('100%')
          .height('100%')
          .layoutDirection(FlexDirection.Column)

          if (this.running) {
            this.loadDataFooter()
          }
        }

      }
    }
    .height(CommonConstants.FULL_PARENT)
  }

  requestData() {
    let url = `https://api.apiopen.top/api/getHaoKanVideo?page=${this.pageNo}&size=15`
    let httpRequest = http.createHttp()
    httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET,
        header: {
          "User-Agent": "Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Mobile Safari/537.36",
          'Content-Type': 'application/json; charset=utf-8'
        },
      },(err,data)=>{
      if(!err){
        let searchResult: SearchResult = JSON.parse(data.result as string)

        if (searchResult) {
          this.total = searchResult.result.total
          searchResult.result.list.forEach(ItemModel => {
            dataSource.addData(ItemModel)
          })
          this.running = false
        }
      }else{
        console.log(JSON.stringify(err)+"123123213");
        hilog.info(0xFF00, "testTag", JSON.stringify(err));
        promptAction.showToast({
          message: '网络异常: ' + JSON.stringify(err),
          duration: 2000
        })

        httpRequest.destroy();
      }
    });
  }
}