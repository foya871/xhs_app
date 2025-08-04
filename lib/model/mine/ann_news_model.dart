import 'package:json2dart_safe/json2dart.dart';

class AnnNewsRespModel {
  int? annId;
  String? annJumpUrl;
  int? annPlatform;
  int? annType;
  String? appCenterUrl;
  String? buttonName;
  String? content;
  String? createdAt;
  String? creator;
  String? endTime;
  String? name;
  String? startTime;
  bool? status;
  String? updatedAt;

  AnnNewsRespModel({
    this.annId,
    this.annJumpUrl,
    this.annPlatform,
    this.annType,
    this.appCenterUrl,
    this.buttonName,
    this.content,
    this.createdAt,
    this.creator,
    this.endTime,
    this.name,
    this.startTime,
    this.status,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('annId', this.annId)
      ..put('annJumpUrl', this.annJumpUrl)
      ..put('annPlatform', this.annPlatform)
      ..put('annType', this.annType)
      ..put('appCenterUrl', this.appCenterUrl)
      ..put('buttonName', this.buttonName)
      ..put('content', this.content)
      ..put('createdAt', this.createdAt)
      ..put('creator', this.creator)
      ..put('endTime', this.endTime)
      ..put('name', this.name)
      ..put('startTime', this.startTime)
      ..put('status', this.status)
      ..put('updatedAt', this.updatedAt);
  }

  AnnNewsRespModel.fromJson(Map<String, dynamic> json) {
    this.annId = json.asInt('annId');
    this.annJumpUrl = json.asString('annJumpUrl');
    this.annPlatform = json.asInt('annPlatform');
    this.annType = json.asInt('annType');
    this.appCenterUrl = json.asString('appCenterUrl');
    this.buttonName = json.asString('buttonName');
    this.content = json.asString('content');
    this.createdAt = json.asString('createdAt');
    this.creator = json.asString('creator');
    this.endTime = json.asString('endTime');
    this.name = json.asString('name');
    this.startTime = json.asString('startTime');
    this.status = json.asBool('status');
    this.updatedAt = json.asString('updatedAt');
  }

  static AnnNewsRespModel toBean(Map<String, dynamic> json) =>
      AnnNewsRespModel.fromJson(json);
}
