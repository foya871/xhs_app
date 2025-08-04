import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/model/community/community_video_model.dart';
import 'package:xhs_app/model/video_base_model.dart';

class CommunityInfoModel {
  int? dataType;
  String? text;
  String? image;
  CommunityVideoModel? video;

  CommunityInfoModel.addText(int this.dataType, String this.text);

  CommunityInfoModel.addImage(int this.dataType, String this.image);

  CommunityInfoModel.addVideo(
      int this.dataType, CommunityVideoModel this.video);

  CommunityInfoModel({
    this.dataType,
    this.text,
    this.image,
    this.video,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('dataType', dataType)
      ..put('text', text)
      ..put('image', image)
      ..put('video', video);
  }

  CommunityInfoModel.fromJson(Map<String, dynamic> json) {
    dataType = json.asInt('dataType');
    text = json.asString('text');
    image = json.asString('image');
    video = json.asBean(
        'video', (v) => VideoBaseModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static CommunityInfoModel toBean(dynamic json) =>
      CommunityInfoModel.fromJson(json);
}
