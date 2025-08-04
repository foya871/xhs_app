import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';

class ComicsBaseModel {
  String? authorName;
  String? backImg;
  int? chapterNewNum;
  List<ClassList>? classList;
  int? comicsId;
  String? comicsTitle;
  String? coverImg;
  String? createdAt;
  int? fakeLikes;
  int? fakeWatchTimes;
  String? id;
  String? info;
  bool? isEnd;
  String? logo;
  String? nickName;
  int? realLikes;
  int? realWatchTimes;
  bool? recommend;
  List<StationList>? stationList;
  int? stationSort;
  int? status;
  List<TagList>? tagList;
  String? updatedAt;
  int? userId;

  // 前端
  AdApiType? ad;
  bool get isAd => ad != null;
  ComicsBaseModel.fromAd(this.ad) : id = '-987654321';

  ComicsBaseModel({
    this.authorName,
    this.backImg,
    this.chapterNewNum,
    this.classList,
    this.comicsId,
    this.comicsTitle,
    this.coverImg,
    this.createdAt,
    this.fakeLikes,
    this.fakeWatchTimes,
    this.id,
    this.info,
    this.isEnd,
    this.logo,
    this.nickName,
    this.realLikes,
    this.realWatchTimes,
    this.recommend,
    this.stationList,
    this.stationSort,
    this.status,
    this.tagList,
    this.updatedAt,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('authorName', this.authorName)
      ..put('backImg', this.backImg)
      ..put('chapterNewNum', this.chapterNewNum)
      ..put('classList', this.classList?.map((v) => v.toJson()).toList())
      ..put('comicsId', this.comicsId)
      ..put('comicsTitle', this.comicsTitle)
      ..put('coverImg', this.coverImg)
      ..put('createdAt', this.createdAt)
      ..put('fakeLikes', this.fakeLikes)
      ..put('fakeWatchTimes', this.fakeWatchTimes)
      ..put('id', this.id)
      ..put('info', this.info)
      ..put('isEnd', this.isEnd)
      ..put('logo', this.logo)
      ..put('nickName', this.nickName)
      ..put('realLikes', this.realLikes)
      ..put('realWatchTimes', this.realWatchTimes)
      ..put('recommend', this.recommend)
      ..put('stationList', this.stationList?.map((v) => v.toJson()).toList())
      ..put('stationSort', this.stationSort)
      ..put('status', this.status)
      ..put('tagList', this.tagList?.map((v) => v.toJson()).toList())
      ..put('updatedAt', this.updatedAt)
      ..put('userId', this.userId);
  }

  ComicsBaseModel.fromJson(Map<String, dynamic> json) {
    this.authorName = json.asString('authorName');
    this.backImg = json.asString('backImg');
    this.chapterNewNum = json.asInt('chapterNewNum');
    this.classList = json.asList<ClassList>(
        'classList', (v) => ClassList.fromJson(Map<String, dynamic>.from(v)));
    this.comicsId = json.asInt('comicsId');
    this.comicsTitle = json.asString('comicsTitle');
    this.coverImg = json.asString('coverImg');
    this.createdAt = json.asString('createdAt');
    this.fakeLikes = json.asInt('fakeLikes');
    this.fakeWatchTimes = json.asInt('fakeWatchTimes');
    this.id = json.asString('id');
    this.info = json.asString('info');
    this.isEnd = json.asBool('isEnd');
    this.logo = json.asString('logo');
    this.nickName = json.asString('nickName');
    this.realLikes = json.asInt('realLikes');
    this.realWatchTimes = json.asInt('realWatchTimes');
    this.recommend = json.asBool('recommend');
    this.stationList = json.asList<StationList>('stationList',
        (v) => StationList.fromJson(Map<String, dynamic>.from(v)));
    this.stationSort = json.asInt('stationSort');
    this.status = json.asInt('status');
    this.tagList = json.asList<TagList>(
        'tagList', (v) => TagList.fromJson(Map<String, dynamic>.from(v)));
    this.updatedAt = json.asString('updatedAt');
    this.userId = json.asInt('userId');
  }

  static ComicsBaseModel toBean(Map<String, dynamic> json) =>
      ComicsBaseModel.fromJson(json);
}

class ClassList {
  int? classId;
  String? title;

  ClassList({
    this.classId,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('classId', this.classId)
      ..put('title', this.title);
  }

  ClassList.fromJson(Map<String, dynamic> json) {
    this.classId = json.asInt('classId');
    this.title = json.asString('title');
  }
}

class StationList {
  int? stationId;
  String? stationName;

  StationList({
    this.stationId,
    this.stationName,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('stationId', this.stationId)
      ..put('stationName', this.stationName);
  }

  StationList.fromJson(Map<String, dynamic> json) {
    this.stationId = json.asInt('stationId');
    this.stationName = json.asString('stationName');
  }
}

class TagList {
  int? tagId;
  String? title;

  TagList({
    this.tagId,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('tagId', this.tagId)
      ..put('title', this.title);
  }

  TagList.fromJson(Map<String, dynamic> json) {
    this.tagId = json.asInt('tagId');
    this.title = json.asString('title');
  }
}
