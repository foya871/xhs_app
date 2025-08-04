/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-23 14:22:34
 * @LastEditors: wdz
 * @LastEditTime: 2025-06-18 19:42:52
 * @FilePath: /xhs_app/lib/http/api/login.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'dart:async';
import 'dart:convert';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/user/user_info_model.dart';
import 'package:xhs_app/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/services.dart';
import 'package:xhs_app/utils/logger.dart';

final localStore = Get.find<StorageService>();

///从粘贴板中拿到的
Future<String?> _contentFromPasteBoard() async {
  ///首次进来
  String? params;
  if (kIsWeb) {
    var ppp = Uri.base.queryParameters;
    params = jsonEncode(ppp).toString();
  } else {
    final text = await Clipboard.getData(Clipboard.kTextPlain);
    params = text?.text;
  }
  return params;
}

Future<bool> login(String deviceId) async {
  String? params = await _contentFromPasteBoard();
  final localStore = Get.find<StorageService>();
  try {
    UserInfo? resp = await httpInstance.post<UserInfo>(
        url: "user/traveler",
        body: {
          "deviceId": deviceId,
          'code': params,
          'chCode': const String.fromEnvironment('CHANNEL'),
        },
        complete: UserInfo.fromJson);
    if (resp == null || resp.token?.isEmpty == true) return false;
    await localStore.saveUserInfo(resp);
    return true;
  } catch (_) {
    return false;
  }
}

//拉取广告
//拉取广告
Future<bool> fecthAllAds() async {
  try {
    List<AdInfoModel>? ads = await httpInstance.get(
      url: 'all/ad/place/list',
      complete: AdInfoModel.fromJson,
    );
    if (ads == null) return false;
    final localStore = Get.find<StorageService>();
    await localStore.saveAds(ads);
    return true;
  } catch (e) {
    return false;
  }
}

///获取在线客服
Future<String?> fetchOnLine() async {
  try {
    Map? resp = await httpInstance.get(url: 'news/customer/sign');
    if (resp == null) return null;
    if (resp.keys.contains("signUrl")) {
      String url = resp["signUrl"] ?? '';
      if (url.isNotEmpty) {
        await localStore.saveOnLine(url);
        return url;
      }
    }
    return null;
  } catch (e) {
    logger.d("getOnlineService error:${e.toString()}");
    return null;
  }
}
