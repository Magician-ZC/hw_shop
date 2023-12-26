
import router from '@ohos.router';
import CommonConstants from '../commons/CommonConstants';
import Home from './Home';
import { MySetting } from './MySetting';


@Entry
@Component
struct Index{

  @State
  account: string = "";

  @State
  currentIndex: number = CommonConstants.HOME_TAB_INDEX;

  private tabsController: TabsController = new TabsController();

  onPageShow(){
    let acc = router.getParams() as Record<string,string>
    if(acc){
      this.account = acc['sendMsg']
    }
  }

  @Builder
  TabBuilder(title:string,index:number,selectedImg:Resource,normalImg:Resource){
      Column(){
        Image(index == this.currentIndex?selectedImg:normalImg)
          .width($r('app.float.mainPage_baseTab_size'))
          .height($r('app.float.mainPage_baseTab_size'))
        Text(title)
          .margin({top:$r('app.float.mainPage_baseTab_top')})
          .fontSize($r('app.float.main_tab_fontSize'))
          .fontColor(this.currentIndex == index?$r('app.color.mainPage_selected'):$r('app.color.mainPage_normal'))
      }
    .justifyContent(FlexAlign.Center)
    .height($r('app.float.mainPage_barHeight'))
    .width(CommonConstants.FULL_PARENT)
    .onClick(()=>{
        this.currentIndex = index
        this.tabsController.changeIndex(this.currentIndex)
    })
  }

  build(){
    Tabs({barPosition:BarPosition.End,controller:this.tabsController}){
      TabContent(){
        Home()
      }
      .padding({
        left:$r('app.float.mainPage_padding'),
        right:$r('app.float.mainPage_padding')
      })
      .backgroundColor($r('app.color.mainPage_backgroundColor'))
      .tabBar(this.TabBuilder(CommonConstants.HOME_TITLE,CommonConstants.HOME_TAB_INDEX,$r('app.media.home_selected'),$r('app.media.home_normal')))

      TabContent(){
        MySetting({ account: this.account })
      }
      .padding({
        left:$r('app.float.mainPage_padding'),
        right:$r('app.float.mainPage_padding')
      })
      .backgroundColor($r('app.color.mainPage_backgroundColor'))
      .tabBar(this.TabBuilder(CommonConstants.MINE_TITLE,CommonConstants.MINE_TAB_INDEX,$r('app.media.mine_selected'),$r('app.media.mine_normal')))
    }
    .onChange((index:number)=>{
      this.currentIndex = index
    })
  }
}