import 'package:json2dart_safe/json2dart.dart';

import '../../event_bus/event_bus.dart';
import '../../event_bus/events/dynamic_event.dart';
import '../../utils/enum.dart';
import 'community_video_model.dart';

class CommunityModel {
  final bool blogger;
  final int bu;
  bool canWatch;
  final String checkAt;
  final String classifyTitle;
  final String collectionName;
  final int commentNum;
  final String contentText;
  final int dynamicId;
  final CommunityMarkType dynamicMark;
  final CommunityType dynamicType;
  final bool exclusiveToFans;
  int fakeFavorites;
  int fakeLikes;
  final int fakeWatchTimes;
  final bool featured;
  final int gender;
  final List<String> images;
  final int imgNum;
  bool isAttention;
  bool isFavorite;
  bool isLike;
  final int jumpType;
  final String jumpUrl;
  final String logo;
  final String nickName;
  final String notPass;
  final int playTime;
  final double price;
  CommunityReasonType reasonType;
  final int status;
  final String title;
  final bool topDynamic;
  final List<String> topic;
  final int userId;
  final CommunityVideoModel? video;
  final int vipType;

  ///是否选中
  bool? isSelected;

  bool get isVideo => dynamicType == CommunityTypeEnum.video;
  bool get isVideoAd => dynamicType == CommunityTypeEnum.ad && video != null;
  String get coverImage => isVideo
      ? video?.coverImg ?? ''
      : images.isNotEmpty
          ? images.first
          : "";
  // 当类型为广告时，区分不了视频还是图文，这里加个这个...
  bool get hasVideo => video != null;

  void onToggleAttentionSuccess() => isAttention = !isAttention;

  void onToggleLikeSuccess({bool fire = false}) {
    isLike = !isLike;
    if (isLike) {
      fakeLikes++;
    } else {
      fakeLikes--;
      if (fakeLikes < 0) {
        fakeLikes = 0;
      }
    }
    if (fire) {
      EventBusInst.fire(DynamicChangeEvent.like(
        dynamicId,
        isLike: isLike,
        fakeLikes: fakeLikes,
      ));
    }
  }

  void onToggleFavoriteSuccess({bool fire = false}) {
    isFavorite = !isFavorite;
    if (isFavorite) {
      fakeFavorites++;
    } else {
      fakeFavorites--;
      if (fakeFavorites < 0) {
        fakeFavorites = 0;
      }
    }
    if (fire) {
      EventBusInst.fire(DynamicChangeEvent.favorite(
        dynamicId,
        isFavorite: isFavorite,
        fakeFavorites: fakeFavorites,
      ));
    }
  }

  void resetByCanWatch(CommunityVideoCanWatchModel? canWatch) {
    if (canWatch == null) return;
    this.canWatch = canWatch.canWatch;
    reasonType = canWatch.reasonType;
    video?.resetByCanWatch(canWatch);
  }

  CommunityModel.empty() : this.fromJson({});

  CommunityModel.fromJson(Map<String, dynamic> json)
      : blogger = json.asBool('blogger'),
        bu = json.asInt('bu'),
        canWatch = json.asBool('canWatch'),
        checkAt = json.asString('checkAt'),
        classifyTitle = json.asString('classifyTitle'),
        collectionName = json.asString('collectionName'),
        commentNum = json.asInt('commentNum'),
        contentText = json.asString('contentText'),
        dynamicId = json.asInt('dynamicId'),
        dynamicMark = json.asInt('dynamicMark'),
        dynamicType = json.asInt('dynamicType', CommunityTypeEnum.none),
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
        price = json.asDouble('price'),
        reasonType = json.asInt('reasonType'),
        status = json.asInt('status'),
        title = json.asString('title'),
        topDynamic = json.asBool('topDynamic'),
        topic = json.asList<String>('topic') ?? [],
        userId = json.asInt('userId'),
        video = json.asBean('video', CommunityVideoModel.toBean),
        vipType = json.asInt('vipType'),
        isSelected = false;

  static dynamic toBean(dynamic json) => CommunityModel.fromJson(json);
}
