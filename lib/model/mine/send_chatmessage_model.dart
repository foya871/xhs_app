import 'package:json2dart_safe/json2dart.dart';

class SendChatmessageModel{
  String? content;
  List<String>? imgs;
  int? toUserId;
  int? roomId;

  SendChatmessageModel({this.content,this.imgs,this.toUserId,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('content',this.content)
      ..put('imgs',this.imgs)
      ..put('toUserId',this.toUserId)
      ..put('roomId',this.roomId);
  }

  SendChatmessageModel.fromJson(Map<String, dynamic> json) {
    this.content=json.asString('content');
    this.imgs=json.asList<String>('imgs',null);
    this.toUserId=json.asInt('toUserId');
    this.roomId=json.asInt('roomId');
  }

  static SendChatmessageModel toBean(Map<String, dynamic> json) => SendChatmessageModel.fromJson(json);
}