import 'package:json2dart_safe/json2dart.dart';

class GroupClassificationModel{
  String? id;
  String? name;
  bool check = false;

  GroupClassificationModel({this.id,this.name,required this.check});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id',this.id)
      ..put('check',this.check)
      ..put('name',this.name);
  }

  GroupClassificationModel.fromJson(Map<String, dynamic> json) {
    this.id=json.asString('id');
    this.name=json.asString('name');
    this.check=json.asBool('check');
  }

  static GroupClassificationModel toBean(Map<String, dynamic> json) => GroupClassificationModel.fromJson(json);
}