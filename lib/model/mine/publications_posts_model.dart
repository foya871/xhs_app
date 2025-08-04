import 'package:json2dart_safe/json2dart.dart';

class PublicationsPostsModel {
  int? bu;
  String? checkAt;
  int? commentNum;
  String? contentText;
  int? dynamicId;
  int? dynamicMark;
  int? dynamicType;
  int? fakeFavorites;
  int? fakeLikes;
  int? fakeWatchTimes;
  int? gender;
  List<String>? images;
  List<String>? coverImg; //图片
  int? interactive;
  bool? isAttention;
  bool? isFavorite;
  bool? isLike;
  bool? isRecommend;
  String? logo;
  String? nickName;
  String? notPass;
  int? price;
  int? realFavorites;
  int? realLikes;
  int? realWatchTimes;
  int? status;
  String? title;
  bool? topDynamic;
  String? topic;
  int? userId;
  Video? video;
  int? vipType;

  PublicationsPostsModel({
    this.bu,
    this.checkAt,
    this.commentNum,
    this.contentText,
    this.dynamicId,
    this.dynamicMark,
    this.dynamicType,
    this.fakeFavorites,
    this.fakeLikes,
    this.fakeWatchTimes,
    this.gender,
    this.images,
    this.coverImg,
    this.interactive,
    this.isAttention,
    this.isFavorite,
    this.isLike,
    this.isRecommend,
    this.logo,
    this.nickName,
    this.notPass,
    this.price,
    this.realFavorites,
    this.realLikes,
    this.realWatchTimes,
    this.status,
    this.title,
    this.topDynamic,
    this.topic,
    this.userId,
    this.video,
    this.vipType,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('bu', this.bu)
      ..put('checkAt', this.checkAt)
      ..put('commentNum', this.commentNum)
      ..put('contentText', this.contentText)
      ..put('dynamicId', this.dynamicId)
      ..put('dynamicMark', this.dynamicMark)
      ..put('dynamicType', this.dynamicType)
      ..put('fakeFavorites', this.fakeFavorites)
      ..put('fakeLikes', this.fakeLikes)
      ..put('fakeWatchTimes', this.fakeWatchTimes)
      ..put('gender', this.gender)
      ..put('images', this.images)
      ..put('coverImg', this.coverImg)
      ..put('interactive', this.interactive)
      ..put('isAttention', this.isAttention)
      ..put('isFavorite', this.isFavorite)
      ..put('isLike', this.isLike)
      ..put('isRecommend', this.isRecommend)
      ..put('logo', this.logo)
      ..put('nickName', this.nickName)
      ..put('notPass', this.notPass)
      ..put('price', this.price)
      ..put('realFavorites', this.realFavorites)
      ..put('realLikes', this.realLikes)
      ..put('realWatchTimes', this.realWatchTimes)
      ..put('status', this.status)
      ..put('title', this.title)
      ..put('topDynamic', this.topDynamic)
      ..put('topic', this.topic)
      ..put('userId', this.userId)
      ..put('video', this.video?.toJson())
      ..put('vipType', this.vipType);
  }

  PublicationsPostsModel.fromJson(Map<String, dynamic> json) {
    this.bu = json.asInt('bu');
    this.checkAt = json.asString('checkAt');
    this.commentNum = json.asInt('commentNum');
    this.contentText = json.asString('contentText');
    this.dynamicId = json.asInt('dynamicId');
    this.dynamicMark = json.asInt('dynamicMark');
    this.dynamicType = json.asInt('dynamicType');
    this.fakeFavorites = json.asInt('fakeFavorites');
    this.fakeLikes = json.asInt('fakeLikes');
    this.fakeWatchTimes = json.asInt('fakeWatchTimes');
    this.gender = json.asInt('gender');
    this.images = json.asList<String>('images', null);
    this.coverImg = json.asList<String>('coverImg');
    this.interactive = json.asInt('interactive');
    this.isAttention = json.asBool('isAttention');
    this.isFavorite = json.asBool('isFavorite');
    this.isLike = json.asBool('isLike');
    this.isRecommend = json.asBool('isRecommend');
    this.logo = json.asString('logo');
    this.nickName = json.asString('nickName');
    this.notPass = json.asString('notPass');
    this.price = json.asInt('price');
    this.realFavorites = json.asInt('realFavorites');
    this.realLikes = json.asInt('realLikes');
    this.realWatchTimes = json.asInt('realWatchTimes');
    this.status = json.asInt('status');
    this.title = json.asString('title');
    this.topDynamic = json.asBool('topDynamic');
    this.topic = json.asString('topic');
    this.userId = json.asInt('userId');
    this.video = json.asBean(
        'video', (v) => Video.fromJson(Map<String, dynamic>.from(v)));
    this.vipType = json.asInt('vipType');
  }

  static PublicationsPostsModel toBean(Map<String, dynamic> json) =>
      PublicationsPostsModel.fromJson(json);
}

class CdnRes {
  String? id;
  String? line;
  int? mark;
  bool? vip;

  CdnRes({
    this.id,
    this.line,
    this.mark,
    this.vip,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id', this.id)
      ..put('line', this.line)
      ..put('mark', this.mark)
      ..put('vip', this.vip);
  }

  CdnRes.fromJson(Map<String, dynamic> json) {
    this.id = json.asString('id');
    this.line = json.asString('line');
    this.mark = json.asInt('mark');
    this.vip = json.asBool('vip');
  }
}

class Video {
  String? authKey;
  CdnRes? cdnRes;
  String? coverImg;
  int? height;
  String? id;
  int? playTime;
  String? resourceTitle;
  String? title;
  String? videoUrl;
  int? width;

  Video({
    this.authKey,
    this.cdnRes,
    this.coverImg,
    this.height,
    this.id,
    this.playTime,
    this.resourceTitle,
    this.title,
    this.videoUrl,
    this.width,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('authKey', this.authKey)
      ..put('cdnRes', this.cdnRes?.toJson())
      ..put('coverImg', this.coverImg)
      ..put('height', this.height)
      ..put('id', this.id)
      ..put('playTime', this.playTime)
      ..put('resourceTitle', this.resourceTitle)
      ..put('title', this.title)
      ..put('videoUrl', this.videoUrl)
      ..put('width', this.width);
  }

  Video.fromJson(Map<String, dynamic> json) {
    this.authKey = json.asString('authKey');
    this.cdnRes = json.asBean(
        'cdnRes', (v) => CdnRes.fromJson(Map<String, dynamic>.from(v)));
    this.coverImg = json.asString('coverImg');
    this.height = json.asInt('height');
    this.id = json.asString('id');
    this.playTime = json.asInt('playTime');
    this.resourceTitle = json.asString('resourceTitle');
    this.title = json.asString('title');
    this.videoUrl = json.asString('videoUrl');
    this.width = json.asInt('width');
  }
}
