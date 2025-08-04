import 'package:json2dart_safe/json2dart.dart';

import 'recharge_type_model.dart';

class VipModel {
  int? cardId;
  String? cardName;
  String? cardImg;
  int? vipNumber;
  int? disPrice;
  int? price;
  String? desc;
  int? cardType;
  bool? isDeduct;
  bool? isNewUserDeduct;
  String? startDate;
  int? expiredDate;
  int? expiredTime;
  bool? isActivity;
  String? activityImg;
  List<RechargeTypeModel>? types;
  List<RightsDesc>? rightsDesc;
  bool? chatCard;

  VipModel({
    this.cardId,
    this.cardName,
    this.cardImg,
    this.vipNumber,
    this.disPrice,
    this.price,
    this.desc,
    this.cardType,
    this.isDeduct,
    this.isNewUserDeduct,
    this.startDate,
    this.expiredDate,
    this.expiredTime,
    this.isActivity,
    this.activityImg,
    this.types,
    this.rightsDesc,
    this.chatCard,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('cardId', cardId)
      ..put('cardName', cardName)
      ..put('cardImg', cardImg)
      ..put('vipNumber', vipNumber)
      ..put('disPrice', disPrice)
      ..put('price', price)
      ..put('desc', desc)
      ..put('cardType', cardType)
      ..put('isDeduct', isDeduct)
      ..put('isNewUserDeduct', isNewUserDeduct)
      ..put('startDate', startDate)
      ..put('expiredDate', expiredDate)
      ..put('expiredTime', expiredTime)
      ..put('isActivity', isActivity)
      ..put('activityImg', activityImg)
      ..put('rightsDesc', rightsDesc?.map((v) => v.toJson()).toList())
      ..put('types', types?.map((v) => v.toJson()).toList())
      ..put('chatCard', chatCard);
  }

  VipModel.fromJson(Map<String, dynamic> json) {
    cardId = json.asInt('cardId');
    cardName = json.asString('cardName');
    cardImg = json.asString('cardImg');
    vipNumber = json.asInt('vipNumber');
    disPrice = json.asInt('disPrice');
    price = json.asInt('price');
    desc = json.asString('desc');
    cardType = json.asInt('cardType');
    isDeduct = json.asBool('isDeduct');
    isNewUserDeduct = json.asBool('isNewUserDeduct');
    startDate = json.asString('startDate');
    expiredDate = json.asInt('expiredDate');
    expiredTime = json.asInt('expiredTime');
    isActivity = json.asBool('isActivity');
    activityImg = json.asString('activityImg');
    types = json.asList<RechargeTypeModel>('types',
        (v) => RechargeTypeModel.fromJson(Map<String, dynamic>.from(v)));
    rightsDesc = json.asList<RightsDesc>(
        'rightsDesc', (v) => RightsDesc.fromJson(Map<String, dynamic>.from(v)));
    chatCard = json.asBool('chatCard');
  }

  static dynamic toBean(dynamic json) => VipModel.fromJson(json);
}

class RightsDesc {
  String? desc;
  String? title;

  RightsDesc({
    this.desc,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('desc', this.desc)
      ..put('title', this.title);
  }

  RightsDesc.fromJson(Map<String, dynamic> json) {
    this.desc = json.asString('desc');
    this.title = json.asString('title');
  }
}
