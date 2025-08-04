import 'package:json2dart_safe/json2dart.dart';

class PartnerModel {
  String? apkLink;
  int? clickNum;
  DateTime? createdAt;
  String? icon;
  String? id;
  String? innerLink;
  bool? isOpen;
  int? labelType;
  String? link;
  String? name;
  int? sortNum;
  DateTime? startTime;
  DateTime? stopTime;
  DateTime? updatedAt;

  PartnerModel({
    this.apkLink,
    this.clickNum,
    this.createdAt,
    this.icon,
    this.id,
    this.innerLink,
    this.isOpen,
    this.labelType,
    this.link,
    this.name,
    this.sortNum,
    this.startTime,
    this.stopTime,
    this.updatedAt,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      apkLink: json.asString('apkLink'),
      clickNum: json.asInt('clickNum'),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json.asString('createdAt') ?? ''),
      icon: json.asString('icon'),
      id: json.asString('id'),
      innerLink: json.asString('innerLink'),
      isOpen: json.asBool('isOpen'),
      labelType: json.asInt('labelType'),
      link: json.asString('link'),
      name: json.asString('name'),
      sortNum: json.asInt('sortNum'),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json.asString('startTime') ?? ''),
      stopTime: json['stopTime'] == null
          ? null
          : DateTime.parse(json.asString('stopTime') ?? ''),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json.asString('updatedAt') ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apkLink': apkLink,
      'clickNum': clickNum,
      'createdAt': createdAt?.toIso8601String(),
      'icon': icon,
      'id': id,
      'innerLink': innerLink,
      'isOpen': isOpen,
      'labelType': labelType,
      'link': link,
      'name': name,
      'sortNum': sortNum,
      'startTime': startTime?.toIso8601String(),
      'stopTime': stopTime?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
