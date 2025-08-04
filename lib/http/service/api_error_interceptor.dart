/*
 * @Author: wangdazhuang
 * @Date: 2024-10-19 09:25:19
 * @LastEditTime: 2025-06-12 20:37:43
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/api_error_interceptor.dart
 */

import 'package:dio/dio.dart';
import 'api_const.dart';
import 'api_sp_code_handler.dart';

///特殊请求错误拦截器
abstract class ApiErrorInterceptor {
  static void Function(DioException, ErrorInterceptorHandler)? onError =
      (error, handler) async {
    final response = error.response;
    if (response == null) {
      handler.reject(error);
      return;
    }
    var code = response.statusCode ?? 400;
    final data = response.data;
    if (data is Map) {
      if (data.containsKey("code")) {
        code = data['code'] ?? 400;
      }
    }

    ///处理特殊业务码
    if (ApiConst.spCodes.contains(code)) {
      await ApiSpCodeHandler.handle(code: code, response: response);
      handler.resolve(response);
    } else {
      handler.reject(error);
    }
  };
}
