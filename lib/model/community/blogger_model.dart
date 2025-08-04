import 'package:json2dart_safe/json2dart.dart';

class BloggerModel {
  String? nickName;
  String? logo;
  int? userId;
  bool? isAttention;

  BloggerModel({
    this.nickName,
    this.logo,
    this.userId,
    this.isAttention,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('nickName', nickName)
      ..put('logo', logo)
      ..put('userId', userId)
      ..put('isAttention', isAttention);
  }

  BloggerModel.fromJson(Map<String, dynamic> json) {
    nickName = json.asString('nickName');
    logo = json.asString('logo');
    userId = json.asInt('userId');
    isAttention = json.asBool('isAttention');
  }

  static BloggerModel toBean(dynamic json) => BloggerModel.fromJson(json);
}
