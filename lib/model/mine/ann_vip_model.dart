import 'package:json2dart_safe/json2dart.dart';

class AnnVipModel {
  String? content;
  String? createdAt;
  String? id;
  bool? status;
  String? updatedAt;

  AnnVipModel({
    this.content,
    this.createdAt,
    this.id,
    this.status,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('content', this.content)
      ..put('createdAt', this.createdAt)
      ..put('id', this.id)
      ..put('status', this.status)
      ..put('updatedAt', this.updatedAt);
  }

  AnnVipModel.fromJson(Map<String, dynamic> json) {
    this.content = json.asString('content');
    this.createdAt = json.asString('createdAt');
    this.id = json.asString('id');
    this.status = json.asBool('status');
    this.updatedAt = json.asString('updatedAt');
  }

  static AnnVipModel toBean(Map<String, dynamic> json) =>
      AnnVipModel.fromJson(json);
}
