import 'package:json2dart_safe/json2dart.dart';
import 'week_sign_in_log.dart';

class SignInInfoModel {
  int? integral;
  int? signCount;
  List<WeekSignInLog>? weekSignInLogs;

  SignInInfoModel({
    this.integral,
    this.signCount,
    this.weekSignInLogs,
  });

  factory SignInInfoModel.fromJson(Map<String, dynamic> json) {
    return SignInInfoModel(
      integral: json.asInt('integral'),
      signCount: json.asInt('signCount'),
      weekSignInLogs: json.asList<WeekSignInLog>('weekSignInLogs',
          (v) => WeekSignInLog.fromJson(v as Map<String, dynamic>)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'integral': integral,
      'signCount': signCount,
      'weekSignInLogs': weekSignInLogs?.map((e) => e.toJson()).toList(),
    };
  }
}
