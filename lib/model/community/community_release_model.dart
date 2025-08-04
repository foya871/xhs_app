import 'package:xhs_app/model/community/community_video_model.dart';
import 'package:json2dart_safe/json2dart.dart';

class CommunityReleaseModel {
  String? classifyTitle;
  String? collectionName;
  bool? exclusiveToFans;

  int? dynamicType; //动态类型:1-图文 2-视频
  String? title; //动态标题
  String? contentText; //动态文本内容
  double? price; //价格
  List<String>? images; //图片
  List<String>? topic; //话题
  CommunityVideoModel? video; //视频

  CommunityReleaseModel({
    this.classifyTitle,
    this.collectionName,
    this.exclusiveToFans,
    this.dynamicType,
    this.title,
    this.contentText,
    this.price,
    this.images,
    this.topic,
    this.video,
  });

  CommunityReleaseModel.fromJson(Map<String, dynamic> json) {
    classifyTitle = json.asString('classifyTitle');
    collectionName = json.asString('collectionName');
    exclusiveToFans = json.asBool('exclusiveToFans');
    dynamicType = json.asInt('dynamicType');
    title = json.asString('title');
    contentText = json.asString('contentText');
    price = json.asDouble('price');
    images = json.asList<String>('images');
    topic = json.asList<String>('topic');
    video = json.asBean('video',
        (v) => CommunityVideoModel.fromJson(Map<String, dynamic>.from(v)));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('classifyTitle', classifyTitle)
      ..put('collectionName', collectionName)
      ..put('exclusiveToFans', exclusiveToFans)
      ..put('dynamicType', dynamicType)
      ..put('title', title)
      ..put('contentText', contentText)
      ..put('price', price)
      ..put('images', images)
      ..put('topic', topic)
      ..put('video', video?.toJson());
  }
  
  static CommunityReleaseModel toBean(dynamic json) =>
      CommunityReleaseModel.fromJson(json);
}
