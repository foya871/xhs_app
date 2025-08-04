import 'package:json2dart_safe/json2dart.dart';

class BloggerFansModel {
  bool? blogger;
  int? deDuctMark;
  bool? expired;
  String? expiredTime;
  int? intimacy;
  String? logo;
  String? nickName;
  int? ticketType;
  int? userId;
  int? vipType;

  BloggerFansModel({
    this.blogger,
    this.deDuctMark,
    this.expired,
    this.expiredTime,
    this.intimacy,
    this.logo,
    this.nickName,
    this.ticketType,
    this.userId,
    this.vipType,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('blogger', this.blogger)
      ..put('deDuctMark', this.deDuctMark)
      ..put('expired', this.expired)
      ..put('expiredTime', this.expiredTime)
      ..put('intimacy', this.intimacy)
      ..put('logo', this.logo)
      ..put('nickName', this.nickName)
      ..put('ticketType', this.ticketType)
      ..put('userId', this.userId)
      ..put('vipType', this.vipType);
  }

  BloggerFansModel.fromJson(Map<String, dynamic> json) {
    this.blogger = json.asBool('blogger');
    this.deDuctMark = json.asInt('deDuctMark');
    this.expired = json.asBool('expired');
    this.expiredTime = json.asString('expiredTime');
    this.intimacy = json.asInt('intimacy');
    this.logo = json.asString('logo');
    this.nickName = json.asString('nickName');
    this.ticketType = json.asInt('ticketType');
    this.userId = json.asInt('userId');
    this.vipType = json.asInt('vipType');
  }

  static BloggerFansModel toBean(Map<String, dynamic> json) =>
      BloggerFansModel.fromJson(json);
}
