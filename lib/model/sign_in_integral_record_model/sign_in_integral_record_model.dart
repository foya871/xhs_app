import 'package:json2dart_safe/json2dart.dart';

class SignInIntegralRecordModel {
  int? changeIntegral;
  DateTime? createdAt;
  String? desc;
  String? id;
  int? newIntegral;
  int? type;
  DateTime? updatedAt;
  int? userId;

  SignInIntegralRecordModel({
    this.changeIntegral,
    this.createdAt,
    this.desc,
    this.id,
    this.newIntegral,
    this.type,
    this.updatedAt,
    this.userId,
  });

  factory SignInIntegralRecordModel.fromJson(Map<String, dynamic> json) {
    return SignInIntegralRecordModel(
      changeIntegral: json.asInt('changeIntegral'),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json.asString('createdAt') ?? ''),
      desc: json.asString('desc'),
      id: json.asString('id'),
      newIntegral: json.asInt('newIntegral'),
      type: json.asInt('type'),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json.asString('updatedAt') ?? ''),
      userId: json.asInt('userId'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'changeIntegral': changeIntegral,
      'createdAt': createdAt?.toIso8601String(),
      'desc': desc,
      'id': id,
      'newIntegral': newIntegral,
      'type': type,
      'updatedAt': updatedAt?.toIso8601String(),
      'userId': userId,
    };
  }
}
