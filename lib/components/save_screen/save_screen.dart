/*
 * @Author: wangdazhuang
 * @Date: 2024-10-22 19:29:40
 * @LastEditTime: 2024-11-02 09:25:33
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/components/save_screen/save_screen.dart
 */
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../easy_toast.dart';
import 'permission_request.dart';

class SaveScreen {
  static Future<void> captureAndSaveScreenshot(Uint8List capturedImage,
      {bool isBack = true}) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/screeshoot_${DateTime.now().millisecondsSinceEpoch}.png');
      final buffer = file.openWrite();
      buffer
          .addStream(Stream.fromIterable([Uint8List.fromList(capturedImage)]));

      final result = await ImageGallerySaver.saveFile(file.path);
      EasyToast.show(result["isSuccess"] ? '保存成功' : '保存失败');
      buffer.flush();
      await buffer.close();
      if (isBack) {
        Get.back();
      }
    } catch (e) {}
  }

  static Future<bool> permissionCheckAndRequest(
      BuildContext context, Permission permission, String permissionTypeStr,
      {bool isRequiredPermission = false}) async {
    if (!await permission.status.isGranted) {
      await Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: ((context, animation, secondaryAnimation) {
            return PermissionRequestPage(permission, permissionTypeStr,
                isRequiredPermission: isRequiredPermission);
          })));
      return false;
    }
    return true;
    // return await permission.status.isGranted;
  }

  static Future<void> onCaptureClick(
      BuildContext context, ScreenshotController screenshotController,
      {bool isBack = true}) async {
    if (kIsWeb) {
      // screenshotController
      //     .captureAsUiImage(delay: const Duration(milliseconds: 100))
      //     .then((capturedImage) async {
      //   final blob = html.Blob([capturedImage]);
      //   final url = html.Url.createObjectUrlFromBlob(blob);
      //   final anchor = html.AnchorElement()
      //     ..href = url
      //     ..download = 'photo.png';
      //   anchor.click();
      //   html.Url.revokeObjectUrl(url);
      // }).catchError((onError) {
      //   EasyToast.show('保存失败>>>${onError.toString()}');
      // });
      EasyToast.show('请自行用手机截屏保存分享哦～');
      return;
    }

    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.androidInfo;
    final sdkInt = deviceInfo.version.sdkInt;
    bool result = await SaveScreen.permissionCheckAndRequest(
        context, sdkInt < 33 ? Permission.storage : Permission.photos, "存储");
    if (result) {
      screenshotController
          .capture(delay: const Duration(milliseconds: 50))
          .then((capturedImage) async {
        SaveScreen.captureAndSaveScreenshot(capturedImage!, isBack: isBack);
      });
    } else {
      EasyToast.show('如已授权请重新点击保存，否则请授权');
    }
  }
}
