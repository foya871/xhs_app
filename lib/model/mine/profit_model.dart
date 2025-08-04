import 'package:json2dart_safe/json2dart.dart';

class ProfitModel{
  String? createdAt;
  String? desc;
  int? gold;
  int? id;
  String? image;
  String? name;
  int? performance;

  ProfitModel({this.createdAt,this.desc,this.gold,this.id,this.image,this.name,this.performance,});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('createdAt',this.createdAt)
      ..put('desc',this.desc)
      ..put('gold',this.gold)
      ..put('id',this.id)
      ..put('image',this.image)
      ..put('name',this.name)
      ..put('performance',this.performance);
  }

ProfitModel.fromJson(Map<String, dynamic> json) {
    this.createdAt=json.asString('createdAt');
    this.desc=json.asString('desc');
    this.gold=json.asInt('gold');
    this.id=json.asInt('id');
    this.image=json.asString('image');
    this.name=json.asString('name');
    this.performance=json.asInt('performance');
  }

static ProfitModel toBean(Map<String, dynamic> json) => ProfitModel.fromJson(json);
}