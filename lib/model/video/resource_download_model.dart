import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';

class ResourceDownloadModel {
  int? total;
  List<ResourceInfo>? data;
  String? domain;

  ResourceDownloadModel({
    this.total,
    this.data,
    this.domain,
  });

  factory ResourceDownloadModel.fromJson(Map<String, dynamic> json) {
    return ResourceDownloadModel(
      total: json.asInt('total'),
      data: json.asList<ResourceInfo>(
          'data', (v) => ResourceInfo.fromJson(v as Map<String, dynamic>)),
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

class ResourceInfo {
  String? id;
  int? resourcesId;
  String? resourcesTitle;
  List<String>? searchTitle;
  int? userId;
  String? nickName;
  bool? blogger;
  String? logo;
  int? gender;
  int? vipType;
  int? resourcesMark;
  String? classifyTitle;
  String? info;
  int? price;
  String? website;
  String? extractionCode;
  String? decompressPassword;
  String? coverImg;
  List<String>? images;
  int? status;
  dynamic notPass;
  int? bgUserId;
  String? bgUserName;
  String? checkAt;
  double? income;
  int? incomeCount;
  int? realIncomeCount;
  int? realIncome;
  bool? unlock;
  String? createdAt;
  String? updatedAt;

  // 前端
  AdApiType? ad;

  bool get isAd => ad != null;

  ResourceInfo({
    this.id,
    this.resourcesId,
    this.resourcesTitle,
    this.searchTitle,
    this.userId,
    this.nickName,
    this.blogger,
    this.logo,
    this.gender,
    this.vipType,
    this.resourcesMark,
    this.classifyTitle,
    this.info,
    this.price,
    this.website,
    this.extractionCode,
    this.decompressPassword,
    this.coverImg,
    this.images,
    this.status,
    this.notPass,
    this.bgUserId,
    this.bgUserName,
    this.checkAt,
    this.income,
    this.incomeCount,
    this.realIncomeCount,
    this.realIncome,
    this.unlock,
    this.createdAt,
    this.updatedAt,
  });

  ResourceInfo.fromAd(this.ad) : id = '-987654321';

  factory ResourceInfo.fromJson(Map<String, dynamic> json) {
    return ResourceInfo(
      id: json.asString('id'),
      resourcesId: json.asInt('resourcesId'),
      resourcesTitle: json.asString('resourcesTitle'),
      searchTitle: json.asList<String>('searchTitle', (v) => v.toString()),
      userId: json.asInt('userId'),
      nickName: json.asString('nickName'),
      blogger: json.asBool('blogger'),
      logo: json.asString('logo'),
      gender: json.asInt('gender'),
      vipType: json.asInt('vipType'),
      resourcesMark: json.asInt('resourcesMark'),
      classifyTitle: json.asString('classifyTitle'),
      info: json.asString('info'),
      price: json.asInt('price'),
      website: json.asString('website'),
      extractionCode: json.asString('extractionCode'),
      decompressPassword: json.asString('decompressPassword'),
      coverImg: json.asString('coverImg'),
      images: json.asList<String>('images', (v) => v.toString()),
      status: json.asInt('status'),
      notPass: json['notPass'],
      bgUserId: json.asInt('bgUserId'),
      bgUserName: json.asString('bgUserName'),
      checkAt: json.asString('checkAt'),
      income: (json['income'] as num?)?.toDouble(),
      incomeCount: json.asInt('incomeCount'),
      realIncomeCount: json.asInt('realIncomeCount'),
      realIncome: json.asInt('realIncome'),
      unlock: json.asBool('unlock'),
      createdAt: json.asString('createdAt'),
      updatedAt: json.asString('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resourcesId': resourcesId,
      'resourcesTitle': resourcesTitle,
      'searchTitle': searchTitle,
      'userId': userId,
      'nickName': nickName,
      'blogger': blogger,
      'logo': logo,
      'gender': gender,
      'vipType': vipType,
      'resourcesMark': resourcesMark,
      'classifyTitle': classifyTitle,
      'info': info,
      'price': price,
      'website': website,
      'extractionCode': extractionCode,
      'decompressPassword': decompressPassword,
      'coverImg': coverImg,
      'images': images,
      'status': status,
      'notPass': notPass,
      'bgUserId': bgUserId,
      'bgUserName': bgUserName,
      'checkAt': checkAt,
      'income': income,
      'incomeCount': incomeCount,
      'realIncomeCount': realIncomeCount,
      'realIncome': realIncome,
      'unlock': unlock,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
