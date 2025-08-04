/*
 * @Author: wangdazhuang
 * @Date: 2024-10-19 09:35:46
 * @LastEditTime: 2025-06-18 19:16:52
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /xhs_app/lib/http/service/api_response_interceptor.dart
 */

import 'package:dio/dio.dart';
import 'api_code.dart';
import 'base_repsponse_model.dart';
import 'api_decrypt.dart';

/// 响应拦截器
abstract class ApiResponseInterceptor {
  static const _http400Code = 400;

  ///http码非200
  static void _statusCodeNot200(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode!;
    final request = response.requestOptions;
    final data = response.data ?? {};
    handler.reject(
      DioException.badResponse(
        statusCode: statusCode,
        requestOptions: request,
        response: Response(
          statusCode: statusCode,
          requestOptions: request,
          data: data,
        ),
      ),
    );
  }

  static void Function(Response<dynamic>, ResponseInterceptorHandler)?
      onResponse = (response, handler) {
    assert(response.statusCode != null, 'http statusCode must not be null!');
    final request = response.requestOptions;
    int statusCode = response.statusCode!;
    //处理http状态码非200的情况
    if (statusCode != ApiCode.ok) {
      _statusCodeNot200(response, handler);
      return;
    }
    //数据异常 data不存在或者没按照标准返回
    var data = response.data;
    if (data is Map == false) {
      handler.reject(
        DioException(
          requestOptions: request,
          message: "response data doese not exsit",
        ),
      );
      return;
    }
    //业务层状态码非200

    assert(data.keys.contains("code") == true, "response must contain code");
    final code = data["code"];
    if (code != 200) {
      /// 作为异常抛出
      handler.reject(
        DioException.badResponse(
          statusCode: _http400Code,
          requestOptions: request,
          response: Response(
            statusCode: _http400Code,
            data: data,
            requestOptions: request,
          ),
        ),
      );
      return;
    }
    //成功的情况 statusCode == 200  && {code:200,data:xxx,msg:'success'}
    if (data.containsKey("encData")) {
      final {"encData": v} = data;
      final resultData = ApiDecrypt.decrypt(v);
      data.remove("encData");
      data["data"] = resultData;
    }
    handler.resolve(
        Response(requestOptions: request, data: BaseRespModel.fromJson(data)));
  };
}
