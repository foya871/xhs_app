import 'package:json2dart_safe/json2dart.dart';

class DailySignInRespModel {
  int? dayNo;
  int? status;

  DailySignInRespModel({
    this.dayNo,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('dayNo', this.dayNo)
      ..put('status', this.status);
  }

  DailySignInRespModel.fromJson(Map<String, dynamic> json) {
    this.dayNo = json.asInt('dayNo');
    this.status = json.asInt('status');
  }

  static DailySignInRespModel toBean(Map<String, dynamic> json) =>
      DailySignInRespModel.fromJson(json);
}
