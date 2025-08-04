/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-10-10 18:59:36
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-10-31 19:36:50
 * @FilePath: /xhs_app/lib/src/model/comics/comics_chapter.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:json2dart_safe/json2dart.dart';

class ComicsChapterModel {
  bool? canWatch;
  int? chapterId;
  int? chapterNum;
  String? chapterTitle;
  int? comicsId;
  String? coverImg;
  String? createdAt;
  String? domain;
  List<String>? imgList;
  String? info;
  int? reasonType;
  String? updatedAt;
  int? userId;
  int? price;
  int? watchCondition;

  ComicsChapterModel(
      {this.canWatch,
      this.chapterId,
      this.chapterNum,
      this.chapterTitle,
      this.comicsId,
      this.coverImg,
      this.createdAt,
      this.domain,
      this.imgList,
      this.info,
      this.reasonType,
      this.updatedAt,
      this.userId,
      this.watchCondition,
      this.price});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('canWatch', this.canWatch)
      ..put('chapterId', this.chapterId)
      ..put('chapterNum', this.chapterNum)
      ..put('chapterTitle', this.chapterTitle)
      ..put('comicsId', this.comicsId)
      ..put('coverImg', this.coverImg)
      ..put('createdAt', this.createdAt)
      ..put('domain', this.domain)
      ..put('imgList', this.imgList)
      ..put('info', this.info)
      ..put('reasonType', this.reasonType)
      ..put('updatedAt', this.updatedAt)
      ..put('userId', this.userId)
      ..put('price', this.price)
      ..put('watchCondition', this.watchCondition);
  }

  ComicsChapterModel.fromJson(Map<String, dynamic> json) {
    this.canWatch = json.asBool('canWatch');
    this.chapterId = json.asInt('chapterId');
    this.chapterNum = json.asInt('chapterNum');
    this.chapterTitle = json.asString('chapterTitle');
    this.comicsId = json.asInt('comicsId');
    this.coverImg = json.asString('coverImg');
    this.createdAt = json.asString('createdAt');
    this.domain = json.asString('domain');
    this.imgList = json.asList<String>('imgList', null);
    this.info = json.asString('info');
    this.reasonType = json.asInt('reasonType');
    this.updatedAt = json.asString('updatedAt');
    this.userId = json.asInt('userId');
    this.price = json.asInt('price');
    this.watchCondition = json.asInt('watchCondition');
  }

  static ComicsChapterModel toBean(Map<String, dynamic> json) =>
      ComicsChapterModel.fromJson(json);
}
