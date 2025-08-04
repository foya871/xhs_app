import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';

class ShortVideosResp {
  dynamic total;
  List<ShortVideoModel>? data;
  String? domain;

  ShortVideosResp({
    this.total,
    this.data,
    this.domain,
  });

  factory ShortVideosResp.fromJson(Map<String, dynamic> json) {
    return ShortVideosResp(
      total: json['total'],
      data: json.asList<ShortVideoModel>(
          'data', (v) => ShortVideoModel.fromJson(v as Map<String, dynamic>)),
      domain: json.asString('domain'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'data': data?.map((e) => e.toJson()).toList(),
      'domain': domain,
    };
  }
}

class ShortVideoModel {
  int? videoId;
  String? title;
  dynamic subtitle;
  String? videoUrl;
  dynamic previewUrl;
  String? coverImg;
  dynamic verticalImg;
  int? price;
  dynamic disPrice;
  List<String>? tagTitles;
  dynamic like;
  int? playTime;
  int? size;
  int? userId;
  int? videoType;
  int? buyType;
  int? fakeWatchNum;
  int? fakeLikes;
  int? fakeShareNum;
  int? fakeFavorites;
  int? commentNum;
  int? featuredOrFans;
  int? incomeCount;
  dynamic playPath;
  int? videoMark;
  dynamic collectionName;
  String? nickName;
  String? logo;
  bool? attention;
  int? serialVideoNum;
  String? reviewDate;
  String? createdAt;
  String? updatedAt;

  // 前端自定义
  AdApiType? ad;

  ShortVideoModel.fromAd(this.ad) : videoId = -987654321;

  bool get isAd => ad != null;

  ShortVideoModel({
    this.videoId,
    this.title,
    this.subtitle,
    this.videoUrl,
    this.previewUrl,
    this.coverImg,
    this.verticalImg,
    this.price,
    this.disPrice,
    this.tagTitles,
    this.like,
    this.playTime,
    this.size,
    this.userId,
    this.videoType,
    this.buyType,
    this.fakeWatchNum,
    this.fakeLikes,
    this.fakeShareNum,
    this.fakeFavorites,
    this.commentNum,
    this.featuredOrFans,
    this.incomeCount,
    this.playPath,
    this.videoMark,
    this.collectionName,
    this.nickName,
    this.logo,
    this.attention,
    this.serialVideoNum,
    this.reviewDate,
    this.createdAt,
    this.updatedAt,
  });

  factory ShortVideoModel.fromJson(Map<String, dynamic> json) {
    return ShortVideoModel(
      videoId: json.asInt('videoId'),
      title: json.asString('title'),
      subtitle: json['subtitle'],
      videoUrl: json.asString('videoUrl'),
      previewUrl: json['previewUrl'],
      coverImg: json.asString('coverImg'),
      verticalImg: json['verticalImg'],
      price: json.asInt('price'),
      disPrice: json['disPrice'],
      tagTitles: json.asList<String>('tagTitles', (v) => v.toString()),
      like: json['like'],
      playTime: json.asInt('playTime'),
      size: json.asInt('size'),
      userId: json.asInt('userId'),
      videoType: json.asInt('videoType'),
      buyType: json.asInt('buyType'),
      fakeWatchNum: json.asInt('fakeWatchNum'),
      fakeLikes: json.asInt('fakeLikes'),
      fakeShareNum: json.asInt('fakeShareNum'),
      fakeFavorites: json.asInt('fakeFavorites'),
      commentNum: json.asInt('commentNum'),
      featuredOrFans: json.asInt('featuredOrFans'),
      incomeCount: json.asInt('incomeCount'),
      playPath: json['playPath'],
      videoMark: json.asInt('videoMark'),
      collectionName: json['collectionName'],
      nickName: json.asString('nickName'),
      logo: json.asString('logo'),
      attention: json.asBool('attention'),
      serialVideoNum: json.asInt('serialVideoNum'),
      reviewDate: json.asString('reviewDate'),
      createdAt: json.asString('createdAt'),
      updatedAt: json.asString('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'title': title,
      'subtitle': subtitle,
      'videoUrl': videoUrl,
      'previewUrl': previewUrl,
      'coverImg': coverImg,
      'verticalImg': verticalImg,
      'price': price,
      'disPrice': disPrice,
      'tagTitles': tagTitles,
      'like': like,
      'playTime': playTime,
      'size': size,
      'userId': userId,
      'videoType': videoType,
      'buyType': buyType,
      'fakeWatchNum': fakeWatchNum,
      'fakeLikes': fakeLikes,
      'fakeShareNum': fakeShareNum,
      'fakeFavorites': fakeFavorites,
      'commentNum': commentNum,
      'featuredOrFans': featuredOrFans,
      'incomeCount': incomeCount,
      'playPath': playPath,
      'videoMark': videoMark,
      'collectionName': collectionName,
      'nickName': nickName,
      'logo': logo,
      'attention': attention,
      'serialVideoNum': serialVideoNum,
      'reviewDate': reviewDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

extension ShortVideoModelEx on ShortVideoModel {}
