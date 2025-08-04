import 'package:json2dart_safe/json2dart.dart';

class GroupChatroomModel{
  String? info;
  bool? join;
  String? logo;
  int? maximumNum;
  String? nickName;
  bool? official;
  int? roomId;
  String? roomLogo;
  String? roomName;
  int? roomTotalNum;
  int? userId;

  GroupChatroomModel({this.info,this.join,this.logo,this.maximumNum,this.nickName,this.official,this.roomId,this.roomLogo,this.roomName,this.roomTotalNum,this.userId,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('info',this.info)
      ..put('join',this.join)
      ..put('logo',this.logo)
      ..put('maximumNum',this.maximumNum)
      ..put('nickName',this.nickName)
      ..put('official',this.official)
      ..put('roomId',this.roomId)
      ..put('roomLogo',this.roomLogo)
      ..put('roomName',this.roomName)
      ..put('roomTotalNum',this.roomTotalNum)
      ..put('userId',this.userId);
  }

  GroupChatroomModel.fromJson(Map<String, dynamic> json) {
    this.info=json.asString('info');
    this.join=json.asBool('join');
    this.logo=json.asString('logo');
    this.maximumNum=json.asInt('maximumNum');
    this.nickName=json.asString('nickName');
    this.official=json.asBool('official');
    this.roomId=json.asInt('roomId');
    this.roomLogo=json.asString('roomLogo');
    this.roomName=json.asString('roomName');
    this.roomTotalNum=json.asInt('roomTotalNum');
    this.userId=json.asInt('userId');
  }

  static GroupChatroomModel toBean(Map<String, dynamic> json) => GroupChatroomModel.fromJson(json);
}