/*
 * @Author: wangdazhuang
 * @Date: 2024-10-31 21:23:53
 * @LastEditTime: 2024-10-31 21:44:30
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /years_old_16/lib/src/http/api_error_code_wrap.dart
 */
import 'package:dio/dio.dart';

import 'base_repsponse_model.dart';

abstract class ApiErrorWrap {
  static int magicCode = -987654321;

  ////catch里的code转换
  static BaseRespModel<T> wrap<T>(dynamic e) {
    assert(e != null, 'error can not be null in catch statement!');
    int? code;
    String? msg;
    if (e is Map) {
      code = e['code'] as int?;
      msg = e['msg'] as String?;
    } else if (e is BaseRespModel) {
      code = e.code;
      msg = e.msg;
    } else if (e is DioException) {
      code = e.response?.statusCode;
      msg = e.message;
    } else {
      assert(false, 'unhandled http result exception.');
    }
    code ??= magicCode;
    return BaseRespModel(code: code, msg: msg);
  }
}
