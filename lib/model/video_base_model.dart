import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/model/play/cdn_model.dart';

import '../utils/enum.dart';
import '../utils/extension.dart';
import './axis_cover.dart';

class VideoBaseModel extends AxisCover {
  bool? attention;
  int? buyType;
  int? classifyId;
  String? collectionName;
  int? commentNum;
  String? coverImg;
  String? createdAt;
  double? disPrice;
  int? fakeFavorites;
  int? fakeLikes;
  int? fakeShareNum;
  int? fakeWatchNum;
  bool? favorite;
  int? featuredOrFans;
  int? incomeCount;
  bool? like;
  String? logo;
  String? nickName;
  String? notPass;
  bool? officialRecommend;
  int? playTime;
  String? previewUrl;
  double? price;
  int? size;
  List<int>? stationIds;
  List<String>? stationNames;
  String? subtitle;
  List<String>? tagTitles;
  String? title;
  String? updatedAt;
  int? userId;
  List<String>? verticalImg;
  int? videoId;
  int? videoMark;
  VideoTypeEnum? videoType;
  CdnRsp? cdnRes;
  String? videoUrl;
  String? authKey;
  int? buyNum;
  bool? isSelected;
  int? height;
  int? width;
  int? mark;

  @override
  String get hCover => coverImg ?? '';
  @override
  String get vCover => verticalImg?.firstOrNull ?? '';
  String get priceText => price?.toStringAsShort() ?? '';
  // 短视频
  bool get isShort => videoMark == 2;

  VideoBaseModel(
      {this.attention,
      this.mark,
      this.height,
      this.width,
      this.buyType,
      this.classifyId,
      this.collectionName,
      this.commentNum,
      this.coverImg,
      this.createdAt,
      this.disPrice,
      this.fakeFavorites,
      this.fakeLikes,
      this.fakeShareNum,
      this.fakeWatchNum,
      this.favorite,
      this.featuredOrFans,
      this.incomeCount,
      this.like,
      this.logo,
      this.nickName,
      this.notPass,
      this.officialRecommend,
      this.playTime,
      this.previewUrl,
      this.price,
      this.size,
      this.stationIds,
      this.stationNames,
      this.subtitle,
      this.tagTitles,
      this.title,
      this.updatedAt,
      this.userId,
      this.verticalImg,
      this.videoId,
      this.videoMark,
      this.videoType,
      this.cdnRes,
      this.videoUrl,
      this.authKey,
      this.buyNum,
      this.isSelected});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('mark', mark)
      ..put('attention', attention)
      ..put('height', height)
      ..put('width', width)
      ..put('buyType', buyType)
      ..put('classifyId', classifyId)
      ..put('collectionName', collectionName)
      ..put('commentNum', commentNum)
      ..put('coverImg', coverImg)
      ..put('createdAt', createdAt)
      ..put('disPrice', disPrice)
      ..put('fakeFavorites', fakeFavorites)
      ..put('fakeLikes', fakeLikes)
      ..put('fakeShareNum', fakeShareNum)
      ..put('fakeWatchNum', fakeWatchNum)
      ..put('favorite', favorite)
      ..put('featuredOrFans', featuredOrFans)
      ..put('incomeCount', incomeCount)
      ..put('like', like)
      ..put('logo', logo)
      ..put('nickName', nickName)
      ..put('notPass', notPass)
      ..put('officialRecommend', officialRecommend)
      ..put('playTime', playTime)
      ..put('previewUrl', previewUrl)
      ..put('price', price)
      ..put('size', size)
      ..put('stationIds', stationIds)
      ..put('stationNames', stationNames)
      ..put('subtitle', subtitle)
      ..put('tags', tagTitles)
      ..put('title', title)
      ..put('updatedAt', updatedAt)
      ..put('userId', userId)
      ..put('verticalImg', verticalImg)
      ..put('videoId', videoId)
      ..put('videoMark', videoMark)
      ..put('videoType', videoType)
      ..put('cdnRes', cdnRes)
      ..put('videoUrl', videoUrl)
      ..put('authKey', authKey)
      ..put('buyNum', buyNum)
      ..put('isSelected', isSelected);
  }

  VideoBaseModel.fromJson(Map<String, dynamic> json) {
    attention = json.asBool('attention');
    buyType = json.asInt('buyType');
    mark = json.asInt('mark');
    width = json.asInt('width');
    height = json.asInt('height');
    classifyId = json.asInt('classifyId');
    collectionName = json.asString('collectionName');
    commentNum = json.asInt('commentNum');
    // this.coverImg = json.asList<String>('coverImg', null);
    coverImg = json.asString('coverImg');
    createdAt = json.asString('createdAt');
    disPrice = json.asDouble('disPrice');
    fakeFavorites = json.asInt('fakeFavorites');
    fakeLikes = json.asInt('fakeLikes');
    fakeShareNum = json.asInt('fakeShareNum');
    fakeWatchNum = json.asInt('fakeWatchNum');
    favorite = json.asBool('favorite');
    featuredOrFans = json.asInt('featuredOrFans');
    incomeCount = json.asInt('incomeCount');
    like = json.asBool('like');
    logo = json.asString('logo');
    nickName = json.asString('nickName');
    notPass = json.asString('notPass');
    officialRecommend = json.asBool('officialRecommend');
    playTime = json.asInt('playTime');
    previewUrl = json.asString('previewUrl');
    price = json.asDouble('price');
    size = json.asInt('size');
    stationIds = json.asList<int>('stationIds', null);
    stationNames = json.asList<String>('stationNames', null);
    subtitle = json.asString('subtitle');
    tagTitles = json.asList<String>('tagTitles', null);
    title = json.asString('title');
    updatedAt = json.asString('updatedAt');
    userId = json.asInt('userId');
    verticalImg = json.asList<String>('verticalImg', null);
    videoId = json.asInt('videoId');
    videoMark = json.asInt('videoMark');
    videoType = json.asInt('videoType');
    videoType = json.asInt('videoType');
    videoUrl = json.asString('videoUrl');
    authKey = json.asString('authKey');
    buyNum = json.asInt('buyNum');
    isSelected = json.asBool('isSelected');
    cdnRes = json.asBean(
        'cdnRes', (v) => CdnRsp.fromJson(Map<String, dynamic>.from(v)));
  }

  static dynamic toBean(dynamic json) => VideoBaseModel.fromJson(json);
}

class VideoBaseModelWithIndex {
  final VideoBaseModel video;
  int index;

  int get rank => index + 1;

  VideoBaseModelWithIndex({required this.index, required this.video});

  static List<VideoBaseModelWithIndex> fromList(List<VideoBaseModel> vidoes,
      {int offset = 0}) {
    return List.generate(
      vidoes.length,
      (i) => VideoBaseModelWithIndex(index: i + offset, video: vidoes[i]),
    );
  }
}
