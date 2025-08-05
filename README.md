<img width="335" height="712" alt="image" src="https://github.com/user-attachments/assets/b739c7c9-01fd-41f3-b162-162247ba4eed" />

<img width="362" height="719" alt="image" src="https://github.com/user-attachments/assets/411d0498-49c7-435d-abc6-8617143069c4" />

<img width="352" height="722" alt="image" src="https://github.com/user-attachments/assets/03170948-272a-42d1-b45e-dca1f65ea2be" />


<img width="370" height="752" alt="image" src="https://github.com/user-attachments/assets/efd47b96-d7f9-4215-9e83-b7bf8c55b4ad" />
<img width="350" height="706" alt="image" src="https://github.com/user-attachments/assets/f0b48335-dc73-4de1-8c42-891a8611a045" />
<img width="371" height="713" alt="image" src="https://github.com/user-attachments/assets/2b76441e-dbbd-4864-8c3f-6bcbd63e0fc6" />

<img width="363" height="739" alt="image" src="https://github.com/user-attachments/assets/9408b29a-7f4e-474b-95c6-1b2c63d47780" />

<img width="363" height="748" alt="image" src="https://github.com/user-attachments/assets/34b8e009-482f-4ede-b588-103bae61ea25" />

视频播放
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


