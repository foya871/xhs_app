/*
 * @Author: wangdazhuang
 * @Date: 2024-07-19 09:07:00
 * @LastEditTime: 2025-06-12 10:55:52
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/base_repsponse_model.dart
 */

import 'package:json2dart_safe/json2dart.dart';

import 'api_code.dart';

class BaseRespModel<T> {
  int? code;
  String? msg;
  T? data;

  BaseRespModel({this.code, this.data, this.msg});
  BaseRespModel.empty() : this.fromJson({});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('code', this.code)
      ..put('msg', this.msg)
      ..put('data', this.data);
  }

  BaseRespModel.fromJson(Map<String, dynamic> json)
      : code = json.asInt('code'),
        msg = json.asString('msg'),
        data = json["data"] ?? {};

  static dynamic toBean(dynamic json) => BaseRespModel.fromJson(json);
  bool get success => code == ApiCode.ok;
}
