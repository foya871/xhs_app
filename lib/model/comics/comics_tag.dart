import 'package:json2dart_safe/json2dart.dart';

class ComicsTagModel {
  String? createdAt;
  String? id;
  int? sortNum;
  int? status;
  int? tagId;
  String? title;
  String? updatedAt;

  ComicsTagModel({
    this.createdAt,
    this.id,
    this.sortNum,
    this.status,
    this.tagId,
    this.title,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('createdAt', this.createdAt)
      ..put('id', this.id)
      ..put('sortNum', this.sortNum)
      ..put('status', this.status)
      ..put('tagId', this.tagId)
      ..put('title', this.title)
      ..put('updatedAt', this.updatedAt);
  }

  ComicsTagModel.fromJson(Map<String, dynamic> json) {
    this.createdAt = json.asString('createdAt');
    this.id = json.asString('id');
    this.sortNum = json.asInt('sortNum');
    this.status = json.asInt('status');
    this.tagId = json.asInt('tagId');
    this.title = json.asString('title');
    this.updatedAt = json.asString('updatedAt');
  }

  static ComicsTagModel toBean(Map<String, dynamic> json) =>
      ComicsTagModel.fromJson(json);
}
