import 'package:json2dart_safe/json2dart.dart';

class RecordModel{
  String? createdAt;
  int? currencyType;
  int? freeGoldNum;
  int? money;
  int? payType;
  int? purType;
  String? remark;
  String? title;
  int? tnumber;
  String? tradeNo;
  String? updatedAt;
  int? userId;
  int? vipNumber;

  RecordModel({this.createdAt,this.currencyType,this.freeGoldNum,this.money,this.payType,this.purType,this.remark,this.title,this.tnumber,this.tradeNo,this.updatedAt,this.userId,this.vipNumber,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('createdAt',this.createdAt)
      ..put('currencyType',this.currencyType)
      ..put('freeGoldNum',this.freeGoldNum)
      ..put('money',this.money)
      ..put('payType',this.payType)
      ..put('purType',this.purType)
      ..put('remark',this.remark)
      ..put('title',this.title)
      ..put('tnumber',this.tnumber)
      ..put('tradeNo',this.tradeNo)
      ..put('updatedAt',this.updatedAt)
      ..put('userId',this.userId)
      ..put('vipNumber',this.vipNumber);
  }

RecordModel.fromJson(Map<String, dynamic> json) {
    this.createdAt=json.asString('createdAt');
    this.currencyType=json.asInt('currencyType');
    this.freeGoldNum=json.asInt('freeGoldNum');
    this.money=json.asInt('money');
    this.payType=json.asInt('payType');
    this.purType=json.asInt('purType');
    this.remark=json.asString('remark');
    this.title=json.asString('title');
    this.tnumber=json.asInt('tnumber');
    this.tradeNo=json.asString('tradeNo');
    this.updatedAt=json.asString('updatedAt');
    this.userId=json.asInt('userId');
    this.vipNumber=json.asInt('vipNumber');
  }

static RecordModel toBean(Map<String, dynamic> json) => RecordModel.fromJson(json);
}