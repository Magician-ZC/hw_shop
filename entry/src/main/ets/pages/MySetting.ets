/**
 * 我的设置页面
 */
import CommonConstants from '../commons/CommonConstants'
import router from '@ohos.router'
import DataModel from '../model/DataModel'
import ItemData from '../model/ItemData'


@Component
export struct MySetting{

  account: string;

  @Builder
  settingCell(item: ItemData){
    Row(){
      Row({space:CommonConstants.COMMON_SPACE}){
        Image(item.img)
          .width($r('app.float.setting_size'))
          .height($r('app.float.setting_size'))
        Text(item.title)
          .fontSize($r('app.float.normal_text_size'))
      }

      //如果item的others属性为空，则显示一个图像，否则显示一个开关组件
      if(item.others == null){
        Image($r('app.media.right_grey'))
          .height($r('app.float.setting_jump_height'))
          .width($r('app.float.setting_jump_width'))
      }else{
        Toggle({type: ToggleType.Switch,isOn: false})
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(CommonConstants.FULL_PARENT)
    .padding({
      left:$r('app.float.setting_settingCell_left'),
      right:$r('app.float.setting_settingCell_right'),
    })
  }

  build(){
    Scroll(){
      Column({space: CommonConstants.COMMON_SPACE}){
        //账户信息
        Row(){
          Image($r('app.media.account'))
            .width($r('app.float.setting_account_size'))
            .height($r('app.float.setting_account_size'))
          Column(){
            Text($r('app.string.setting_account_name'))
              .fontSize($r('app.float.setting_account_fontSize'))
            Text(this.account.toString())
              .fontSize($r('app.float.little_text_size'))
              .margin({top:$r('app.float.setting_name_margin')})
          }
          .alignItems(HorizontalAlign.Start)
          .margin({left:$r('app.float.setting_account_margin')})
        }
        .margin({top:$r('app.float.setting_account_margin')})
        .alignItems(VerticalAlign.Center)
        .width(CommonConstants.FULL_PARENT)
        .height($r('app.float.setting_account_height'))
        .backgroundColor(Color.White)
        .padding({left:$r('app.float.setting_account_padding')})
        .borderRadius($r('app.float.setting_account_borderRadius'))
        
        
        //列表布局组件
        List(){
          ForEach(DataModel.getSettingListData(),(item:ItemData)=>{
            //构建每一行
            ListItem(){
              this.settingCell(item)
            }
            .height($r('app.float.setting_list_height'))
          })
        }
        .backgroundColor(Color.White)
        .width(CommonConstants.FULL_PARENT)
        .divider({
          strokeWidth:$r('app.float.setting_list_strokeWidth'),
          color:Color.Gray,
          startMargin:$r('app.float.setting_list_startMargin'),
          endMargin:$r('app.float.setting_list_endMargin')
        })
        .borderRadius($r('app.float.setting_list_borderRadius'))
        .padding({top:$r('app.float.setting_list_padding'),bottom:$r('app.float.setting_list_padding')})

        Blank()

        //退出按钮
        Button($r('app.string.setting_button'),{type:ButtonType.Capsule})
          .width(CommonConstants.BUTTON_WIDTH)
          .height($r('app.float.login_button_height'))
          .fontSize($r('app.float.normal_text_size'))
          .fontColor($r('app.color.setting_button_fontColor'))
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r('app.color.setting_button_backgroundColor'))
          .margin({bottom:$r('app.float.setting_size')})
          .onClick(()=>{
            AlertDialog.show({
              title:"提示",
              message:"退出该账号？",
              autoCancel:true,
              alignment:DialogAlignment.Center,
              primaryButton:{
                value:'取消',
                action:()=>{

                }
              },
              secondaryButton:{
                value:'确认',
                fontColor:$r('app.color.setting_button_fontColor'),
                action:()=>{
                  //页面跳转
                  router.replaceUrl({
                    url: "pages/Login",
                    params:{
                      sendMsg:this.account
                    }
                  })
                }
              }

            })
          })
      }
      .height(CommonConstants.FULL_PARENT)
    }
  }
}