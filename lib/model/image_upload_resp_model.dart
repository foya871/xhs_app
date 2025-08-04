import 'package:json2dart_safe/json2dart.dart';

class ImageUploadRspModel {
  String? domain;
  String? path;
  String? fileName;

  ImageUploadRspModel({
    this.domain,
    this.path,
    this.fileName,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('domain', this.domain)
      ..put('path', this.path)
      ..put('fileName', this.fileName);
  }

  ImageUploadRspModel.fromJson(Map<String, dynamic> json) {
    this.domain = json.asString('domain');
    this.path = json.asString('path');
    this.fileName = json.asString('fileName');
  }

  static ImageUploadRspModel toBean(Map<String, dynamic> json) =>
      ImageUploadRspModel.fromJson(json);
}
