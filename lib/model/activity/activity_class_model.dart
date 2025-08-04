import 'package:json2dart_safe/json2dart.dart';

class ActivityClassModel{
  String? id;
  int? stationId;
  String? createdAt;
  String? updatedAt;
  String? name;
  int? sortNum;
  int? type;

  ActivityClassModel({this.id,this.stationId,this.createdAt,this.updatedAt,this.name,this.sortNum,this.type,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id',this.id)
      ..put('stationId',this.stationId)
      ..put('createdAt',this.createdAt)
      ..put('updatedAt',this.updatedAt)
      ..put('name',this.name)
      ..put('sortNum',this.sortNum)
      ..put('type',this.type);
  }

  ActivityClassModel.fromJson(Map<String, dynamic> json) {
    this.id=json.asString('id');
    this.stationId=json.asInt('stationId');
    this.createdAt=json.asString('createdAt');
    this.updatedAt=json.asString('updatedAt');
    this.name=json.asString('name');
    this.sortNum=json.asInt('sortNum');
    this.type=json.asInt('type');
  }

  static ActivityClassModel toBean(Map<String, dynamic> json) => ActivityClassModel.fromJson(json);
}