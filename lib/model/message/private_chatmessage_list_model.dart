import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/model/message/chat_message_xhs_model.dart';

class PrivateChatmessageListModel{
  bool? attention;
  List<ChatMessageXhsModel>? data;
  String? domain;

  PrivateChatmessageListModel({this.attention,this.data,this.domain,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('attention',this.attention)
      ..put('data', this.data?.map((v)=>v.toJson()).toList())
      ..put('domain',this.domain);
  }

  PrivateChatmessageListModel.fromJson(Map<String, dynamic> json) {
    this.attention=json.asBool('attention');
    this.data=json.asList<ChatMessageXhsModel>('data',(v)=>ChatMessageXhsModel.fromJson(Map<String, dynamic>.from(v)));
    this.domain=json.asString('domain');
  }

  static PrivateChatmessageListModel toBean(Map<String, dynamic> json) => PrivateChatmessageListModel.fromJson(json);
}