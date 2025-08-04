import 'package:json2dart_safe/json2dart.dart';

class MineTabconfigsModel {
  String? createdAt;
  String? id;
  String? img;
  bool? status;
  int? type;
  String? updatedAt;

  MineTabconfigsModel({
    this.createdAt,
    this.id,
    this.img,
    this.status,
    this.type,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('createdAt', this.createdAt)
      ..put('id', this.id)
      ..put('img', this.img)
      ..put('status', this.status)
      ..put('type', this.type)
      ..put('updatedAt', this.updatedAt);
  }

  MineTabconfigsModel.fromJson(Map<String, dynamic> json) {
    this.createdAt = json.asString('createdAt');
    this.id = json.asString('id');
    this.img = json.asString('img');
    this.status = json.asBool('status');
    this.type = json.asInt('type');
    this.updatedAt = json.asString('updatedAt');
  }

  static MineTabconfigsModel toBean(Map<String, dynamic> json) =>
      MineTabconfigsModel.fromJson(json);
}
