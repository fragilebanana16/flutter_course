# flutter_home_manager
- 起因：网易云广告太多，自实现移动端音乐播放
- 经过：快速实现非原生播放器，不经意加入其他功能
- 结果：嵌套太纠结，转战Vue3+TS+Spring Boot
#### Splash
<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/splash.jpg" width=200px/>
  
#### TodoList
<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-todolist.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-todolist2.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-todolist3.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-todolist4.jpg" width=200px/>

#### 文件服务器
<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-fileshare.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-fileshare2.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-fileUI.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-fileUI2.jpg" width=200px/>

#### 联系人导入导出
<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-contact.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-contact2.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-contact3.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/toolbox-contact4.jpg" width=200px/>

#### 聊天
<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/socketChat.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/socketChat2.jpg" width=200px/>

#### 音乐
<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/music.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/music2.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/music3.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/music4.jpg" width=200px/>&nbsp;&nbsp;<image src="https://github.com/fragilebanana16/flutter_course/blob/main/example/music5.jpg" width=200px/>

## 环境
-状态：riverpod/get
-路由：go_router
-持久化：sqflite
-vscode + as模拟器
1.Riverpod不同widget传值：全局定义StateProvider，使用入参watch获取
2.Route使用push组件注入的方式进行切换页面

## 构建
https://flutter.cn/docs/deployment/android

## 快速构建：
使用如下命令：
1.cd [project]。
2.flutter build apk --split-per-abi.

设备安装 APK 文件
1.用 USB 线将 Android 设备连接到电脑上；
2.输入命令 cd [project]；
3.运行 flutter install

使用app-armeabi-v7a-release.apk

[TODO]
1、服务端启动后主页不更新页面
2、离线版音乐播放器
3、filepicker读本地音频路径播放，增加本地页签，自动加入队列

[BUG]
1、chat页面多次选择角色后退出再次点击需多次不确定次数点击才能进入

[NOTES]
contacts_service: ^0.6.3问题flutter doctor --android-licenses
