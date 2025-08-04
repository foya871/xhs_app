/*
 * @Author: wangdazhuang
 * @Date: 2024-08-28 17:59:58
 * @LastEditTime: 2024-08-28 20:18:03
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/model/comment/comment_model.dart
 */
import 'package:json2dart_safe/json2dart.dart';

class CommentModel {
  int beUserId;
  String beUserName;
  int commentId;
  String content;
  String createdAt;
  int fakeLikes;
  String id;
  String img;
  bool isLike;
  bool jump;
  int jumpType;
  String jumpUrl;
  String logo;
  String nickName;
  bool officialComment;
  int parentId;
  int replyNum;
  int type;
  int userId;
  int videoId;
  int vipType;
  List<CommentModel>? replyItems;

  CommentModel.empty() : this.fromJson({});

  CommentModel.fromJson(Map<String, dynamic> json)
      : beUserId = json.asInt('beUserId'),
        beUserName = json.asString('beUserName'),
        commentId = json.asInt('commentId'),
        content = json.asString('content'),
        createdAt = json.asString('createdAt'),
        fakeLikes = json.asInt('fakeLikes'),
        id = json.asString('id'),
        img = json.asString('img'),
        isLike = json.asBool('isLike'),
        jump = json.asBool('jump'),
        jumpType = json.asInt('jumpType'),
        jumpUrl = json.asString('jumpUrl'),
        logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        officialComment = json.asBool('officialComment'),
        parentId = json.asInt('parentId'),
        replyNum = json.asInt('replyNum'),
        type = json.asInt('type'),
        userId = json.asInt('userId'),
        videoId = json.asInt('videoId'),
        vipType = json.asInt('vipType'),
        replyItems = json.asList<CommentModel>(
          'replyItems',
          (v) => CommentModel.fromJson(Map<String, dynamic>.from(v)),
        );
  static toBean(Map<String, dynamic> json) => CommentModel.fromJson(json);
}
