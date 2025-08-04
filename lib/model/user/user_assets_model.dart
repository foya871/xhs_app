/*
 * @Author: wangdazhuang
 * @Date: 2024-08-27 21:06:20
 * @LastEditTime: 2024-08-27 21:07:48
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/model/user/user_assets_model.dart
 */

import 'package:json2dart_safe/json2dart.dart';

class UseAssetsModel {
  double? bala;
  double? gold;

  UseAssetsModel({
    this.bala,
    this.gold,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('bala', this.bala)
      ..put('gold', this.gold);
  }

  UseAssetsModel.fromJson(Map<String, dynamic> json) {
    this.bala = json.asDouble('bala');
    this.gold = json.asDouble('gold');
  }

  static UseAssetsModel toBean(Map<String, dynamic> json) =>
      UseAssetsModel.fromJson(json);
}
