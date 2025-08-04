import 'package:json2dart_safe/json2dart.dart';

class ResourceReport{
  String? id;
  int? userId;
  String? nickName;
  bool? blogger;
  String? logo;
  int? gender;
  int? vipType;
  int? resourcesId;
  String? resourcesTitle;
  int? reason;
  String? remark;
  String? website;
  String? extractionCode;
  int? status;
  String? bgUserId;
  String? bgUserName;
  String? processTime;
  String? result;
  String? createdAt;
  String? updatedAt;

  ResourceReport({this.id,this.userId,this.nickName,this.blogger,this.logo,this.gender,this.vipType,this.resourcesId,this.resourcesTitle,this.reason,this.remark,this.website,this.extractionCode,this.status,this.bgUserId,this.bgUserName,this.processTime,this.result,this.createdAt,this.updatedAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id',this.id)
      ..put('userId',this.userId)
      ..put('nickName',this.nickName)
      ..put('blogger',this.blogger)
      ..put('logo',this.logo)
      ..put('gender',this.gender)
      ..put('vipType',this.vipType)
      ..put('resourcesId',this.resourcesId)
      ..put('resourcesTitle',this.resourcesTitle)
      ..put('reason',this.reason)
      ..put('remark',this.remark)
      ..put('website',this.website)
      ..put('extractionCode',this.extractionCode)
      ..put('status',this.status)
      ..put('bgUserId',this.bgUserId)
      ..put('bgUserName',this.bgUserName)
      ..put('processTime',this.processTime)
      ..put('result',this.result)
      ..put('createdAt',this.createdAt)
      ..put('updatedAt',this.updatedAt);
  }

  ResourceReport.fromJson(Map<String, dynamic> json) {
    this.id=json.asString('id');
    this.userId=json.asInt('userId');
    this.nickName=json.asString('nickName');
    this.blogger=json.asBool('blogger');
    this.logo=json.asString('logo');
    this.gender=json.asInt('gender');
    this.vipType=json.asInt('vipType');
    this.resourcesId=json.asInt('resourcesId');
    this.resourcesTitle=json.asString('resourcesTitle');
    this.reason=json.asInt('reason');
    this.remark=json.asString('remark');
    this.website=json.asString('website');
    this.extractionCode=json.asString('extractionCode');
    this.status=json.asInt('status');
    this.bgUserId=json.asString('bgUserId');
    this.bgUserName=json.asString('bgUserName');
    this.processTime=json.asString('processTime');
    this.result=json.asString('result');
    this.createdAt=json.asString('createdAt');
    this.updatedAt=json.asString('updatedAt');
  }

  static ResourceReport toBean(Map<String, dynamic> json) => ResourceReport.fromJson(json);
}