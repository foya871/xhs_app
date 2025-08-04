import 'package:json2dart_safe/json2dart.dart';

// class ActivityNewModel {
//   String? apkLink;
//   int? clickNum;
//   String? createdAt;
//   String? icon;
//   String? id;
//   String? innerLink;
//   bool? isOpen;
//   int? labelType;
//   String? link;
//   String? name;
//   int? realClickNum;
//   String? remark;
//   bool? remove;
//   int? sortNum;
//   String? startTime;
//   List<Stations>? stations;
//   String? stopTime;
//   String? updatedAt;

//   ActivityNewModel({
//     this.apkLink,
//     this.clickNum,
//     this.createdAt,
//     this.icon,
//     this.id,
//     this.innerLink,
//     this.isOpen,
//     this.labelType,
//     this.link,
//     this.name,
//     this.realClickNum,
//     this.remark,
//     this.remove,
//     this.sortNum,
//     this.startTime,
//     this.stations,
//     this.stopTime,
//     this.updatedAt,
//   });

//   Map<String, dynamic> toJson() {
//     return Map<String, dynamic>()
//       ..put('apkLink', this.apkLink)
//       ..put('clickNum', this.clickNum)
//       ..put('createdAt', this.createdAt)
//       ..put('icon', this.icon)
//       ..put('id', this.id)
//       ..put('innerLink', this.innerLink)
//       ..put('isOpen', this.isOpen)
//       ..put('labelType', this.labelType)
//       ..put('link', this.link)
//       ..put('name', this.name)
//       ..put('realClickNum', this.realClickNum)
//       ..put('remark', this.remark)
//       ..put('remove', this.remove)
//       ..put('sortNum', this.sortNum)
//       ..put('startTime', this.startTime)
//       ..put('stations', this.stations?.map((v) => v.toJson()).toList())
//       ..put('stopTime', this.stopTime)
//       ..put('updatedAt', this.updatedAt);
//   }

//   ActivityNewModel.fromJson(Map<String, dynamic> json) {
//     this.apkLink = json.asString('apkLink');
//     this.clickNum = json.asInt('clickNum');
//     this.createdAt = json.asString('createdAt');
//     this.icon = json.asString('icon');
//     this.id = json.asString('id');
//     this.innerLink = json.asString('innerLink');
//     this.isOpen = json.asBool('isOpen');
//     this.labelType = json.asInt('labelType');
//     this.link = json.asString('link');
//     this.name = json.asString('name');
//     this.realClickNum = json.asInt('realClickNum');
//     this.remark = json.asString('remark');
//     this.remove = json.asBool('remove');
//     this.sortNum = json.asInt('sortNum');
//     this.startTime = json.asString('startTime');
//     this.stations = json.asList<Stations>(
//         'stations', (v) => Stations.fromJson(Map<String, dynamic>.from(v)));
//     this.stopTime = json.asString('stopTime');
//     this.updatedAt = json.asString('updatedAt');
//   }

//   static ActivityNewModel toBean(Map<String, dynamic> json) =>
//       ActivityNewModel.fromJson(json);
// }

class Stations {
  int? stationId;
  String? stationName;

  Stations({
    this.stationId,
    this.stationName,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('stationId', this.stationId)
      ..put('stationName', this.stationName);
  }

  Stations.fromJson(Map<String, dynamic> json) {
    this.stationId = json.asInt('stationId');
    this.stationName = json.asString('stationName');
  }

  static Stations toBean(Map<String, dynamic> json) => Stations.fromJson(json);
}
