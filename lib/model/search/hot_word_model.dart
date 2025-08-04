
import 'package:json2dart_safe/json2dart.dart';

class HotWordModel{
  String? id;
  int? sortNum;
  String? hotTitle;
  String? coverImg;
  String? mark;
  int? hotValue;
  int? videoMark;
  String? createdAt;
  String? updatedAt;

  HotWordModel({this.id,this.sortNum,this.hotTitle,this.coverImg,this.mark,this.hotValue,this.videoMark,this.createdAt,this.updatedAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id',this.id)
      ..put('sortNum',this.sortNum)
      ..put('hotTitle',this.hotTitle)
      ..put('coverImg',this.coverImg)
      ..put('mark',this.mark)
      ..put('hotValue',this.hotValue)
      ..put('videoMark',this.videoMark)
      ..put('createdAt',this.createdAt)
      ..put('updatedAt',this.updatedAt);
  }

  HotWordModel.fromJson(Map<String, dynamic> json) {
    this.id=json.asString('id');
    this.sortNum=json.asInt('sortNum');
    this.hotTitle=json.asString('hotTitle');
    this.coverImg=json.asString('coverImg');
    this.mark=json.asString('mark');
    this.hotValue=json.asInt('hotValue');
    this.videoMark=json.asInt('videoMark');
    this.createdAt=json.asString('createdAt');
    this.updatedAt=json.asString('updatedAt');
  }

  static HotWordModel toBean(Map<String, dynamic> json) => HotWordModel.fromJson(json);
}

