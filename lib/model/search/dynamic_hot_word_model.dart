import 'package:json2dart_safe/json2dart.dart';

class DynamicHotWordModel{
  int? dynamicId;
  int? dynamicType;
  String? userId;
  String? title;
  String? contentText;
  String? images;
  String? video;
  String? imgNum;
  String? playTime;
  bool? isLike;
  bool? isFavorite;
  int? fakeLikes;
  int? fakeFavorites;
  int? fakeWatchTimes;
  int? commentNum;
  String? nickName;
  String? logo;
  int? gender;
  int? vipType;
  bool? blogger;
  bool? topDynamic;
  bool? featured;
  int? status;
  String? notPass;
  bool? isAttention;
  int? bu;
  String? jumpType;
  String? jumpUrl;
  String? checkAt;
  int? dynamicMark;
  int? price;
  String? classifyTitle;
  String? topic;
  String? collectionName;
  bool? exclusiveToFans;

  DynamicHotWordModel({this.dynamicId,this.dynamicType,this.userId,this.title,this.contentText,this.images,this.video,this.imgNum,this.playTime,this.isLike,this.isFavorite,this.fakeLikes,this.fakeFavorites,this.fakeWatchTimes,this.commentNum,this.nickName,this.logo,this.gender,this.vipType,this.blogger,this.topDynamic,this.featured,this.status,this.notPass,this.isAttention,this.bu,this.jumpType,this.jumpUrl,this.checkAt,this.dynamicMark,this.price,this.classifyTitle,this.topic,this.collectionName,this.exclusiveToFans,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('dynamicId',this.dynamicId)
      ..put('dynamicType',this.dynamicType)
      ..put('userId',this.userId)
      ..put('title',this.title)
      ..put('contentText',this.contentText)
      ..put('images',this.images)
      ..put('video',this.video)
      ..put('imgNum',this.imgNum)
      ..put('playTime',this.playTime)
      ..put('isLike',this.isLike)
      ..put('isFavorite',this.isFavorite)
      ..put('fakeLikes',this.fakeLikes)
      ..put('fakeFavorites',this.fakeFavorites)
      ..put('fakeWatchTimes',this.fakeWatchTimes)
      ..put('commentNum',this.commentNum)
      ..put('nickName',this.nickName)
      ..put('logo',this.logo)
      ..put('gender',this.gender)
      ..put('vipType',this.vipType)
      ..put('blogger',this.blogger)
      ..put('topDynamic',this.topDynamic)
      ..put('featured',this.featured)
      ..put('status',this.status)
      ..put('notPass',this.notPass)
      ..put('isAttention',this.isAttention)
      ..put('bu',this.bu)
      ..put('jumpType',this.jumpType)
      ..put('jumpUrl',this.jumpUrl)
      ..put('checkAt',this.checkAt)
      ..put('dynamicMark',this.dynamicMark)
      ..put('price',this.price)
      ..put('classifyTitle',this.classifyTitle)
      ..put('topic',this.topic)
      ..put('collectionName',this.collectionName)
      ..put('exclusiveToFans',this.exclusiveToFans);
  }

  DynamicHotWordModel.fromJson(Map<String, dynamic> json) {
    this.dynamicId=json.asInt('dynamicId');
    this.dynamicType=json.asInt('dynamicType');
    this.userId=json.asString('userId');
    this.title=json.asString('title');
    this.contentText=json.asString('contentText');
    this.images=json.asString('images');
    this.video=json.asString('video');
    this.imgNum=json.asString('imgNum');
    this.playTime=json.asString('playTime');
    this.isLike=json.asBool('isLike');
    this.isFavorite=json.asBool('isFavorite');
    this.fakeLikes=json.asInt('fakeLikes');
    this.fakeFavorites=json.asInt('fakeFavorites');
    this.fakeWatchTimes=json.asInt('fakeWatchTimes');
    this.commentNum=json.asInt('commentNum');
    this.nickName=json.asString('nickName');
    this.logo=json.asString('logo');
    this.gender=json.asInt('gender');
    this.vipType=json.asInt('vipType');
    this.blogger=json.asBool('blogger');
    this.topDynamic=json.asBool('topDynamic');
    this.featured=json.asBool('featured');
    this.status=json.asInt('status');
    this.notPass=json.asString('notPass');
    this.isAttention=json.asBool('isAttention');
    this.bu=json.asInt('bu');
    this.jumpType=json.asString('jumpType');
    this.jumpUrl=json.asString('jumpUrl');
    this.checkAt=json.asString('checkAt');
    this.dynamicMark=json.asInt('dynamicMark');
    this.price=json.asInt('price');
    this.classifyTitle=json.asString('classifyTitle');
    this.topic=json.asString('topic');
    this.collectionName=json.asString('collectionName');
    this.exclusiveToFans=json.asBool('exclusiveToFans');
  }

  static DynamicHotWordModel toBean(Map<String, dynamic> json) => DynamicHotWordModel.fromJson(json);
}