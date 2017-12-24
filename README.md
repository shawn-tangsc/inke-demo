# 仿映客直播app（ios原生）


说明：
====================================
实战是学习一门技术最快的捷径，之前大欢老师视频教学仿映客app的ios教学。但是因为时间比较久，映客应该做过一次改版，按照大欢老师的视频已经没有效果了，所以我就参考着大欢老师的教学视频，再根据最新的接口和界面，新仿了一遍映客app，在这里通常工作中使用到的ios控件效果大部分都有了，非常值得做为学习参考。

**<font color=red face="黑体">特别声明：本代码仅学习使用，如果涉及侵权，可删！</font>**



使用：
====================================

下载
------------------------------------

使用git从[inke-demo](https://github.com/shawn-tangsc/inke-demo)主页下载项目

``` bash
git clone https://github.com/shawn-tangsc/inke-demo
```

pod 初始化
------------------------------------

从终端进入项目`Podfile`所在的文件夹，然后执行初始化命令

``` bash
pod install
```

配置和导入ijkplayer（直播引流）
------------------------------------

播放直播视频和普通视频是稍微有点不同的，ios自带的视频播放是无法播放直播地址的视频，所以要导入bilibili的[ijkplayer](https://github.com/Bilibili/ijkplayer)，由于framework 太大了，所以我就不上传了，可以按照下面路径学习一下，或者到我指定的[百度云盘](https://pan.baidu.com/s/1pLzb8uf)去下载（密码:q1us）。

+ 从github上面下载控件

``` bash
git clone https://github.com/Bilibili/ijkplayer.git ijkplayer-ios

```

+ 进入目标文件夹

``` bash
cd ijkplayer-ios
```

+ 执行两个脚本

``` bash
./init-ios.sh
./init-ios-openssl.sh
```

+ 进入该文件夹下的ios文件夹

``` bash
cd ios
```

+ 执行4个脚本

```bash
./compile-ffmpeg.sh clean
./compile-ffmpeg.sh all
./compile-openssl.sh clean
./compile-openssl.sh all
```

+ 再进入该目录下的IJKMediaPlayer目录,双击.xcodeproj文件，然后选择IJKMediaPlayerFrameworkWithSSL,点击run生成IJKMediaPlayerFrameworkWithSSL.framework.

+ 将此frameword放到inke-demo文件夹下，或者自行到inke-demo的项目中去改IJKMediaPlayerFrameworkWithSSL.framework的路径

直播推流
------------------------------------
这里使用的是[LFLiveKit](https://github.com/LaiFengiOS/LFLiveKit),但是因为没有合适和直播推流的测试服务器地址，而且抓包映客的直播服务器可以连接，但是不能播放，所以该功能先只做到这里，待以后继续开发。

集成友盟（第三方登录）
------------------------------------
大欢老师视频教学里面的友盟版本已经比较低了，所以我根据最新的[友盟文档](http://dev.umeng.com/social/ios/ios9)完成了第三方登录的功能（因为一些key的原因，我暂时只做了微信登录的功能，其他的根据文档可以自行开发）。
其中，我因为没明白视频里面的sdk集成方式，所以我还是用了传统的pod的方式集成的。

``` 
pod 'UMengUShare/UI'
# 集成新浪微博 【友盟官网技术文档这里标点符号有错，导入的时候记得更改】
pod 'UMengUShare/Social/Sina'
# 集成微信
pod 'UMengUShare/Social/WeChat'
# 集成QQ
pod 'UMengUShare/Social/QQ'
```

执行
------------------------------------
双击inke-demo下的.xcworkspace 应该就可以run了。

<!--效果
------------------------------------

-->


<!--<img src="/styles/images/zhifubao.PNG" alt="支付宝二维码付款给Freud" width="310" />-->
