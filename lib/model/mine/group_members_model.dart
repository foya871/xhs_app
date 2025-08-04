import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/components/pay/model/recharge_type_model.dart';

class GroupMembersModel {
  String? coverImg;
  String? createdAt;
  int? groupId;
  int? groupPrice;
  String? id;
  String? info;
  int? limitGroup;
  int? nowJoin;
  List<Participants>? participants;
  int? price;
  String? remarks;
  String? startTime;
  int? status;
  String? stopTime;
  List<RechargeTypeModel>? types;
  String? updatedAt;
  int? vipCardId;
  bool? buyGroupNot;

  GroupMembersModel({
    this.coverImg,
    this.createdAt,
    this.groupId,
    this.groupPrice,
    this.id,
    this.info,
    this.limitGroup,
    this.nowJoin,
    this.participants,
    this.price,
    this.remarks,
    this.startTime,
    this.status,
    this.stopTime,
    this.types,
    this.updatedAt,
    this.vipCardId,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('coverImg', this.coverImg)
      ..put('createdAt', this.createdAt)
      ..put('groupId', this.groupId)
      ..put('groupPrice', this.groupPrice)
      ..put('id', this.id)
      ..put('info', this.info)
      ..put('limitGroup', this.limitGroup)
      ..put('nowJoin', this.nowJoin)
      ..put('participants', this.participants?.map((v) => v.toJson()).toList())
      ..put('price', this.price)
      ..put('remarks', this.remarks)
      ..put('startTime', this.startTime)
      ..put('status', this.status)
      ..put('stopTime', this.stopTime)
      ..put('types', this.types?.map((v) => v.toJson()).toList())
      ..put('updatedAt', this.updatedAt)
      ..put('buyGroupNot', this.buyGroupNot)
      ..put('vipCardId', this.vipCardId);
  }

  GroupMembersModel.fromJson(Map<String, dynamic> json) {
    this.coverImg = json.asString('coverImg');
    this.createdAt = json.asString('createdAt');
    this.groupId = json.asInt('groupId');
    this.groupPrice = json.asInt('groupPrice');
    this.id = json.asString('id');
    this.info = json.asString('info');
    this.limitGroup = json.asInt('limitGroup');
    this.nowJoin = json.asInt('nowJoin');
    this.participants = json.asList<Participants>('participants',
        (v) => Participants.fromJson(Map<String, dynamic>.from(v)));
    this.price = json.asInt('price');
    this.remarks = json.asString('remarks');
    this.startTime = json.asString('startTime');
    this.status = json.asInt('status');
    this.stopTime = json.asString('stopTime');
    this.types =
        json.asList<RechargeTypeModel>('types', RechargeTypeModel.toBean);
    this.updatedAt = json.asString('updatedAt');
    this.vipCardId = json.asInt('vipCardId');
    this.buyGroupNot = json.asBool('buyGroupNot');
  }

  static GroupMembersModel toBean(Map<String, dynamic> json) =>
      GroupMembersModel.fromJson(json);
}

class Participants {
  String? logo;
  String? nickName;
  int? userId;

  Participants({
    this.logo,
    this.nickName,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('logo', this.logo)
      ..put('nickName', this.nickName)
      ..put('userId', this.userId);
  }

  Participants.fromJson(Map<String, dynamic> json) {
    this.logo = json.asString('logo');
    this.nickName = json.asString('nickName');
    this.userId = json.asInt('userId');
  }
}
