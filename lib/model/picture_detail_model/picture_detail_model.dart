import 'package:json2dart_safe/json2dart.dart';

class PictureDetailModel {
  bool? canWatch;
  String? coverImg;
  int? fakeWatchTimes;
  List<String>? imgList;
  int? imgNum;
  int? picType;
  int? portrayPicId;
  int? price;
  int? reasonType;
  bool? recommend;
  String? title;

  PictureDetailModel({
    this.canWatch,
    this.coverImg,
    this.fakeWatchTimes,
    this.imgList,
    this.imgNum,
    this.picType,
    this.portrayPicId,
    this.price,
    this.reasonType,
    this.recommend,
    this.title,
  });

  factory PictureDetailModel.fromJson(Map<String, dynamic> json) {
    return PictureDetailModel(
      canWatch: json.asBool('canWatch'),
      coverImg: json.asString('coverImg'),
      fakeWatchTimes: json.asInt('fakeWatchTimes'),
      imgList: json.asList<String>('imgList', (v) => v.toString()),
      imgNum: json.asInt('imgNum'),
      picType: json.asInt('picType'),
      portrayPicId: json.asInt('portrayPicId'),
      price: json.asInt('price'),
      reasonType: json.asInt('reasonType'),
      recommend: json.asBool('recommend'),
      title: json.asString('title'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'canWatch': canWatch,
      'coverImg': coverImg,
      'fakeWatchTimes': fakeWatchTimes,
      'imgList': imgList,
      'imgNum': imgNum,
      'picType': picType,
      'portrayPicId': portrayPicId,
      'price': price,
      'reasonType': reasonType,
      'recommend': recommend,
      'title': title,
    };
  }
}
