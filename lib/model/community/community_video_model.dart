/*
 * @Author: wangdazhuang
 * @Date: 2025-03-03 13:53:46
 * @LastEditTime: 2025-03-04 11:58:07
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/model/community/community_video_model.dart
 */
import 'package:flutter/foundation.dart';
import 'package:json2dart_safe/json2dart.dart';

import '../../env/environment_service.dart';
import '../../utils/enum.dart';
import '../play/cdn_model.dart';

class CommunityVideoModel {
  String authKey;
  String coverImg;
  int height;
  String id;
  int playTime;
  String resourceTitle;
  String title;
  int videoMark;
  String videoUrl;
  int width;
  CdnRsp? cdnRes;
  String get authPlayUrl {
    // if (kDebugMode) {
    //   return 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
    // }
    return Environment.buildAuthPlayUrlString(
      videoUrl: videoUrl,
      authKey: authKey,
    );
  }

  void resetByCanWatch(CommunityVideoCanWatchModel canWatch) {
    videoUrl = canWatch.videoUrl;
    authKey = canWatch.authKey;
  }

  CommunityVideoModel.fromJson(Map<String, dynamic> json)
      : authKey = json.asString('authKey'),
        coverImg = json.asString('coverImg'),
        height = json.asInt('height'),
        id = json.asString('id'),
        playTime = json.asInt('playTime'),
        resourceTitle = json.asString('resourceTitle'),
        title = json.asString('title'),
        videoMark = json.asInt('videoMark'),
        videoUrl = json.asString('videoUrl'),
        cdnRes = json.asBean(
            'cdnRes', (v) => CdnRsp.fromJson(Map<String, dynamic>.from(v))),
        width = json.asInt('width');

  static dynamic toBean(dynamic json) => CommunityVideoModel.fromJson(json);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('videoUrl', videoUrl)
      ..put('authKey', authKey)
      ..put('coverImg', coverImg)
      ..put('height', height)
      ..put('width', width)
      ..put('id', id)
      ..put('playTime', playTime)
      ..put('resourceTitle', resourceTitle)
      ..put('title', title)
      ..put('cdnRes', cdnRes);
  }
}

class CommunityVideoCanWatchModel {
  final String authKey;
  final bool canWatch;
  final String playPath; // ??
  final CommunityReasonType reasonType;
  final String videoUrl;

  CommunityVideoCanWatchModel.fromJson(Map<String, dynamic> json)
      : authKey = json.asString('authKey'),
        canWatch = json.asBool('canWatch'),
        playPath = json.asString('playPath'),
        reasonType = json.asInt('reasonType'),
        videoUrl = json.asString('videoUrl');
}
