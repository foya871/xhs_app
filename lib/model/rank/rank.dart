/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-29 11:37:45
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-09-10 19:44:28
 * @FilePath: /xhs_app/lib/src/model/rank/rank.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:json2dart_safe/json2dart.dart';

class RankModel {
  String? area;
  int? bu;
  String? bust;
  int? gender;
  bool? isAttention;
  String? logo;
  String? nickName;
  int? playNum;
  int? rechargeTotal;
  int? upType;
  int? userId;
  int? workNum;
  int? likeNum;

  RankModel(
      {this.area,
      this.bu,
      this.bust,
      this.gender,
      this.isAttention,
      this.logo,
      this.nickName,
      this.playNum,
      this.rechargeTotal,
      this.upType,
      this.userId,
      this.workNum,
      this.likeNum});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('area', this.area)
      ..put('bu', this.bu)
      ..put('bust', this.bust)
      ..put('gender', this.gender)
      ..put('isAttention', this.isAttention)
      ..put('logo', this.logo)
      ..put('nickName', this.nickName)
      ..put('playNum', this.playNum)
      ..put('rechargeTotal', this.rechargeTotal)
      ..put('upType', this.upType)
      ..put('userId', this.userId)
      ..put('workNum', this.workNum)
      ..put('likeNum', this.likeNum);
  }

  RankModel.fromJson(Map<String, dynamic> json) {
    this.area = json.asString('area');
    this.bu = json.asInt('bu');
    this.bust = json.asString('bust');
    this.gender = json.asInt('gender');
    this.isAttention = json.asBool('isAttention');
    this.logo = json.asString('logo');
    this.nickName = json.asString('nickName');
    this.playNum = json.asInt('playNum');
    this.rechargeTotal = json.asInt('rechargeTotal');
    this.upType = json.asInt('upType');
    this.userId = json.asInt('userId');
    this.workNum = json.asInt('workNum');
    this.likeNum = json.asInt('likeNum');
  }

  static RankModel toBean(Map<String, dynamic> json) =>
      RankModel.fromJson(json);
}
