import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';

class PictureCellModel {
  String? coverImg;
  int? imgNum;
  int? picType;
  int? portrayPicId;
  int? price;
  String? title;

  // 前端
  AdApiType? ad;
  bool get isAd => ad != null;

  PictureCellModel.fromAd(this.ad) : portrayPicId = -987654321;

  PictureCellModel({
    this.coverImg,
    this.imgNum,
    this.picType,
    this.portrayPicId,
    this.price,
    this.title,
  });

  factory PictureCellModel.fromJson(Map<String, dynamic> json) {
    return PictureCellModel(
      coverImg: json.asString('coverImg'),
      imgNum: json.asInt('imgNum'),
      picType: json.asInt('picType'),
      portrayPicId: json.asInt('portrayPicId'),
      price: json.asInt('price'),
      title: json.asString('title'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coverImg': coverImg,
      'imgNum': imgNum,
      'picType': picType,
      'portrayPicId': portrayPicId,
      'price': price,
      'title': title,
    };
  }
}
