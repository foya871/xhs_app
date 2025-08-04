import 'package:json2dart_safe/json2dart.dart';

class ChatMessageXhsModel{
  String? content;
  String? createdAt;
  List<String>? imgs;
  int? msgId;
  int? msgType;
  String? sendLogo;
  String? sendNickName;
  int? sendUserId;
  int? vipType;
  bool? showDate;

  ChatMessageXhsModel({this.content,this.createdAt,this.imgs,this.msgId,this.msgType,this.sendLogo,this.sendNickName,this.sendUserId,this.vipType,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('content',this.content)
      ..put('createdAt',this.createdAt)
      ..put('imgs',this.imgs)
      ..put('msgId',this.msgId)
      ..put('msgType',this.msgType)
      ..put('sendLogo',this.sendLogo)
      ..put('sendNickName',this.sendNickName)
      ..put('sendUserId',this.sendUserId)
      ..put('vipType',this.vipType)
      ..put('showDate',this.showDate);
  }

  ChatMessageXhsModel.fromJson(Map<String, dynamic> json) {
    this.content=json.asString('content');
    this.createdAt=json.asString('createdAt');
    this.imgs=json.asList<String>('imgs',null);
    this.msgId=json.asInt('msgId');
    this.msgType=json.asInt('msgType');
    this.sendLogo=json.asString('sendLogo');
    this.sendNickName=json.asString('sendNickName');
    this.sendUserId=json.asInt('sendUserId');
    this.vipType=json.asInt('vipType');
    this.showDate=json.asBool('showDate');
  }

  static ChatMessageXhsModel toBean(Map<String, dynamic> json) => ChatMessageXhsModel.fromJson(json);
}