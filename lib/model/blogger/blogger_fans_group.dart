import 'package:json2dart_safe/json2dart.dart';

class BloggerFansGroupModel {
  String? coverImg;
  String? createdAt;
  int? exclusiveNum;
  int? fansGroupNum;
  bool? fansMember;
  String? groupAnno;
  int? groupId;
  String? groupLogo;
  String? groupName;
  double? monthTicketPrice;
  int? realFansGroupNum;
  double? seasonTicketPrice;
  int? userId;
  double? yearTicketPrice;

  BloggerFansGroupModel({
    this.coverImg,
    this.createdAt,
    this.exclusiveNum,
    this.fansGroupNum,
    this.fansMember,
    this.groupAnno,
    this.groupId,
    this.groupLogo,
    this.groupName,
    this.monthTicketPrice,
    this.realFansGroupNum,
    this.seasonTicketPrice,
    this.userId,
    this.yearTicketPrice,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('coverImg', this.coverImg)
      ..put('createdAt', this.createdAt)
      ..put('exclusiveNum', this.exclusiveNum)
      ..put('fansGroupNum', this.fansGroupNum)
      ..put('fansMember', this.fansMember)
      ..put('groupAnno', this.groupAnno)
      ..put('groupId', this.groupId)
      ..put('groupLogo', this.groupLogo)
      ..put('groupName', this.groupName)
      ..put('monthTicketPrice', this.monthTicketPrice)
      ..put('realFansGroupNum', this.realFansGroupNum)
      ..put('seasonTicketPrice', this.seasonTicketPrice)
      ..put('userId', this.userId)
      ..put('yearTicketPrice', this.yearTicketPrice);
  }

  BloggerFansGroupModel.fromJson(Map<String, dynamic> json) {
    this.coverImg = json.asString('coverImg');
    this.createdAt = json.asString('createdAt');
    this.exclusiveNum = json.asInt('exclusiveNum');
    this.fansGroupNum = json.asInt('fansGroupNum');
    this.fansMember = json.asBool('fansMember');
    this.groupAnno = json.asString('groupAnno');
    this.groupId = json.asInt('groupId');
    this.groupLogo = json.asString('groupLogo');
    this.groupName = json.asString('groupName');
    this.monthTicketPrice = json.asDouble('monthTicketPrice');
    this.realFansGroupNum = json.asInt('realFansGroupNum');
    this.seasonTicketPrice = json.asDouble('seasonTicketPrice');
    this.userId = json.asInt('userId');
    this.yearTicketPrice = json.asDouble('yearTicketPrice');
  }

  static BloggerFansGroupModel toBean(Map<String, dynamic> json) =>
      BloggerFansGroupModel.fromJson(json);
}
