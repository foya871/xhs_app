/*
 * @Author: wangdazhuang
 * @Date: 2024-07-19 09:47:51
 * @LastEditTime: 2025-06-12 10:54:25
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/api_decrypt.dart
 */
import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';

import '../../services/storage_service.dart';

abstract class ApiDecrypt {
  ///解密
  static dynamic decrypt(String src) {
    final storage = Get.find<StorageService>();
    String? token = storage.token ?? '';
    assert(token.isEmpty == false);
    String kkkk = token.substring(2, 18);
    final key = Key.fromUtf8(kkkk);
    final iv = IV.fromUtf8(kkkk);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final result = encrypter.decrypt64(src, iv: iv);
    return jsonDecode(result);
  }
}
