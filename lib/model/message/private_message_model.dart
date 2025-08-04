import 'package:json2dart_safe/json2dart.dart';

class PrivateMessageModel {
  String? logo;
  String? newMessage;
  String? newMessageDate;
  String? nickName;
  int? noReadNum;
  bool? online;
  int? userId;

  PrivateMessageModel(
      {this.logo,
      this.newMessage,
      this.newMessageDate,
      this.nickName,
      this.noReadNum,
      this.online,
      this.userId});

  PrivateMessageModel.fromJson(Map<String, dynamic> json) {
    logo = json.asString('logo');
    newMessage = json.asString('newMessage');
    newMessageDate = json.asString('newMessageDate');
    nickName = json.asString('nickName');
    noReadNum = json.asInt('noReadNum');
    online = json.asBool('online');
    userId = json.asInt('userId');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('logo', logo)
      ..put('newMessage', newMessage)
      ..put('newMessageDate', newMessageDate)
      ..put('nickName', nickName)
      ..put('noReadNum', noReadNum)
      ..put('online', online)
      ..put('userId', userId);
  }

  static PrivateMessageModel toBean(Map<String, dynamic> json) =>
      PrivateMessageModel.fromJson(json);
}
