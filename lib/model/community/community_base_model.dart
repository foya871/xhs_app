import 'package:json2dart_safe/json2dart.dart';

import '../../event_bus/events/dynamic_event.dart';
import '../../utils/enum.dart';
import 'community_video_model.dart';

class CommunityBaseModel {
  final bool blogger;
  final int bu;
  final String checkAt;
  final String classifyTitle;
  final String collectionName;
  int commentNum;
  final String contentText;
  final int dynamicId;
  final int dynamicMark;
  final CommunityType dynamicType;
  final bool exclusiveToFans;
  int fakeFavorites;
  int fakeLikes;
  final int fakeWatchTimes;
  final bool featured;
  final int gender;
  final List<String> images;
  final int imgNum;
  final bool isAttention;
  bool isFavorite;
  bool isLike;
  final int jumpType;
  final String jumpUrl;
  final String logo;
  final String nickName;
  final String notPass;
  final int playTime;
  final int status;
  final String title;
  final bool topDynamic;
  final List<String> topic;
  final int userId;
  final CommunityVideoModel? video;
  final int vipType;

  bool get isText => dynamicType == CommunityTypeEnum.text;
  bool get isVideo => dynamicType == CommunityTypeEnum.video;
  bool get isAd => dynamicType == CommunityTypeEnum.ad;
  bool get isPicture => dynamicType == CommunityTypeEnum.picture;
  // 当类型为广告时，区分不了视频还是图文，这里加个这个...
  bool get hasVideo => video != null;

  String get cover => video?.coverImg ?? images.firstOrNull ?? '';

  void onChangeEvent(DynamicChangeEvent e) {
    if (e.isLike != null) isLike = e.isLike!;
    if (e.fakeLikes != null) fakeLikes = e.fakeLikes!;
    if (e.isFavorite != null) isFavorite = e.isFavorite!;
    if (e.fakeFavorites != null) fakeFavorites = e.fakeFavorites!;
    if (e.commentNum != null) commentNum = e.commentNum!;
  }

  void onToggleLikeSuccess() {
    if (isLike) {
      fakeLikes--;
      if (fakeLikes < 0) {
        fakeLikes = 0;
      }
    } else {
      fakeLikes++;
    }
    isLike = !isLike;
  }

  void onToggleFavoriteSuccess() {
    if (isFavorite) {
      fakeFavorites--;
      if (fakeFavorites < 0) {
        fakeFavorites = 0;
      }
    } else {
      fakeFavorites++;
    }
    isFavorite = !isFavorite;
  }

  CommunityBaseModel.fromJson(Map<String, dynamic> json)
      : blogger = json.asBool('blogger'),
        bu = json.asInt('bu'),
        checkAt = json.asString('checkAt'),
        classifyTitle = json.asString('classifyTitle'),
        collectionName = json.asString('collectionName'),
        commentNum = json.asInt('commentNum'),
        contentText = json.asString('contentText'),
        dynamicId = json.asInt('dynamicId'),
        dynamicMark = json.asInt('dynamicMark'),
        dynamicType = json.asInt('dynamicType'),
        exclusiveToFans = json.asBool('exclusiveToFans'),
        fakeFavorites = json.asInt('fakeFavorites'),
        fakeLikes = json.asInt('fakeLikes'),
        fakeWatchTimes = json.asInt('fakeWatchTimes'),
        featured = json.asBool('featured'),
        gender = json.asInt('gender'),
        images = json.asList<String>('images') ?? [],
        imgNum = json.asInt('imgNum'),
        isAttention = json.asBool('isAttention'),
        isFavorite = json.asBool('isFavorite'),
        isLike = json.asBool('isLike'),
        jumpType = json.asInt('jumpType'),
        jumpUrl = json.asString('jumpUrl'),
        logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        notPass = json.asString('notPass'),
        playTime = json.asInt('playTime'),
        status = json.asInt('status'),
        title = json.asString('title'),
        topDynamic = json.asBool('topDynamic'),
        topic = json.asList<String>('topic') ?? [],
        userId = json.asInt('userId'),
        video = json.asBean('video', CommunityVideoModel.toBean),
        vipType = json.asInt('vipType');

  static dynamic toBean(dynamic json) => CommunityBaseModel.fromJson(json);
}
