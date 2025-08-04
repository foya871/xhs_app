import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';

class ProductDetailModel {
  String? id;
  int? productId;
  String? title;
  String? coverImg;
  List<BgImgs>? bgImgs;
  double? price;
  Classify? classify;
  int? goodsType;
  String? scene;
  String? detail;
  int? buyNum;
  int? status;
  int? sumIncome;
  int? sortNum;
  bool? videoCert;
  CertVideo? certVideo;
  dynamic belongsId;
  bool? isLike;
  String? createdAt;
  String? updatedAt;

  // 前端
  AdApiType? ad;
  bool get isAd => ad != null;
  ProductDetailModel.fromAd(this.ad) : id = '-987654321';

  ProductDetailModel({
    this.id,
    this.productId,
    this.title,
    this.coverImg,
    this.bgImgs,
    this.price,
    this.classify,
    this.goodsType,
    this.scene,
    this.detail,
    this.buyNum,
    this.status,
    this.sumIncome,
    this.sortNum,
    this.videoCert,
    this.certVideo,
    this.belongsId,
    this.isLike,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json.asString('id'),
      productId: json.asInt('productId'),
      title: json.asString('title'),
      coverImg: json.asString('coverImg'),
      bgImgs: json.asList<BgImgs>(
          'bgImgs', (v) => BgImgs.fromJson(v as Map<String, dynamic>)),
      price: (json['price'] as num?)?.toDouble(),
      classify: json['classify'] == null
          ? null
          : Classify.fromJson(json['classify'] as Map<String, dynamic>),
      goodsType: json.asInt('goodsType'),
      scene: json.asString('scene'),
      detail: json.asString('detail'),
      buyNum: json.asInt('buyNum'),
      status: json.asInt('status'),
      sumIncome: json.asInt('sumIncome'),
      sortNum: json.asInt('sortNum'),
      videoCert: json.asBool('videoCert'),
      certVideo: json['certVideo'] == null
          ? null
          : CertVideo.fromJson(json['certVideo'] as Map<String, dynamic>),
      belongsId: json['belongsId'],
      isLike: json.asBool('isLike'),
      createdAt: json.asString('createdAt'),
      updatedAt: json.asString('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'coverImg': coverImg,
      'bgImgs': bgImgs?.map((e) => e.toJson()).toList(),
      'price': price,
      'classify': classify?.toJson(),
      'goodsType': goodsType,
      'scene': scene,
      'detail': detail,
      'buyNum': buyNum,
      'status': status,
      'sumIncome': sumIncome,
      'sortNum': sortNum,
      'videoCert': videoCert,
      'certVideo': certVideo?.toJson(),
      'belongsId': belongsId,
      'isLike': isLike,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class CertVideo {
  String? fileId;
  int? type;
  String? url;
  List<String>? coverImg;
  int? playTime;
  int? size;
  dynamic authKey;

  CertVideo({
    this.fileId,
    this.type,
    this.url,
    this.coverImg,
    this.playTime,
    this.size,
    this.authKey,
  });

  factory CertVideo.fromJson(Map<String, dynamic> json) {
    return CertVideo(
      fileId: json.asString('fileId'),
      type: json.asInt('type'),
      url: json.asString('url'),
      coverImg: json.asList<String>('coverImg', (v) => v.toString()),
      playTime: json.asInt('playTime'),
      size: json.asInt('size'),
      authKey: json['authKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileId': fileId,
      'type': type,
      'url': url,
      'coverImg': coverImg,
      'playTime': playTime,
      'size': size,
      'authKey': authKey,
    };
  }
}

class Classify {
  int? classifyId;
  String? classifyTitle;

  Classify({
    this.classifyId,
    this.classifyTitle,
  });

  factory Classify.fromJson(Map<String, dynamic> json) {
    return Classify(
      classifyId: json.asInt('classifyId'),
      classifyTitle: json.asString('classifyTitle'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classifyId': classifyId,
      'classifyTitle': classifyTitle,
    };
  }
}

class BgImgs {
  dynamic fileId;
  int? type;
  String? url;
  dynamic coverImg;
  dynamic playTime;
  dynamic size;
  dynamic authKey;

  BgImgs({
    this.fileId,
    this.type,
    this.url,
    this.coverImg,
    this.playTime,
    this.size,
    this.authKey,
  });

  factory BgImgs.fromJson(Map<String, dynamic> json) {
    return BgImgs(
      fileId: json['fileId'],
      type: json.asInt('type'),
      url: json.asString('url'),
      coverImg: json['coverImg'],
      playTime: json['playTime'],
      size: json['size'],
      authKey: json['authKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileId': fileId,
      'type': type,
      'url': url,
      'coverImg': coverImg,
      'playTime': playTime,
      'size': size,
      'authKey': authKey,
    };
  }
}
