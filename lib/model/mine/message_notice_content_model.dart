import 'package:json2dart_safe/json2dart.dart';

class MessageNoticeContentModel{
  int? commentId;
  int? consumerUserId;
  String? content;
  String? createdAt;
  int? gold;
  int? informationType;
  bool? isAttention;
  bool? isLike;
  String? msgActionDesc;
  int? producerIdentity;
  String? producerLogo;
  String? producerName;
  int? producerUserId;
  QuoteMsg? quoteMsg;
  int? ticketType;
  String? updatedAt;

  MessageNoticeContentModel({this.commentId,this.consumerUserId,this.content,this.createdAt,this.gold,this.informationType,this.isAttention,this.isLike,this.msgActionDesc,this.producerIdentity,this.producerLogo,this.producerName,this.producerUserId,this.quoteMsg,this.ticketType,this.updatedAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('commentId',this.commentId)
      ..put('consumerUserId',this.consumerUserId)
      ..put('content',this.content)
      ..put('createdAt',this.createdAt)
      ..put('gold',this.gold)
      ..put('informationType',this.informationType)
      ..put('isAttention',this.isAttention)
      ..put('isLike',this.isLike)
      ..put('msgActionDesc',this.msgActionDesc)
      ..put('producerIdentity',this.producerIdentity)
      ..put('producerLogo',this.producerLogo)
      ..put('producerName',this.producerName)
      ..put('producerUserId',this.producerUserId)
      ..put('quoteMsg',this.quoteMsg?.toJson())
      ..put('ticketType',this.ticketType)
      ..put('updatedAt',this.updatedAt);
  }

  MessageNoticeContentModel.fromJson(Map<String, dynamic> json) {
    this.commentId=json.asInt('commentId');
    this.consumerUserId=json.asInt('consumerUserId');
    this.content=json.asString('content');
    this.createdAt=json.asString('createdAt');
    this.gold=json.asInt('gold');
    this.informationType=json.asInt('informationType');
    this.isAttention=json.asBool('isAttention');
    this.isLike=json.asBool('isLike');
    this.msgActionDesc=json.asString('msgActionDesc');
    this.producerIdentity=json.asInt('producerIdentity');
    this.producerLogo=json.asString('producerLogo');
    this.producerName=json.asString('producerName');
    this.producerUserId=json.asInt('producerUserId');
    this.quoteMsg=json.asBean('quoteMsg',(v)=>QuoteMsg.fromJson(Map<String, dynamic>.from(v)));
    this.ticketType=json.asInt('ticketType');
    this.updatedAt=json.asString('updatedAt');
  }

  static MessageNoticeContentModel toBean(Map<String, dynamic> json) => MessageNoticeContentModel.fromJson(json);
}

class QuoteMsg{
  String? quoteSubContent;
  int? quoteSubId;
  String? quoteSubImg;
  int? quoteSubImgType;
  int? quoteSubLinkType;
  int? quoteSubType;

  QuoteMsg({this.quoteSubContent,this.quoteSubId,this.quoteSubImg,this.quoteSubImgType,this.quoteSubLinkType,this.quoteSubType,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('quoteSubContent',this.quoteSubContent)
      ..put('quoteSubId',this.quoteSubId)
      ..put('quoteSubImg',this.quoteSubImg)
      ..put('quoteSubImgType',this.quoteSubImgType)
      ..put('quoteSubLinkType',this.quoteSubLinkType)
      ..put('quoteSubType',this.quoteSubType);
  }

  QuoteMsg.fromJson(Map<String, dynamic> json) {
    this.quoteSubContent=json.asString('quoteSubContent');
    this.quoteSubId=json.asInt('quoteSubId');
    this.quoteSubImg=json.asString('quoteSubImg');
    this.quoteSubImgType=json.asInt('quoteSubImgType');
    this.quoteSubLinkType=json.asInt('quoteSubLinkType');
    this.quoteSubType=json.asInt('quoteSubType');
  }
}