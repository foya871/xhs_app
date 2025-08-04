import 'package:json2dart_safe/json2dart.dart';

class CheckInInfoModel {
  List<DailySignInTasks>? dailySignInTasks;
  int? signCount;
  int? integral;
  int? totalSignCount;
  bool? todaySignIn;

  CheckInInfoModel({
    this.dailySignInTasks,
    this.signCount,
    this.todaySignIn,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('dailySignInTasks',
          this.dailySignInTasks?.map((v) => v.toJson()).toList())
      ..put('signCount', this.signCount)
      ..put('todaySignIn', this.todaySignIn)
      ..put('integral', this.integral)
      ..put('totalSignCount', this.totalSignCount);
  }

  CheckInInfoModel.fromJson(Map<String, dynamic> json) {
    this.dailySignInTasks = json.asList<DailySignInTasks>('dailySignInTasks',
        (v) => DailySignInTasks.fromJson(Map<String, dynamic>.from(v)));
    this.signCount = json.asInt('signCount');
    this.todaySignIn = json.asBool('todaySignIn');
    this.integral = json.asInt('integral');
    this.totalSignCount = json.asInt('totalSignCount');
  }

  static CheckInInfoModel toBean(Map<String, dynamic> json) =>
      CheckInInfoModel.fromJson(json);
}

class DailySignInTasks {
  String? date;
  int? dayNo;
  int? prizeNum;
  int? prizeType;
  int? status;
  bool? today;

  DailySignInTasks({
    this.date,
    this.dayNo,
    this.prizeNum,
    this.prizeType,
    this.status,
    this.today,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('date', this.date)
      ..put('dayNo', this.dayNo)
      ..put('prizeNum', this.prizeNum)
      ..put('prizeType', this.prizeType)
      ..put('status', this.status)
      ..put('today', this.today);
  }

  DailySignInTasks.fromJson(Map<String, dynamic> json) {
    this.date = json.asString('date');
    this.dayNo = json.asInt('dayNo');
    this.prizeNum = json.asInt('prizeNum');
    this.prizeType = json.asInt('prizeType');
    this.status = json.asInt('status');
    this.today = json.asBool('today');
  }
}
