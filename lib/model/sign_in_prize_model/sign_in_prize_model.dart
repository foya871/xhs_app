import 'package:json2dart_safe/json2dart.dart';

class SignInPrizeModel {
  String? desc;
  String? image;
  int? needIntegral;
  int? prizeId;
  String? prizeName;
  int? prizeType;
  int? sendNum;

  SignInPrizeModel({
    this.desc,
    this.image,
    this.needIntegral,
    this.prizeId,
    this.prizeName,
    this.prizeType,
    this.sendNum,
  });

  factory SignInPrizeModel.fromJson(Map<String, dynamic> json) {
    return SignInPrizeModel(
      desc: json.asString('desc'),
      image: json.asString('image'),
      needIntegral: json.asInt('needIntegral'),
      prizeId: json.asInt('prizeId'),
      prizeName: json.asString('prizeName'),
      prizeType: json.asInt('prizeType'),
      sendNum: json.asInt('sendNum'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'desc': desc,
      'image': image,
      'needIntegral': needIntegral,
      'prizeId': prizeId,
      'prizeName': prizeName,
      'prizeType': prizeType,
      'sendNum': sendNum,
    };
  }
}
