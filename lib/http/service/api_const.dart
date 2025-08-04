/*
 * @Author: wangdazhuang
 * @Date: 2024-10-19 09:02:49
 * @LastEditTime: 2025-06-12 11:30:48
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/api_const.dart
 */
import 'package:get/get.dart';

import '../../generate/app_build_config.dart';
import '../../services/storage_service.dart';
import 'api_sp_code.dart';

abstract class ApiConst {
  static const kMutiplyFormPostContentType =
      "multipart/form-data;boundary=----------";

  static const kMutiplyPartFileContentType =
      "multipart/form-data;charset=UTF-8";

  static const kContentTypeApplicationJSON = "application/json;charset=UTF-8";

  static String kNativeDeviceUA =
      "${Get.find<StorageService>().deviceInfo ?? ''}/${AppBuildConfig.appName}/ver=${AppBuildConfig.appVersion}";

  static const spCodes = [
    ApiSpCodeEnum.refreshToken, //301应该是无感的不用去弹框
    ApiSpCodeEnum.reLogin, //302  重新登录
    ApiSpCodeEnum.tokenError, //1001
    ApiSpCodeEnum.accForbidden, //1002
    ApiSpCodeEnum.user_not_exsit //1003
  ];

  ///特殊状态码
  static Map<int, String> get spMaps => {
        ApiSpCodeEnum.refreshToken: 'token对应不到,请刷新',
        ApiSpCodeEnum.reLogin: '您的账号在异地登录，请重新登录您的账号',
        ApiSpCodeEnum.tokenError: 'token解析错误，请点击确定重新初始化',
        ApiSpCodeEnum.accForbidden: '您的账号被封禁，请联系管理员',
        ApiSpCodeEnum.user_not_exsit: '您的账户不存在或者账户被删除！',
      };
}
