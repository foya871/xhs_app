import 'package:json2dart_safe/json2dart.dart';

class ServiceMessageModel {
  String? createdAt;
  String? id;
  String? images;
  String? info;
  String? logo;
  String? nickName;
  bool? status;
  String? title;
  String? topicId;
  String? topicName;
  int? type;
  String? updatedAt;
  int? userId;

  ServiceMessageModel(
      {this.createdAt,
      this.id,
      this.images,
      this.info,
      this.logo,
      this.nickName,
      this.status,
      this.title,
      this.topicId,
      this.topicName,
      this.type,
      this.updatedAt,
      this.userId});

  ServiceMessageModel.fromJson(Map<String, dynamic> json) {
    createdAt = json.asString('createdAt');
    id = json.asString('id');
    images = json.asString('images');
    info = json.asString('info');
    logo = json.asString('logo');
    nickName = json.asString('nickName');
    status = json.asBool('status');
    title = json.asString('title');
    topicId = json.asString('topicId');
    topicName = json.asString('topicName');
    type = json.asInt('type');
    updatedAt = json.asString('updatedAt');
    userId = json.asInt('userId');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('createdAt', createdAt)
      ..put('id', id)
      ..put('images', images)
      ..put('info', info)
      ..put('logo', logo)
      ..put('nickName', nickName)
      ..put('status', status)
      ..put('title', title)
      ..put('topicId', topicId)
      ..put('topicName', topicName)
      ..put('type', type)
      ..put('updatedAt', updatedAt)
      ..put('userId', userId);
  }

  static ServiceMessageModel toBean(Map<String, dynamic> json) =>
      ServiceMessageModel.fromJson(json);
}
