import 'package:xhs_app/components/ad/ad_enum.dart';

class PopularSkitsBaseFindModel {
  int? videoId;
  String? title;
  String? subtitle;
  String? videoUrl;
  String? previewUrl;
  String? coverImg;
  String? verticalImg;
  int? price;
  String? disPrice;
  List<String>? tagTitles;
  String? like;
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
  String? playPath;
  int? videoMark;
  String? collectionName;
  String? nickName;
  String? logo;
  bool? attention;
  int? serialVideoNum;
  String? reviewDate;
  String? createdAt;
  String? updatedAt;

  // 前端
  AdApiType? ad;
  bool get isAd => ad != null;

  PopularSkitsBaseFindModel.fromAd(this.ad) : videoId = -9876543421;

  PopularSkitsBaseFindModel(
      {this.videoId,
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
      this.updatedAt});

  PopularSkitsBaseFindModel.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    subtitle = json['subtitle'];
    videoUrl = json['videoUrl'];
    previewUrl = json['previewUrl'];
    coverImg = json['coverImg'];
    verticalImg = json['verticalImg'];
    price = json['price'];
    disPrice = json['disPrice'];
    tagTitles = json['tagTitles'].cast<String>();
    like = json['like'];
    playTime = json['playTime'];
    size = json['size'];
    userId = json['userId'];
    videoType = json['videoType'];
    buyType = json['buyType'];
    fakeWatchNum = json['fakeWatchNum'];
    fakeLikes = json['fakeLikes'];
    fakeShareNum = json['fakeShareNum'];
    fakeFavorites = json['fakeFavorites'];
    commentNum = json['commentNum'];
    featuredOrFans = json['featuredOrFans'];
    incomeCount = json['incomeCount'];
    playPath = json['playPath'];
    videoMark = json['videoMark'];
    collectionName = json['collectionName'];
    nickName = json['nickName'];
    logo = json['logo'];
    attention = json['attention'];
    serialVideoNum = json['serialVideoNum'];
    reviewDate = json['reviewDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoId'] = this.videoId;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['videoUrl'] = this.videoUrl;
    data['previewUrl'] = this.previewUrl;
    data['coverImg'] = this.coverImg;
    data['verticalImg'] = this.verticalImg;
    data['price'] = this.price;
    data['disPrice'] = this.disPrice;
    data['tagTitles'] = this.tagTitles;
    data['like'] = this.like;
    data['playTime'] = this.playTime;
    data['size'] = this.size;
    data['userId'] = this.userId;
    data['videoType'] = this.videoType;
    data['buyType'] = this.buyType;
    data['fakeWatchNum'] = this.fakeWatchNum;
    data['fakeLikes'] = this.fakeLikes;
    data['fakeShareNum'] = this.fakeShareNum;
    data['fakeFavorites'] = this.fakeFavorites;
    data['commentNum'] = this.commentNum;
    data['featuredOrFans'] = this.featuredOrFans;
    data['incomeCount'] = this.incomeCount;
    data['playPath'] = this.playPath;
    data['videoMark'] = this.videoMark;
    data['collectionName'] = this.collectionName;
    data['nickName'] = this.nickName;
    data['logo'] = this.logo;
    data['attention'] = this.attention;
    data['serialVideoNum'] = this.serialVideoNum;
    data['reviewDate'] = this.reviewDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
