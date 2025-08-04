import 'package:json2dart_safe/json2dart.dart';

class RecommendUserModel {
  final int bu;
  bool isAttention;
  final String lastDynDate;
  final String logo;
  final String nickName;
  final int userId;
  final int workNum;

  void onToggleAttentionSuccess() {
    isAttention = !isAttention;
  }

  RecommendUserModel.fromJson(Map<String, dynamic> json)
      : bu = json.asInt('bu'),
        isAttention = json.asBool('isAttention'),
        lastDynDate = json.asString('lastDynDate'),
        logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        userId = json.asInt('userId'),
        workNum = json.asInt('workNum');

  static dynamic toBean(dynamic json) => RecommendUserModel.fromJson(json);
}
