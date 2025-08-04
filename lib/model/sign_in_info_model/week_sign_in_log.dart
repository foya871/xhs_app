import 'package:json2dart_safe/json2dart.dart';

class WeekSignInLog {
  int? dayNo;
  int? status;
  bool? today;
  int? rewardIntegral;

  WeekSignInLog({
    this.dayNo,
    this.status,
    this.today,
    this.rewardIntegral,
  });

  factory WeekSignInLog.fromJson(Map<String, dynamic> json) {
    return WeekSignInLog(
      dayNo: json.asInt('dayNo'),
      status: json.asInt('status'),
      today: json.asBool('today'),
      rewardIntegral: json.asInt('rewardIntegral'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayNo': dayNo,
      'status': status,
      'today': today,
      'rewardIntegral': rewardIntegral,
    };
  }
}
