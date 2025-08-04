import 'package:json2dart_safe/json2dart.dart';

class FansClubModel{
  bool? expired;
  int? fansGroupNum;
  int? groupId;
  String? groupLogo;
  String? groupName;
  bool? isJoin;
  int? realFansGroupNum;
  int? ticketType;
  int? userId;

  FansClubModel({this.expired,this.fansGroupNum,this.groupId,this.groupLogo,this.groupName,this.isJoin,this.realFansGroupNum,this.ticketType,this.userId,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('expired',this.expired)
      ..put('fansGroupNum',this.fansGroupNum)
      ..put('groupId',this.groupId)
      ..put('groupLogo',this.groupLogo)
      ..put('groupName',this.groupName)
      ..put('isJoin',this.isJoin)
      ..put('realFansGroupNum',this.realFansGroupNum)
      ..put('ticketType',this.ticketType)
      ..put('userId',this.userId);
  }

FansClubModel.fromJson(Map<String, dynamic> json) {
    this.expired=json.asBool('expired');
    this.fansGroupNum=json.asInt('fansGroupNum');
    this.groupId=json.asInt('groupId');
    this.groupLogo=json.asString('groupLogo');
    this.groupName=json.asString('groupName');
    this.isJoin=json.asBool('isJoin');
    this.realFansGroupNum=json.asInt('realFansGroupNum');
    this.ticketType=json.asInt('ticketType');
    this.userId=json.asInt('userId');
  }

static FansClubModel toBean(Map<String, dynamic> json) => FansClubModel.fromJson(json);
}