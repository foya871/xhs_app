/*
 * @Author: wangdazhuang
 * @Date: 2024-08-01 17:22:04
 * @LastEditTime: 2025-06-18 19:56:00
 * @LastEditors: wdz
 * @FilePath: /xhs_app/lib/env/environment_service.dart
 */

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

abstract class Environment {
  static get enableM3u8DownloadLog => false;
  static get enableAPiLog => true;
  static get _useDevApi => false;

  ///选线成功 web平台默认true
  static bool get apiLinesOk => GetPlatform.isWeb || androidiOSAPI.isNotEmpty;

  /// 线上正式
  static get _productApiList => [
        'https://jhfkdnov21vfd.fhoumpjjih.work',
        'https://jhfkdnov21vfd.dyfcbkggxn.work',
        'https://jhfkdnov21vfd.rggwiyhqtg.work',
        getRandomFanDomain(),
      ];

  static List<String> get apiList {
    if (_useDevApi) {
      return [
        // 'http://118.107.45.22:8090', //debug测试
        // /debug正式
        ..._productApiList,
      ];
    } else {
      // release正式
      return _productApiList;
    }
  }

  ///*. 随意的字符串
  static String get fanDomain => "*.bpbbmplfxc.work";

  static List<String> get backupApisJsonURL {
    if (_useDevApi) {
      return [];
    } else {
      return [
        'https://tc-bj-alijs-1324672756.cos.ap-beijing.myqcloud.com/xhs.json',
        'https://d1xgr6d18sjnhx.cloudfront.net/xhs.json',
      ];
    }
  }

  ///备用官方邮箱
  static String get backupOfficialEmail => 'dyjm2016@gmail.com';

  ///备用落地页json
  static String get backupOfficialAddressJson => "";

  static String getRandomFanDomain() {
    String domain = fanDomain;
    // 随机生成 3 到 5 位的小写字母
    final Random random = Random();
    final int length = random.nextInt(3) + 3;
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    // 生成随机小写字母字符串
    String randomString = List.generate(length, (index) {
      return chars[random.nextInt(chars.length)];
    }).join();

    // 将随机生成的字母字符串拼接到域名后
    String newDomain = "https://$randomString.${domain.substring(2)}";

    return newDomain;
  }

  static String androidiOSAPI = '';

  static String get kbaseAPI {
    String address = '';
    if (kIsWeb) {
      if (kDebugMode) {
        address = 'http://localhost:5280';
        // address = "http://192.168.1.120:5280";
        const addressEnv = String.fromEnvironment('__WEB_PROXY_ADDRESS__');
        if (addressEnv.isNotEmpty && addressEnv.startsWith('http://192.')) {
          address = addressEnv;
        }
      }
    }
    return kIsWeb ? '$address/api/' : androidiOSAPI;
  }

  static String buildAuthPlayUrlString(
          {String? videoUrl, String? authKey, String? id}) =>
      '${kbaseAPI}m3u8/decode/authPath?path=${videoUrl ?? ''}&auth_key=${authKey ?? ''}${id == null ? '' : '&id='}${id ?? ''}';

  static Uri? tryBuildAuthPlayUrl(
          {String? videoUrl, String? authKey, String? id}) =>
      Uri.tryParse(
          buildAuthPlayUrlString(videoUrl: videoUrl, authKey: authKey, id: id));

  static Uri buildAuthPlayUrl(
          {String? videoUrl, String? authKey, String? id}) =>
      Uri.parse(
          buildAuthPlayUrlString(videoUrl: videoUrl, authKey: authKey, id: id));
}
