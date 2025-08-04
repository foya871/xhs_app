import 'package:json2dart_safe/json2dart.dart';

class PublicationsVideosModel {
  List<String>? coverImg;
  int? coverImgMark;
  String? createdAt;
  int? fakeWatchNum;
  int? mark;
  int? playTime;
  int? price;
  String? reviewDate;
  String? notPass;
  String? title;
  List<String>? verticalImg;
  int? videoId;
  int? videoMark;
  int? videoType;

  PublicationsVideosModel({
    this.coverImg,
    this.coverImgMark,
    this.createdAt,
    this.fakeWatchNum,
    this.mark,
    this.playTime,
    this.price,
    this.reviewDate,
    this.title,
    this.verticalImg,
    this.videoId,
    this.videoMark,
    this.videoType,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('coverImg', this.coverImg)
      ..put('coverImgMark', this.coverImgMark)
      ..put('createdAt', this.createdAt)
      ..put('fakeWatchNum', this.fakeWatchNum)
      ..put('mark', this.mark)
      ..put('playTime', this.playTime)
      ..put('price', this.price)
      ..put('reviewDate', this.reviewDate)
      ..put('title', this.title)
      ..put('notPass', this.notPass)
      ..put('verticalImg', this.verticalImg)
      ..put('videoId', this.videoId)
      ..put('videoMark', this.videoMark)
      ..put('videoType', this.videoType);
  }

  PublicationsVideosModel.fromJson(Map<String, dynamic> json) {
    this.coverImg = json.asList<String>('coverImg', null);
    this.coverImgMark = json.asInt('coverImgMark');
    this.createdAt = json.asString('createdAt');
    this.fakeWatchNum = json.asInt('fakeWatchNum');
    this.mark = json.asInt('mark');
    this.playTime = json.asInt('playTime');
    this.price = json.asInt('price');
    this.reviewDate = json.asString('reviewDate');
    this.title = json.asString('title');
    this.notPass = json.asString('notPass');
    this.verticalImg = json.asList<String>('verticalImg', null);
    this.videoId = json.asInt('videoId');
    this.videoMark = json.asInt('videoMark');
    this.videoType = json.asInt('videoType');
  }

  static PublicationsVideosModel toBean(Map<String, dynamic> json) =>
      PublicationsVideosModel.fromJson(json);
}
