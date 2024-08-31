# flutter_home_manager


## Getting Started

-vscode + as模拟器

1.Riverpod不同widget传值：全局定义StateProvider，使用入参watch获取
2.Route使用push组件注入的方式进行切换页面

## 构建
说明：https://flutter.cn/docs/deployment/android

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
