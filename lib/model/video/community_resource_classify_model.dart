import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json2dart_safe/json2dart.dart';

class CommunityResourceClassifyModel {
  int? total;
  List<Data>? data;
  String? domain;

  CommunityResourceClassifyModel({
    this.total,
    this.data,
    this.domain,
  });

  factory CommunityResourceClassifyModel.fromJson(Map<String, dynamic> json) {
    return CommunityResourceClassifyModel(
      total: json.asInt('total'),
      data: json.asList<Data>(
          'data', (v) => Data.fromJson(v as Map<String, dynamic>)),
      domain: json.asString('domain'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'data': data?.map((e) => e.toJson()).toList(),
      'domain': domain,
    };
  }
}

class Data {
  String? id;
  int? classifyId;
  String? classifyTitle;
  int? sortNum;
  bool? appShow;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.classifyId,
    this.classifyTitle,
    this.sortNum,
    this.appShow,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json.asString('id'),
      classifyId: json.asInt('classifyId'),
      classifyTitle: json.asString('classifyTitle'),
      sortNum: json.asInt('sortNum'),
      appShow: json.asBool('appShow'),
      createdAt: json.asString('createdAt'),
      updatedAt: json.asString('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classifyId': classifyId,
      'classifyTitle': classifyTitle,
      'sortNum': sortNum,
      'appShow': appShow,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
