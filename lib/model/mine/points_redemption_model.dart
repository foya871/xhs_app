import 'package:json2dart_safe/json2dart.dart';

class PointsRedemptionModel {
  int? integral;
  List<PrizeList>? prizeList;

  PointsRedemptionModel({
    this.integral,
    this.prizeList,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('integral', this.integral)
      ..put('prizeList', this.prizeList?.map((v) => v.toJson()).toList());
  }

  PointsRedemptionModel.fromJson(Map<String, dynamic> json) {
    this.integral = json.asInt('integral');
    this.prizeList = json.asList<PrizeList>(
        'prizeList', (v) => PrizeList.fromJson(Map<String, dynamic>.from(v)));
  }

  static PointsRedemptionModel toBean(Map<String, dynamic> json) =>
      PointsRedemptionModel.fromJson(json);
}

class PrizeList {
  String? desc;
  String? image;
  int? needIntegral;
  int? prizeId;
  String? prizeName;
  int? prizeType;
  int? sendNum;

  PrizeList({
    this.desc,
    this.image,
    this.needIntegral,
    this.prizeId,
    this.prizeName,
    this.prizeType,
    this.sendNum,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('desc', this.desc)
      ..put('image', this.image)
      ..put('needIntegral', this.needIntegral)
      ..put('prizeId', this.prizeId)
      ..put('prizeName', this.prizeName)
      ..put('prizeType', this.prizeType)
      ..put('sendNum', this.sendNum);
  }

  PrizeList.fromJson(Map<String, dynamic> json) {
    this.desc = json.asString('desc');
    this.image = json.asString('image');
    this.needIntegral = json.asInt('needIntegral');
    this.prizeId = json.asInt('prizeId');
    this.prizeName = json.asString('prizeName');
    this.prizeType = json.asInt('prizeType');
    this.sendNum = json.asInt('sendNum');
  }
}
