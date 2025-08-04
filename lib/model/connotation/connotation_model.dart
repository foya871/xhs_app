import 'package:json2dart_safe/json2dart.dart';

class ConnotationModel{
  String? checkAt;
  int? connotationId;
  String? coverImg;
  String? summary;
  String? title;

  ConnotationModel({this.checkAt,this.connotationId,this.coverImg,this.summary,this.title,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('checkAt',this.checkAt)
      ..put('connotationId',this.connotationId)
      ..put('coverImg',this.coverImg)
      ..put('summary',this.summary)
      ..put('title',this.title);
  }

ConnotationModel.fromJson(Map<String, dynamic> json) {
    this.checkAt=json.asString('checkAt');
    this.connotationId=json.asInt('connotationId');
    this.coverImg=json.asString('coverImg');
    this.summary=json.asString('summary');
    this.title=json.asString('title');
  }

static ConnotationModel toBean(Map<String, dynamic> json) => ConnotationModel.fromJson(json);
}