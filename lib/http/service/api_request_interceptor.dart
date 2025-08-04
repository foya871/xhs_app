/*
 * @Author: wangdazhuang
 * @Date: 2024-10-19 09:25:19
 * @LastEditTime: 2025-06-12 14:08:31
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/api_request_interceptor.dart
 */

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../generate/app_build_config.dart';
import '../../services/storage_service.dart';
import 'api_const.dart';

////请求拦截器
abstract class ApiRequestInterceptor {
  static void Function(RequestOptions, RequestInterceptorHandler) onRequest =
      (options, handler) {
    final localStore = Get.find<StorageService>();
    final token = localStore.token ?? '';
    if (token.isNotEmpty) options.headers["aut"] = token;
    final t = DateTime.now().millisecondsSinceEpoch.toString();
    options.headers["t"] = t;
    options.headers["s"] =
        md5.convert(utf8.encode(t.substring(3, 8))).toString();
    if (kIsWeb) options.headers["User-Mark"] = AppBuildConfig.appName;
    options.headers[Headers.acceptHeader] =
        ApiConst.kContentTypeApplicationJSON;
    if (!kIsWeb) options.headers["User-Agent"] = ApiConst.kNativeDeviceUA;
    final did = localStore.deviceId ?? '';
    if (did.isNotEmpty) options.headers["deviceId"] = did;
    if (options.method.toUpperCase() == 'POST' && options.data == null) {
      options.data = {};
    }
    return handler.next(options);
  };
}
