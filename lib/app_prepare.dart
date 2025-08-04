/*
 * @Author: wangdazhuang
 * @Date: 2024-08-21 14:23:37
 * @LastEditTime: 2025-06-18 19:24:40
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /xhs_app/lib/app_prepare.dart
 */

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:xhs_app/components/base_refresh/base_refresh_style.dart';
import 'package:xhs_app/env/environment_service.dart';
import 'package:xhs_app/services/storage_service.dart';
import 'package:xhs_app/services/timer_service.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/conditional_future.dart';

import 'services/app_service.dart';
import 'utils/logger.dart';
import 'utils/uuid.dart';

class AppPrepare {
  AppPrepare._();

  static Future<void> init() async {
    _setGlobalEasyRefresh();
    await Get.putAsync(() => StorageService().init());
    await _initDeviceId();
    //原生设备信息
    if (!kIsWeb) await _getDeviceInfo();
    _initServices();
  }

  static _getDeviceInfo() async {
    var info = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final dname = androidInfo.brand;
      final name = androidInfo.device;
      final model = androidInfo.model;
      final brand = androidInfo.display;
      final version = androidInfo.version.sdkInt;
      info = '$dname/$name/$model/$brand/Android_version=$version';
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      final name = iosInfo.name;
      final model = iosInfo.model;
      final brand = iosInfo.systemName;
      final version = iosInfo.systemVersion;
      info = '$name/$model/$brand/ios_version=$version';
    }
    final localStore = Get.find<StorageService>();
    await localStore.updateDeviceInfo(info);
  }

  static Future<void> _initDeviceId() async {
    final localStore = Get.find<StorageService>();

    String? deviceId = localStore.deviceId;

    if (deviceId == null) {
      if (GetPlatform.isWeb) {
        deviceId = UUID.generate();
      } else {
        deviceId = (await DeviceUuid().getUUID() ?? '').trim();
      }
      if (deviceId.isEmpty) {
        // ??
        exit(1);
      }
      await localStore.setDeviceId(deviceId);
    }
    logger.d('deviceId: ${localStore.deviceId}');
  }

  static Future<void> _initServices() async {
    Get.lazyPut(() => AppService());
    Get.lazyPut(() => UserService());
    Get.put(TimerService());
  }

  ///选线
  static Future<void> chooseAPILines([List<String>? apis]) async {
    const String suffix = "sys/live";
    apis ??= Environment.apiList;
    if (apis.isEmpty) return;
    final option = BaseOptions(connectTimeout: const Duration(seconds: 15));
    final dio = Dio(option);
    final fs = apis.map((item) async {
      try {
        return await dio.get("$item/api/$suffix");
      } catch (e) {
        return Future.value(null);
      }
    }).toList();
    final storageService = Get.find<StorageService>();

    final res = await ConditionalFuture<Response?>(
      fs,
      (res) =>
          res != null &&
          res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300,
    ).any();
    if (res != null) {
      final line = '${res.realUri.origin}/api/';
      Environment.androidiOSAPI = line;
      storageService.setLastSuccessDomain(line);
    } else if (Environment.backupApisJsonURL.isNotEmpty) {
      await _getBackupApisJson(dio);
    }
  }

  static _getBackupApisJson(Dio dio) async {
    final backupResponses = await Future.wait(
      Environment.backupApisJsonURL.map((item) async {
        try {
          final response = await dio.get(item);
          if (response.data != null) {
            return List<String>.from(response.data);
          }
        } catch (e) {
          return null;
        }
        return null;
      }),
    );
    // 获取并更新成功的备份 API 地址
    final backupApis = backupResponses.whereType<List<String>>().toList();
    if (backupApis.isNotEmpty) {
      await chooseAPILines(backupApis.first);
    }
  }

  static void _setGlobalEasyRefresh() {
    EasyRefresh.defaultHeaderBuilder = BaseRefreshStyle.defaultHeaderBuilder;
    EasyRefresh.defaultFooterBuilder = BaseRefreshStyle.defaultFooterBuilder;
  }
}
