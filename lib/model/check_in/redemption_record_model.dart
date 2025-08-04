import 'package:json2dart_safe/json2dart.dart';

class RedemptionRecordModel{
  String? createdAt;
  String? desc;
  String? id;
  int? integral;
  int? prizeId;
  int? sendNum;
  bool? sendStatus;
  int? type;
  String? updatedAt;
  int? userId;

  RedemptionRecordModel({this.createdAt,this.desc,this.id,this.integral,this.prizeId,this.sendNum,this.sendStatus,this.type,this.updatedAt,this.userId,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('createdAt',this.createdAt)
      ..put('desc',this.desc)
      ..put('id',this.id)
      ..put('integral',this.integral)
      ..put('prizeId',this.prizeId)
      ..put('sendNum',this.sendNum)
      ..put('sendStatus',this.sendStatus)
      ..put('type',this.type)
      ..put('updatedAt',this.updatedAt)
      ..put('userId',this.userId);
  }

  RedemptionRecordModel.fromJson(Map<String, dynamic> json) {
    this.createdAt=json.asString('createdAt');
    this.desc=json.asString('desc');
    this.id=json.asString('id');
    this.integral=json.asInt('integral');
    this.prizeId=json.asInt('prizeId');
    this.sendNum=json.asInt('sendNum');
    this.sendStatus=json.asBool('sendStatus');
    this.type=json.asInt('type');
    this.updatedAt=json.asString('updatedAt');
    this.userId=json.asInt('userId');
  }

  static RedemptionRecordModel toBean(Map<String, dynamic> json) => RedemptionRecordModel.fromJson(json);
}