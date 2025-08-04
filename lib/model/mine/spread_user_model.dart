/*
 * @Author: wangdazhuang
 * @Date: 2024-10-17 19:28:16
 * @LastEditTime: 2024-10-17 19:28:33
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/model/mine/spread_user_model.dart
 */
import 'package:json2dart_safe/json2dart.dart';

class SpreadUserModel {
  int? userId;
  String? nickName;
  String? createdAt;
  String? logo; 

  SpreadUserModel({
    this.userId,
    this.nickName,
    this.createdAt,
    this.logo,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('nickName', this.nickName)
      ..put('userId', this.userId)
      ..put('createdAt', this.createdAt)
      ..put('logo', this.logo);
  }

  SpreadUserModel.fromJson(Map<String, dynamic> json) {
    this.userId = json.asInt('userId');
    this.createdAt = json.asString('createdAt');
    this.nickName = json.asString('nickName');
    this.logo = json.asString('logo');
  }

  static SpreadUserModel toBean(Map<String, dynamic> json) =>
      SpreadUserModel.fromJson(json);
}
