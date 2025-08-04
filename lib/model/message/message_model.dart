import 'package:json2dart_safe/json2dart.dart';

class MessageModel {
  String? content;
  String? createdAt;
  List<String>? imgs;
  int? msgId;
  int? msgType;
  QuoteModel? quote;
  String? sendLogo;
  String? sendNickName;
  int? sendUserId;
  String? toLogo;
  String? toNickName;
  int? toUserId;
  int? vipType;

  MessageModel({
    this.content,
    this.createdAt,
    this.imgs,
    this.msgId,
    this.msgType,
    this.quote,
    this.sendLogo,
    this.sendNickName,
    this.sendUserId,
    this.toLogo,
    this.toNickName,
    this.toUserId,
    this.vipType,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json.asString('content');
    createdAt = json.asString('createdAt');
    imgs = json.asList<String>('imgs') ?? [];
    msgId = json.asInt('msgId');
    msgType = json.asInt('msgType');
    quote = json.asBean(
        'quote', (v) => QuoteModel.fromJson(Map<String, dynamic>.from(v)));
    sendLogo = json.asString('sendLogo');
    sendNickName = json.asString('sendNickName');
    sendUserId = json.asInt('sendUserId');
    toLogo = json.asString('toLogo');
    toNickName = json.asString('toNickName');
    toUserId = json.asInt('toUserId');
    vipType = json.asInt('vipType');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('content', content)
      ..put('createdAt', createdAt)
      ..put('imgs', imgs)
      ..put('msgId', msgId)
      ..put('msgType', msgType)
      ..put('quote', quote?.toJson())
      ..put('sendLogo', sendLogo)
      ..put('sendNickName', sendNickName)
      ..put('sendUserId', sendUserId)
      ..put('toLogo', toLogo)
      ..put('toNickName', toNickName)
      ..put('toUserId', toUserId)
      ..put('vipType', vipType);
  }

  static MessageModel toBean(Map<String, dynamic> json) =>
      MessageModel.fromJson(json);
}

class QuoteModel {
  String? content;
  List<String>? imgs;
  int? msgType;
  String? sendNickName;
  int? sendUserId;

  QuoteModel({
    this.content,
    this.imgs,
    this.msgType,
    this.sendNickName,
    this.sendUserId,
  });

  QuoteModel.fromJson(Map<String, dynamic> json) {
    content = json.asString('content');
    imgs = json.asList<String>('imgs') ?? [];
    msgType = json.asInt('msgType');
    sendNickName = json.asString('sendNickName');
    sendUserId = json.asInt('sendUserId');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('content', content)
      ..put('imgs', imgs)
      ..put('msgType', msgType)
      ..put('sendNickName', sendNickName)
      ..put('sendUserId', sendUserId);
  }

  static QuoteModel toBean(Map<String, dynamic> json) =>
      QuoteModel.fromJson(json);
}
