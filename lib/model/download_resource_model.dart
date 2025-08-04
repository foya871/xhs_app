import 'package:json2dart_safe/json2dart.dart';

class DownloadResourceModel{
  int? bgUserId;
  String? bgUserName;
  bool? blogger;
  String? checkAt;
  String? classifyTitle;
  String? coverImg;
  String? createdAt;
  String? decompressPassword;
  String? extractionCode;
  int? gender;
  String? id;
  List<String>? images;
  double? income;
  int? incomeCount;
  String? info;
  String? logo;
  String? nickName;
  String? notPass;
  int? price;
  int? realIncome;
  int? realIncomeCount;
  int? resourcesId;
  int? resourcesMark;
  String? resourcesTitle;
  List<String>? searchTitle;
  int? status;
  String? updatedAt;
  int? userId;
  int? vipType;
  String? website;

  DownloadResourceModel({this.bgUserId,this.bgUserName,this.blogger,this.checkAt,this.classifyTitle,this.coverImg,this.createdAt,this.decompressPassword,this.extractionCode,this.gender,this.id,this.images,this.income,this.incomeCount,this.info,this.logo,this.nickName,this.notPass,this.price,this.realIncome,this.realIncomeCount,this.resourcesId,this.resourcesMark,this.resourcesTitle,this.searchTitle,this.status,this.updatedAt,this.userId,this.vipType,this.website,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('bgUserId',this.bgUserId)
      ..put('bgUserName',this.bgUserName)
      ..put('blogger',this.blogger)
      ..put('checkAt',this.checkAt)
      ..put('classifyTitle',this.classifyTitle)
      ..put('coverImg',this.coverImg)
      ..put('createdAt',this.createdAt)
      ..put('decompressPassword',this.decompressPassword)
      ..put('extractionCode',this.extractionCode)
      ..put('gender',this.gender)
      ..put('id',this.id)
      ..put('images',this.images)
      ..put('income',this.income)
      ..put('incomeCount',this.incomeCount)
      ..put('info',this.info)
      ..put('logo',this.logo)
      ..put('nickName',this.nickName)
      ..put('notPass',this.notPass)
      ..put('price',this.price)
      ..put('realIncome',this.realIncome)
      ..put('realIncomeCount',this.realIncomeCount)
      ..put('resourcesId',this.resourcesId)
      ..put('resourcesMark',this.resourcesMark)
      ..put('resourcesTitle',this.resourcesTitle)
      ..put('searchTitle',this.searchTitle)
      ..put('status',this.status)
      ..put('updatedAt',this.updatedAt)
      ..put('userId',this.userId)
      ..put('vipType',this.vipType)
      ..put('website',this.website);
  }

DownloadResourceModel.fromJson(Map<String, dynamic> json) {
    this.bgUserId=json.asInt('bgUserId');
    this.bgUserName=json.asString('bgUserName');
    this.blogger=json.asBool('blogger');
    this.checkAt=json.asString('checkAt');
    this.classifyTitle=json.asString('classifyTitle');
    this.coverImg=json.asString('coverImg');
    this.createdAt=json.asString('createdAt');
    this.decompressPassword=json.asString('decompressPassword');
    this.extractionCode=json.asString('extractionCode');
    this.gender=json.asInt('gender');
    this.id=json.asString('id');
  this.images=json.asList<String>('images',null);
    this.income=json.asDouble('income');
    this.incomeCount=json.asInt('incomeCount');
    this.info=json.asString('info');
    this.logo=json.asString('logo');
    this.nickName=json.asString('nickName');
    this.notPass=json.asString('notPass');
    this.price=json.asInt('price');
    this.realIncome=json.asInt('realIncome');
    this.realIncomeCount=json.asInt('realIncomeCount');
    this.resourcesId=json.asInt('resourcesId');
    this.resourcesMark=json.asInt('resourcesMark');
    this.resourcesTitle=json.asString('resourcesTitle');
  this.searchTitle=json.asList<String>('searchTitle',null);
    this.status=json.asInt('status');
    this.updatedAt=json.asString('updatedAt');
    this.userId=json.asInt('userId');
    this.vipType=json.asInt('vipType');
    this.website=json.asString('website');
  }

static DownloadResourceModel toBean(Map<String, dynamic> json) => DownloadResourceModel.fromJson(json);
}