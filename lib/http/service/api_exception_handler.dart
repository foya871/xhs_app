/*
 * @Author: wangdazhuang
 * @Date: 2024-10-19 09:54:20
 * @LastEditTime: 2025-06-12 20:37:48
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/api_exception_handler.dart
 */
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../components/diolog/dialog.dart';
import '../../utils/logger.dart';
import 'api_const.dart';
import 'api_sp_code.dart';
import 'api_sp_code_handler.dart';
import 'base_repsponse_model.dart';

/// catch到的exception处理
abstract class ApiExceptionHandler {
////处理异常
  static BaseRespModel transformExc(DioException e) {
    final response = e.response;
    if (response == null) {
      return BaseRespModel.fromJson(
        Map<String, dynamic>.from(
          {'code': 500, 'msg': 'no response'},
        ),
      );
    }
    _debugPrintError(e);
    final code = response.statusCode ?? 400;
    BaseRespModel model = BaseRespModel.fromJson({});
    var data = response.data;
    data ??= Map<String, dynamic>.from({'code': 400, "msg": e.message ?? ''});
    if (data is BaseRespModel) {
      model = data;
    } else if (data is Map) {
      model = BaseRespModel.fromJson(Map<String, dynamic>.from(data));
    }
    final innerCode = model.code ?? 200;

    ///处理特殊业务码
    if (ApiConst.spCodes.contains(code)) {
      ApiSpCodeHandler.handle(code: code, response: response);
    }
    if (ApiConst.spCodes.contains(innerCode)) {
      ApiSpCodeHandler.handle(code: innerCode, response: response);
    }
    return model;
  }

  ///错误打印
  static void _debugPrintError(DioException e) {
    final response = e.response!;
    final pathQuery = <String>[];
    pathQuery.add(response.realUri.path);
    if (response.realUri.hasQuery) pathQuery.add(response.realUri.query);
    final code = response.statusCode ?? 400;
    var json = response.data;
    var msg = '';
    if (json is BaseRespModel) {
      msg = json.msg ?? '';
    } else if (json is Map) {
      msg = json["msg"] ?? '';
    } else {
      msg = e.message ?? '';
    }
    if (msg.isNotEmpty &&
        !ApiConst.spCodes.contains(code) &&
        code != ApiSpCodeEnum.refreshToken) {
      showToast(msg);
    }
    logger.d(
        "${pathQuery.join('?')}>>>>statusCode>>>>$code>>>businessError>>${response.requestOptions.data}\n${const JsonEncoder.withIndent('  ').convert(json)}");
  }
}
