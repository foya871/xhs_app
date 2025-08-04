/*
 * @Author: wangdazhuang
 * @Date: 2024-10-16 14:05:57
 * @LastEditTime: 2025-06-12 11:39:09
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/api_sp_code.dart
 */
typedef ApiSpCode = int;

abstract class ApiSpCodeEnum {
  ///刷新token
  static const ApiSpCode refreshToken = 301;

  ///重新登录
  static const ApiSpCode reLogin = 302;

  ///token解析错误
  static const ApiSpCode tokenError = 1001;

  ///用户封禁
  static const ApiSpCode accForbidden = 1002;

  ///用户不存在
  // ignore: constant_identifier_names
  static const ApiSpCode user_not_exsit = 1003;
}
