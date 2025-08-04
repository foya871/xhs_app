import 'package:xhs_app/components/ad/ad_enum.dart';

class IntensionMapBaseFindModel {
  int? connotationId;
  String? title;
  String? summary;
  String? coverImg;
  String? checkAt;

  // 前端
  AdApiType? ad;
  bool get isAd => ad != null;

  IntensionMapBaseFindModel.fromAd(this.ad) : connotationId = -987654321;

  IntensionMapBaseFindModel(
      {this.connotationId,
      this.title,
      this.summary,
      this.coverImg,
      this.checkAt});

  IntensionMapBaseFindModel.fromJson(Map<String, dynamic> json) {
    connotationId = json['connotationId'];
    title = json['title'];
    summary = json['summary'];
    coverImg = json['coverImg'];
    checkAt = json['checkAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connotationId'] = this.connotationId;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['coverImg'] = this.coverImg;
    data['checkAt'] = this.checkAt;
    return data;
  }
}
