import 'package:json2dart_safe/json2dart.dart';

class BloggerBaseModel {
  int? userId;
  String? nickName;
  String? logo;
  String? cityName;
  String? distance;
  bool? online;
  String? longitude;
  String? latitude;

  int? chatVipType;

  BloggerBaseModel(
      {this.userId,
      this.nickName,
      this.logo,
      this.cityName,
      this.distance,
      this.online,
      this.longitude,
      this.latitude,
      this.chatVipType});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('userId', this.userId)
      ..put('nickName', this.nickName)
      ..put('logo', this.logo)
      ..put('cityName', this.cityName)
      ..put('distance', this.distance)
      ..put('online', this.online)
      ..put('longitude', this.longitude)
      ..put('latitude', this.latitude)
      ..put('vipType', this.chatVipType);
  }

  BloggerBaseModel.fromJson(Map<String, dynamic> json) {
    this.userId = json.asInt('userId');
    this.nickName = json.asString('nickName');
    this.logo = json.asString('logo');
    this.cityName = json.asString('cityName');
    this.distance = json.asString('distance');
    this.online = json.asBool('online');
    this.longitude = json.asString('longitude');
    this.latitude = json.asString('latitude');
    this.chatVipType = json.asInt("chatVipType");
  }

  static BloggerBaseModel toBean(Map<String, dynamic> json) =>
      BloggerBaseModel.fromJson(json);
}
