import 'package:json2dart_safe/json2dart.dart';

class CommunityPushMessageModel {
  final int dynamicId;
  final List<String> images;
  final String title;

  CommunityPushMessageModel(this.dynamicId, this.images, this.title);

  String get cover => images.firstOrNull ?? '';

  CommunityPushMessageModel.fromJson(Map<String, dynamic> json)
      : dynamicId = json.asInt('dynamicId'),
        images = json.asList<String>('images') ?? [],
        title = json.asString('title');

  static dynamic toBean(dynamic json) =>
      CommunityPushMessageModel.fromJson(json);
}
