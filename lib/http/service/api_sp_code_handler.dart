import 'package:get/get.dart';

import '../../services/storage_service.dart';
import '../api/login.dart';
import 'api_sp_code.dart';
import 'restart_app_dialog.dart';
import 'package:dio/src/response.dart' as dio;

abstract class ApiSpCodeHandler {
  ///处理特殊状态码
  static Future<void> handle({
    required int code,
    required dio.Response response,
  }) async {
    ///刷新Token
    if (code == ApiSpCodeEnum.refreshToken) {
      final headers = response.headers.map;
      const refreshTokenKey = 'refresh-authorization';
      if (headers.keys.contains(refreshTokenKey)) {
        final value = headers[refreshTokenKey] ?? [];
        if (value.isNotEmpty == true) {
          final newToken = value.first;
          await Get.find<StorageService>().setToken(newToken);
        }
      }
    } else if (code == ApiSpCodeEnum.tokenError||
        code == ApiSpCodeEnum.user_not_exsit) {
      ///token解析错误
      final localStore = Get.find<StorageService>();
      await login(localStore.deviceId ?? '');
    } else {
      ///其他的情况
      RestartAppDialog.show(url: response.realUri.path, code: code);
    }
  }
}
