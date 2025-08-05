<img width="335" height="712" alt="image" src="https://github.com/user-attachments/assets/b739c7c9-01fd-41f3-b162-162247ba4eed" />

<img width="362" height="719" alt="image" src="https://github.com/user-attachments/assets/411d0498-49c7-435d-abc6-8617143069c4" />

<!--
 * @Author: wangdazhuang
 * @Date: 2024-09-27 20:48:32
 * @LastEditTime: 2025-01-18 13:32:47
 * @LastEditors: wangdazhuang
 * @Description:
 * @FilePath: /xhs_app/README.md
-->

# yuseman_app

cd 到当前路径
flutter pub get
dart run build_runner watch --delete-conflicting-outputs
然后再 flutter run

当在 ios 设备或者模拟器上 run 不起来的时候 cd 到 ios 目录下 并运行 pod install 命令，
如果还是运行不起来的话，cd 到 ios 目录下 删除 Podfile.lock 然后再运行 pod install

dart pub run build_runner build

关于在 web 上运行调试的注意事项:

lib > src > http 目录下的两个文件

1.porxy.dart

/前端页面访问本地域名 将这里改成自己的本地 IP 地址
const String localHost = '192.168.1.248';

/// 要访问的服务端 api 地址
String realHttpURL = '<http://118.107.45.22:9754>';

2.environment_service

kbaseAPI 改成自己的本地 IP+代理端口号：

<http://192.168.1.248:5271>

3.运行 dart run porxy.dart 然后再启动 web 调试

清理缓存

```.sh
dart run build_runner clean
```

只执行一次构建并删除冲突的文件

```.sh
dart run build_runner build --delete-conflicting-outputs --verbose

```

持续监控文件变化并自动重新生成

```.sh
dart run build_runner watch --delete-conflicting-outputs --verbose
```


cd scripts 
./fast_auto_assets.sh


