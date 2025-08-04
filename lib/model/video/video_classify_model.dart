import 'package:json2dart_safe/json2dart.dart';

class VideoClassifyModel {
  int? classifyId;
  String? classifyTitle;
  int? type;
  bool? defaultSelected;

  VideoClassifyModel({
    this.classifyId,
    this.classifyTitle,
    this.type,
    this.defaultSelected,
  });

  factory VideoClassifyModel.fromJson(Map<String, dynamic> json) {
    return VideoClassifyModel(
      classifyId: json.asInt('classifyId'),
      classifyTitle: json.asString('classifyTitle'),
      type: json.asInt('type'),
      defaultSelected: json.asBool('defaultSelected'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classifyId': classifyId,
      'classifyTitle': classifyTitle,
      'type': type,
      'defaultSelected': defaultSelected,
    };
  }
}
