import 'package:json2dart_safe/json2dart.dart';

class ProductClassifyModel{
  String? id;
  int? classifyId;
  String? classifyTitle;
  int? type;
  bool? appShow;
  int? sortNum;
  String? createdAt;
  String? updatedAt;

  ProductClassifyModel({this.id,this.classifyId,this.classifyTitle,this.type,this.appShow,this.sortNum,this.createdAt,this.updatedAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id',this.id)
      ..put('classifyId',this.classifyId)
      ..put('classifyTitle',this.classifyTitle)
      ..put('type',this.type)
      ..put('appShow',this.appShow)
      ..put('sortNum',this.sortNum)
      ..put('createdAt',this.createdAt)
      ..put('updatedAt',this.updatedAt);
  }

  ProductClassifyModel.fromJson(Map<String, dynamic> json) {
    this.id=json.asString('id');
    this.classifyId=json.asInt('classifyId');
    this.classifyTitle=json.asString('classifyTitle');
    this.type=json.asInt('type');
    this.appShow=json.asBool('appShow');
    this.sortNum=json.asInt('sortNum');
    this.createdAt=json.asString('createdAt');
    this.updatedAt=json.asString('updatedAt');
  }

  static ProductClassifyModel toBean(Map<String, dynamic> json) => ProductClassifyModel.fromJson(json);
}