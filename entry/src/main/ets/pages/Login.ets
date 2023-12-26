
import CommonConstants from '../commons/CommonConstants'
import prompt from '@ohos.prompt'
import Prompt from '@system.prompt'
import router from '@ohos.router'

/**
 * 登录页面
 */
@Entry
@Component
struct Index {
  @State
  account: string=''//登录的账号

  @State
  password: string=''//登录的密码

  @State
  isShowProgress: boolean=false //控制是否显示进度条

  private timeOutId:number = -1 //控制登录超时时间的变量


  onPageShow(){
    let acc = router.getParams() as Record<string,string>
    if(acc){
      this.account = acc['sendMsg']
    }
  }

  login(): void{
    if(this.account === '' || this.password===''){
      Prompt.showToast({ //开启一个确认的提示
        // @ts-ignore
        message: $r('app.string.input_empty_tips'),
      });
    }else{
      this.isShowProgress = true
      if(this.timeOutId === -1){
        //设置一个定时器，定时2s
        this.timeOutId = setTimeout(()=>{
          //2s之后执行的函数
          this.isShowProgress = false
          this.timeOutId = -1
          //页面跳转
          router.replaceUrl({
            url: "pages/Index",
            params:{
              sendMsg:this.account
            }
          })
        },CommonConstants.LOGIN_DELAY_TIME)
      }
    }
  }

  aboutToDisappear(){
    //取消定时器
    clearTimeout(this.timeOutId)
    this.timeOutId = -1
  }

  @Builder
  imageButton(image: Resource){
    //构建按钮图片： 本质上，就是在按钮里面增加一个Image组件
    Button({type:ButtonType.Circle,stateEffect: true}){
      Image(image)
    }
    .height($r('app.float.other_login_image_size'))
    .width($r('app.float.other_login_image_size'))
    .backgroundColor($r('app.color.background'))
  }

  build() {
    //登录页面的布局
    Column(){
      Image($r('app.media.logo'))
        .width($r('app.float.logo_image_size'))
        .height($r('app.float.logo_image_size'))
        .margin({
          top:$r('app.float.logo_image_size'),
          bottom:$r('app.float.logo_image_size')
        })

      //标题
      Text($r('app.string.login_page'))
        .fontSize($r('app.float.page_title_text_size'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.title_text_color'))

      //登录了解更多的text
      Text($r('app.string.login_more'))
        .fontSize($r('app.float.normal_text_size'))
        .fontColor($r('app.color.title_text_color'))
        .margin({
          top:$r('app.float.login_more_margin_top'),
          bottom:$r('app.float.login_more_margin_bottom')
        })

      //账号输入框
      TextInput({ placeholder:$r('app.string.account'),text:this.account!=null?this.account:null })
        .inputStyle()
        .maxLength(CommonConstants.INPUT_ACCOUNT_LENGTH)
        .type(InputType.Number)
        .onChange((value:string)=>{
          this.account = value;
        })

      Line().lineStyle() //账号输入框下面的分割线

      //密码输入框
      TextInput({ placeholder:$r('app.string.password') })
        .inputStyle()
        .maxLength(CommonConstants.INPUT_PASSWORD_LENGTH)
        .type(InputType.Password)
        .onChange((value:string)=>{
          this.password = value;
        })

      Line().lineStyle() //密码输入框下面的分割线

      //短信提示，和忘记密码
      Row(){
        Text($r('app.string.message_login')).blueTextStyle()
        Text($r('app.string.forgot_password')).blueTextStyle()
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(CommonConstants.FULL_PARENT)
      .margin({
        top:$r('app.float.forgot_margin_top')
      })

      //登录按钮
      Button($r('app.string.login'),{type:ButtonType.Capsule})//胶囊形状
        .width(CommonConstants.BUTTON_WIDTH)
        .height($r('app.float.login_button_height'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.login_button_color'))
        .margin({
          top:$r('app.float.login_button_margin_top'),
          bottom:$r('app.float.login_button_margin_bottom')
        })
        .onClick(()=>{
          //todo:登录的事件
          this.login()
        })

      //注册账号文本
      Text($r('app.string.register_account'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.login_blue_text_color'))

      if(this.isShowProgress){
        LoadingProgress()//圆圈形状的进度条
          .color($r('app.color.loading_color'))
          .width($r('app.float.login_progress_size'))
          .height($r('app.float.login_progress_size'))
          .margin({
            top:$r('app.float.login_progress_margin_top')
          })
      }

      Blank()

      //其他登录方式
      Text($r('app.string.other_login_method'))
        .fontSize($r('app.float.little_text_size'))
        .fontColor($r('app.color.other_login_text_color'))
        .fontWeight(FontWeight.Medium)
        .margin({
          top:$r('app.float.other_login_margin_top'),
          bottom:$r('app.float.other_login_margin_bottom')
        })

      //三种登录方式
      Row({space:CommonConstants.LOGIN_METHODS_SPACE}){
        this.imageButton($r('app.media.login_method1'))
        this.imageButton($r('app.media.login_method2'))
        this.imageButton($r('app.media.login_method3'))
      }
    }
    .backgroundColor($r('app.color.background'))
    .height(CommonConstants.FULL_PARENT)
    .width(CommonConstants.FULL_PARENT)
    .padding({
      left:$r('app.float.page_padding_hor'),
      right:$r('app.float.page_padding_hor'),
      bottom:$r('app.float.login_page_padding_bottom')
    })
  }
}

//输入文本框样式定义
@Extend(TextInput)
function inputStyle(){
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor($r('app.color.background'))
  .width(CommonConstants.FULL_PARENT)
  .padding({
    left:CommonConstants.INPUT_PADDING_LEFT
  })
  .margin({
    top:$r('app.float.input_margin_top')
  })
}

//Line组件的自定义样式扩展
@Extend(Line)
function lineStyle(){
  .width(CommonConstants.FULL_PARENT)
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

//Text组件的蓝色文本样式
@Extend(Text)
function blueTextStyle(){
  .fontColor($r('app.color.login_blue_text_color'))
  .fontSize($r('app.float.small_text_size'))
  .fontWeight(FontWeight.Medium)
}