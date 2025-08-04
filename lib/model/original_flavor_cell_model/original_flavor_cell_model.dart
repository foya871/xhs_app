import 'package:json2dart_safe/json2dart.dart';
import 'cert_video.dart';

class OriginalFlavorCellModel {
  int? belongsId;
  String? belongsLogo;
  String? belongsNickname;
  int? buyNum;
  CertVideo? certVideo;
  DateTime? createdAt;
  String? id;
  List<String>? images;
  bool? isOrigin;
  int? price;
  int? productId;
  int? sortNum;
  int? status;
  int? sumIncome;
  String? title;
  DateTime? updatedAt;
  bool? videoCert;

  OriginalFlavorCellModel({
    this.belongsId,
    this.belongsLogo,
    this.belongsNickname,
    this.buyNum,
    this.certVideo,
    this.createdAt,
    this.id,
    this.images,
    this.isOrigin,
    this.price,
    this.productId,
    this.sortNum,
    this.status,
    this.sumIncome,
    this.title,
    this.updatedAt,
    this.videoCert,
  });

  factory OriginalFlavorCellModel.fromJson(Map<String, dynamic> json) {
    return OriginalFlavorCellModel(
      belongsId: json.asInt('belongsId'),
      belongsLogo: json.asString('belongsLogo'),
      belongsNickname: json.asString('belongsNickname'),
      buyNum: json.asInt('buyNum'),
      certVideo: json['certVideo'] == null
          ? null
          : CertVideo.fromJson(json['certVideo'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json.asString('createdAt') ?? ''),
      id: json.asString('id'),
      images: json.asList<String>('images', (v) => v.toString()),
      isOrigin: json.asBool('isOrigin'),
      price: json.asInt('price'),
      productId: json.asInt('productId'),
      sortNum: json.asInt('sortNum'),
      status: json.asInt('status'),
      sumIncome: json.asInt('sumIncome'),
      title: json.asString('title'),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json.asString('updatedAt') ?? ''),
      videoCert: json.asBool('videoCert'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'belongsId': belongsId,
      'belongsLogo': belongsLogo,
      'belongsNickname': belongsNickname,
      'buyNum': buyNum,
      'certVideo': certVideo?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'id': id,
      'images': images,
      'isOrigin': isOrigin,
      'price': price,
      'productId': productId,
      'sortNum': sortNum,
      'status': status,
      'sumIncome': sumIncome,
      'title': title,
      'updatedAt': updatedAt?.toIso8601String(),
      'videoCert': videoCert,
    };
  }
}
