import 'package:json2dart_safe/json2dart.dart';

import '../../utils/enum.dart';

/// 博主
class BloggerModel {
  final String area;
  final int bu;
  final String bust;
  final UserGenderType gender;
  final bool isAttention;
  final String logo;
  final String nickName;
  final int playNum;
  final int userId;
  final int workNum;

  BloggerModel.empty() : this.fromJson({});

  BloggerModel.fromJson(Map<String, dynamic> json)
      : area = json.asString('area'),
        bu = json.asInt('bu'),
        bust = json.asString('bust'),
        gender = json.asInt('gender', UserGenderTypeEnum.none),
        isAttention = json.asBool('isAttention'),
        logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        playNum = json.asInt('playNum'),
        userId = json.asInt('userId'),
        workNum = json.asInt('workNum');

  static dynamic toBean(dynamic json) => BloggerModel.fromJson(json);
}
