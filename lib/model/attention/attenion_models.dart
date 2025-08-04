import 'package:xhs_app/model/video_base_model.dart';
import 'package:json2dart_safe/json2dart.dart';

class UserRecommendResp {
  final String logo;
  final String nickName;
  final int userId;
  UserRecommendResp.fromJson(Map<String, dynamic> json)
      : logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        userId = json.asInt('userId');

  static dynamic toBean(dynamic json) => UserRecommendResp.fromJson(json);
}

class AttentionUserVideosResp {
  final List<VideoBaseModel> attentionVideoList;
  final List<UserRecommendResp> userRecommendList;

  AttentionUserVideosResp.fromJson(Map<String, dynamic> json)
      : attentionVideoList = json.asList<VideoBaseModel>(
                'attentionVideoList', VideoBaseModel.toBean) ??
            [],
        userRecommendList = json.asList<UserRecommendResp>(
                'userRecommendList', UserRecommendResp.toBean) ??
            [];
}
