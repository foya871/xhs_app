import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../http/api/api.dart';
import '../../../../model/mine/share_link_model.dart';
import '../../../../routes/routes.dart';
import '../../../../services/storage_service.dart';
import '../../../../utils/save_account_dialog.dart';

class MineSettingController extends GetxController {
  final mCacheManager = DefaultCacheManager();

  final service = Get.find<StorageService>();
  final us = Get.find<UserService>();
  var imageCachesize = "0 M".obs;
  var version = ''.obs;
  var isAppLock = false.obs;
  var url = ''.obs;

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  void openAppLock() {}

  void changeAppIcon() {
    if (service.isChangeAppIcon == true) {
      service.saveChangeAppIcon(false);
    } else {
      service.saveChangeAppIcon(true);
    }
  }

  @override
  void onInit() {
    getImageCacheSize();
    getAppVersion();
    _getSharedLink();
    super.onInit();
  }

  getImageCacheSize() async {
    ImageCache? imageCache = PaintingBinding.instance?.imageCache;
    if (imageCache != null) {
      int byte = imageCache.currentSizeBytes;
      if (byte >= 0 && byte < 1024) {
        imageCachesize.value = '$byte B';
      }
      if (byte >= 1024 && byte < 1024 * 1024) {
        double size = (byte * 1.0 / 1024);
        String sizeStr = size.toStringAsFixed(2);
        imageCachesize.value = '$sizeStr KB';
      } else {
        double size = (byte * 1.0 / 1024) / 1024;
        String sizeStr = size.toStringAsFixed(2);
        imageCachesize.value = '$sizeStr MB';
      }
    }
  }

  clearImageCacheSize() {
    ImageCache? imageCache = PaintingBinding.instance?.imageCache;
    if (imageCache != null) {
      imageCache.clear();
    }
  }

  Future _getSharedLink() async {
    try {
      final result = await Api.getShareLink();
      if (result is ShareRespModel) {
        url.value = result.url ?? '';
      }
    } catch (e) {
      return null;
    }
  }

  String getMainDomainFromUrl() {
    Uri uri = Uri.parse(url.value);
    if (url.value.isEmpty) return '';
    return uri.host.split('.').length > 2
        ? '${uri.scheme}://${uri.authority}'
        : '${uri.scheme}://${uri.host}';
  }

  Future<void> onClick(int index) async {
    switch (index) {
      case 1: //应用锁

        break;
      case 2: //设置桌面图标
        changeAppIcon();
        break;
      case 3: //清理缓存
        clearImageCacheSize();
        getImageCacheSize();
        break;
      case 4: //应用锁开
        break;

      case 6: //账号卡
        if (us.user.account!.isEmpty) {
          Get.toNamed(Routes.register);
          return;
        }
        saveAccountDialog(Get.context!, us.user.account!,
            service.registerPassword, false, getMainDomainFromUrl());
        break;
    }
  }
}
