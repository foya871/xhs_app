import 'package:json2dart_safe/json2dart.dart';

class SigninMissionModel {
  int? integral;
  String? missionDesc;
  int? missionId;
  String? missionLogo;
  String? missionName;

  /// "任务详细类型 (1-评论/回复; 2-分享邀请; 3-社区发帖; 4-首次充值; 5-购买金币视频; 6-签到; 10-兑换)"
  int? missionType;
  bool? single;

  /// 任务状态：1-未完成，2-未领取，3-已领取
  int? status;

  SigninMissionModel({
    this.integral,
    this.missionDesc,
    this.missionId,
    this.missionLogo,
    this.missionName,
    this.missionType,
    this.single,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('integral', integral)
      ..put('missionDesc', missionDesc)
      ..put('missionId', missionId)
      ..put('missionLogo', missionLogo)
      ..put('missionName', missionName)
      ..put('missionType', missionType)
      ..put('single', single)
      ..put('status', status);
  }

  SigninMissionModel.fromJson(Map<String, dynamic> json) {
    integral = json.asInt('integral');
    missionDesc = json.asString('missionDesc');
    missionId = json.asInt('missionId');
    missionLogo = json.asString('missionLogo');
    missionName = json.asString('missionName');
    missionType = json.asInt('missionType');
    single = json.asBool('single');
    status = json.asInt('status');
  }

  dynamic toBean(Map<String, dynamic> json) =>
      SigninMissionModel.fromJson(json);
}
