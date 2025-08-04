/*
 * @Author: wangdazhuang
 * @Date: 2024-10-19 09:53:01
 * @LastEditTime: 2025-06-12 10:58:28
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/api_response_transformer.dart
 */
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tuple/tuple.dart';
import '../../env/environment_service.dart';
import 'api_service.dart';
import 'base_repsponse_model.dart';

///响应处理
abstract class ApiResponseTransformer<T> {
  static String _sanitizeString(String input) {
    var runes = input.runes.where((r) =>
        r <= 0xFFFF || // BMP characters
        (r >= 0x10000 && r <= 0x10FFFF)); // Valid supplementary characters
    return String.fromCharCodes(runes);
  }

  ///响应处理
  static dynamic transform<T>(
    Response resp,
    JSON2ModelComplete<T>? complete,
    bool? requestEntireModel, {
    required String method,
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryMap,
  }) async {
    BaseRespModel result = resp.data;
    final json = result.data;
    // debugPrint("=========>数据json  $url  ${json}");
    final jsonStr = const JsonEncoder.withIndent('  ').convert(result.toJson());
    // final logStr = jsonStr.replaceAll(RegExp(r'[^\x00-\x7F]'), '');
    log("${Environment.kbaseAPI}$url>>$method>>${method == "GET" ? queryMap : body}>>response data:>>> \n${_sanitizeString(jsonStr)}");
    if (result.code != 200 || json == null) return null;
    if (complete == null) return json;
    //直接返回数组的情况
    if (json is List) {
      List arr = json;
      final models = await _json2Model<T>(Tuple2(arr, complete));
      return models;
    }
    //空json的情况
    if (Map.from(json).isEmpty) {
      return null;
    }
// {code:200,msg:success,data: {
// data:[...]}
// }
    bool hasarr = (json).containsKey("data") && json["data"] is List;

// {code:200,msg:success,data: {
// data:{....}}
// }

    bool hasdataJson = (json).containsKey("data") && json["data"] is Map;
    if (hasdataJson) {
      final v = Map<String, dynamic>.from(json["data"]);
      return await _json2Model<T>(Tuple2(v, complete));
    }
    if (hasarr && (requestEntireModel == null || requestEntireModel == false)) {
      List arr = json["data"];
      return await _json2Model<T>(Tuple2(arr, complete));
    }
    return await _json2Model<T>(Tuple2(json, complete));
  }

  ///json2model
  static Future _json2Model<T>(
      Tuple2<dynamic, JSON2ModelComplete<T>> transformer) async {
    assert(transformer.item1 != null, 'json2model source can not be null!');
    final element = transformer.item1;
    if (element == null) return null;
    JSON2ModelComplete<T> complete = transformer.item2;

    if (element is List) {
      final models = element.map((e) => complete(e)).toList();
      return models;
    }
    final model = complete(Map<String, dynamic>.from(element));
    return model;
  }
}
