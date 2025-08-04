import 'package:json2dart_safe/json2dart.dart';

class ChatListMessageModel{
  String? logo;
  String? newMessage;
  String? newMessageDate;
  String? nickName;
  int? noReadNum;
  int? userId;

  ChatListMessageModel({this.logo,this.newMessage,this.newMessageDate,this.nickName,this.noReadNum,this.userId,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('logo',this.logo)
      ..put('newMessage',this.newMessage)
      ..put('newMessageDate',this.newMessageDate)
      ..put('nickName',this.nickName)
      ..put('noReadNum',this.noReadNum)
      ..put('userId',this.userId);
  }

  ChatListMessageModel.fromJson(Map<String, dynamic> json) {
    this.logo=json.asString('logo');
    this.newMessage=json.asString('newMessage');
    this.newMessageDate=json.asString('newMessageDate');
    this.nickName=json.asString('nickName');
    this.noReadNum=json.asInt('noReadNum');
    this.userId=json.asInt('userId');
  }

  static ChatListMessageModel toBean(Map<String, dynamic> json) => ChatListMessageModel.fromJson(json);
}