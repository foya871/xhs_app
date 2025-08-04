import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/model/video_base_model.dart';

import '../../env/environment_service.dart';
import '../../utils/enum.dart';
import '../../utils/extension.dart';
import 'cdn_model.dart';
import '../axis_cover.dart';

class VideoDetail extends AxisCover {
  bool? attention;
  String? authKey;
  int? bu;
  bool? canWatch;
  String? checkSum;
  int? collectionId;
  String? collectionName;
  int? commentNum;
  String? coverImg;
  String? createdAt;
  int? fakeFavorites;
  int? fakeLikes;
  int? fakeShareNum;
  int? fakeWatchNum;
  bool? favorite;
  int? height;
  bool? like;
  String? logo;
  String? nickName;
  int? playTime;
  double? price;
//不能关于原因 1-无次数 2-需要付费 3-需要vip 4-无粉丝团门票
  VideoReasonTypeEnum? reasonType;
  //关联视频id
  int? rsVideoId;
  int? size;
  String? title;
  int? userId;
  List<String>? verticalImg;
  int? videoId;
//视频类型：0-普通视频 1-VIP视频 2-付费视频
  VideoTypeEnum? videoType;
  String? videoUrl;
  int? width;
  int? workNum;
  List<String>? tagTitles;
  CdnRsp? cdnRes;
  int? contentId;
  int? videoCollectionNum;
  bool? favoriteCollection;
  List<int>? videoSerialIds;
  List<VideoBaseModel>? videos;
  bool? forceAd;
  String get authPlayUrl =>
      Environment.buildAuthPlayUrlString(videoUrl: videoUrl, authKey: authKey);

  @override
  String get vCover => verticalImg?.firstOrNull ?? '';
  @override
  String get hCover => coverImg ?? '';
  String get priceText => price?.toStringAsShort() ?? '';

  VideoDetail.fromJson(Map<String, dynamic> json) {
    forceAd = json.asBool('forceAd');
    tagTitles = json.asList<String>('tagTitles', null) ?? [];
    attention = json.asBool('attention');
    authKey = json.asString('authKey');
    bu = json.asInt('bu');
    contentId = json.asInt('contentId');
    canWatch = json.asBool('canWatch');
    checkSum = json.asString('checkSum');
    collectionId = json.asInt('collectionId');
    collectionName = json.asString('collectionName');
    commentNum = json.asInt('commentNum');
    coverImg = json.asString('coverImg');
    createdAt = json.asString('createdAt');
    fakeFavorites = json.asInt('fakeFavorites');
    fakeLikes = json.asInt('fakeLikes');
    fakeShareNum = json.asInt('fakeShareNum');
    fakeWatchNum = json.asInt('fakeWatchNum');
    favorite = json.asBool('favorite');
    height = json.asInt('height');
    like = json.asBool('like');
    logo = json.asString('logo');
    nickName = json.asString('nickName');
    playTime = json.asInt('playTime');
    price = json.asDouble('price');
    reasonType = json.asInt('reasonType');
    rsVideoId = json.asInt('rsVideoId');
    size = json.asInt('size');
    title = json.asString('title');
    userId = json.asInt('userId');
    verticalImg = json.asList<String>('verticalImg', null);
    videoId = json.asInt('videoId');
    videoType = json.asInt('videoType');
    videoUrl = json.asString('videoUrl');
    width = json.asInt('width');
    workNum = json.asInt('workNum');
    cdnRes = json.asBean(
        "cdnRes", (v) => CdnRsp.fromJson(Map<String, dynamic>.from(v)));
    videoSerialIds = json.asList<int>("videoSerialIds") ?? [];
    videoCollectionNum = json.asInt('videoCollectionNum');
    favoriteCollection = json.asBool('favoriteCollection');
    videos = json.asList<VideoBaseModel>(
        "videos", (v) => VideoBaseModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static dynamic toBean(Map json) =>
      VideoDetail.fromJson(Map<String, dynamic>.from(json));
}
