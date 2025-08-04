import 'package:json2dart_safe/json2dart.dart';

class CheckInTasksModel {
  List<DailyTasks>? dailyTasks;
  List<IntegralPrizes>? integralPrizes;
  List<SingleTasks>? singleTasks;

  CheckInTasksModel({
    this.dailyTasks,
    this.integralPrizes,
    this.singleTasks,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('dailyTasks', this.dailyTasks?.map((v) => v.toJson()).toList())
      ..put('integralPrizes',
          integralPrizes?.map((v) => v.toJson()).toList())
      ..put('singleTasks', this.singleTasks?.map((v) => v.toJson()).toList());
  }

  CheckInTasksModel.fromJson(Map<String, dynamic> json) {
    dailyTasks = json.asList<DailyTasks>(
        'dailyTasks', (v) => DailyTasks.fromJson(Map<String, dynamic>.from(v)));
    integralPrizes = json.asList<IntegralPrizes>('integralPrizes',
        (v) => IntegralPrizes.fromJson(Map<String, dynamic>.from(v)));
    singleTasks = json.asList<SingleTasks>('singleTasks',
        (v) => SingleTasks.fromJson(Map<String, dynamic>.from(v)));
  }

  static CheckInTasksModel toBean(Map<String, dynamic> json) =>
      CheckInTasksModel.fromJson(json);
}

class DailyTasks {
  int? finishedNum;
  int? integral;
  int? missionId;
  String? missionName;
  int? missionType;
  int? numOfEveryDay;
  bool? single;
  int? status;

  DailyTasks({
    this.finishedNum,
    this.integral,
    this.missionId,
    this.missionName,
    this.missionType,
    this.numOfEveryDay,
    this.single,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('finishedNum', this.finishedNum)
      ..put('integral', this.integral)
      ..put('missionId', this.missionId)
      ..put('missionName', this.missionName)
      ..put('missionType', this.missionType)
      ..put('numOfEveryDay', this.numOfEveryDay)
      ..put('single', this.single)
      ..put('status', this.status);
  }

  DailyTasks.fromJson(Map<String, dynamic> json) {
    this.finishedNum = json.asInt('finishedNum');
    this.integral = json.asInt('integral');
    this.missionId = json.asInt('missionId');
    this.missionName = json.asString('missionName');
    this.missionType = json.asInt('missionType');
    this.numOfEveryDay = json.asInt('numOfEveryDay');
    this.single = json.asBool('single');
    this.status = json.asInt('status');
  }
}

class IntegralPrizes {
  int? needIntegral;
  int? prizeId;
  String? prizeName;
  int? prizeType;
  int? sendNum;

  IntegralPrizes({
    this.needIntegral,
    this.prizeId,
    this.prizeName,
    this.prizeType,
    this.sendNum,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('needIntegral', this.needIntegral)
      ..put('prizeId', this.prizeId)
      ..put('prizeName', this.prizeName)
      ..put('prizeType', this.prizeType)
      ..put('sendNum', this.sendNum);
  }

  IntegralPrizes.fromJson(Map<String, dynamic> json) {
    this.needIntegral = json.asInt('needIntegral');
    this.prizeId = json.asInt('prizeId');
    this.prizeName = json.asString('prizeName');
    this.prizeType = json.asInt('prizeType');
    this.sendNum = json.asInt('sendNum');
  }
}

class SingleTasks {
  int? finishedNum;
  int? integral;
  int? missionId;
  String? missionName;
  int? missionType;
  int? numOfEveryDay;
  bool? single;
  int? status;

  SingleTasks({
    this.finishedNum,
    this.integral,
    this.missionId,
    this.missionName,
    this.missionType,
    this.numOfEveryDay,
    this.single,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('finishedNum', this.finishedNum)
      ..put('integral', this.integral)
      ..put('missionId', this.missionId)
      ..put('missionName', this.missionName)
      ..put('missionType', this.missionType)
      ..put('numOfEveryDay', this.numOfEveryDay)
      ..put('single', this.single)
      ..put('status', this.status);
  }

  SingleTasks.fromJson(Map<String, dynamic> json) {
    this.finishedNum = json.asInt('finishedNum');
    this.integral = json.asInt('integral');
    this.missionId = json.asInt('missionId');
    this.missionName = json.asString('missionName');
    this.missionType = json.asInt('missionType');
    this.numOfEveryDay = json.asInt('numOfEveryDay');
    this.single = json.asBool('single');
    this.status = json.asInt('status');
  }
}
