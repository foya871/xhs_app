import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/model/comics/comics_chapter.dart';

class ComicsDetailsModel {
  String? authorName;
  String? backImg;
  List<ComicsChapterModel>? chapterList;
  int? chapterNewNum;
  List<ClassList>? classList;
  int? comicsId;
  String? comicsTitle;
  String? coverImg;
  String? createdAt;
  String? domain;
  int? fakeLikes;
  int? fakeWatchTimes;
  String? info;
  bool? isEnd;
  bool? isLike;
  int? lastReadChapterId;
  String? logo;
  String? nickName;
  List<StationList>? stationList;
  List<TagList>? tagList;
  String? updatedAt;
  int? userId;
  bool? isBooking;

  ComicsDetailsModel(
      {this.authorName,
      this.backImg,
      this.chapterList,
      this.chapterNewNum,
      this.classList,
      this.comicsId,
      this.comicsTitle,
      this.coverImg,
      this.createdAt,
      this.domain,
      this.fakeLikes,
      this.fakeWatchTimes,
      this.info,
      this.isEnd,
      this.isLike,
      this.lastReadChapterId,
      this.logo,
      this.nickName,
      this.stationList,
      this.tagList,
      this.updatedAt,
      this.userId,
      this.isBooking});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('authorName', this.authorName)
      ..put('backImg', this.backImg)
      ..put('chapterList', this.chapterList?.map((v) => v.toJson()).toList())
      ..put('chapterNewNum', this.chapterNewNum)
      ..put('classList', this.classList?.map((v) => v.toJson()).toList())
      ..put('comicsId', this.comicsId)
      ..put('comicsTitle', this.comicsTitle)
      ..put('coverImg', this.coverImg)
      ..put('createdAt', this.createdAt)
      ..put('domain', this.domain)
      ..put('fakeLikes', this.fakeLikes)
      ..put('fakeWatchTimes', this.fakeWatchTimes)
      ..put('info', this.info)
      ..put('isEnd', this.isEnd)
      ..put('isLike', this.isLike)
      ..put('lastReadChapterId', this.lastReadChapterId)
      ..put('logo', this.logo)
      ..put('nickName', this.nickName)
      ..put('stationList', this.stationList?.map((v) => v.toJson()).toList())
      ..put('tagList', this.tagList?.map((v) => v.toJson()).toList())
      ..put('updatedAt', this.updatedAt)
      ..put('userId', this.userId)
      ..put('isBooking', this.isBooking);
  }

  ComicsDetailsModel.fromJson(Map<String, dynamic> json) {
    this.authorName = json.asString('authorName');
    this.backImg = json.asString('backImg');
    this.chapterList = json.asList<ComicsChapterModel>('chapterList',
        (v) => ComicsChapterModel.fromJson(Map<String, dynamic>.from(v)));
    this.chapterNewNum = json.asInt('chapterNewNum');
    this.classList = json.asList<ClassList>(
        'classList', (v) => ClassList.fromJson(Map<String, dynamic>.from(v)));
    this.comicsId = json.asInt('comicsId');
    this.comicsTitle = json.asString('comicsTitle');
    this.coverImg = json.asString('coverImg');
    this.createdAt = json.asString('createdAt');
    this.domain = json.asString('domain');
    this.fakeLikes = json.asInt('fakeLikes');
    this.fakeWatchTimes = json.asInt('fakeWatchTimes');
    this.info = json.asString('info');
    this.isEnd = json.asBool('isEnd');
    this.isLike = json.asBool('isLike');
    this.lastReadChapterId = json.asInt('lastReadChapterId');
    this.logo = json.asString('logo');
    this.nickName = json.asString('nickName');
    this.stationList = json.asList<StationList>('stationList',
        (v) => StationList.fromJson(Map<String, dynamic>.from(v)));
    this.tagList = json.asList<TagList>(
        'tagList', (v) => TagList.fromJson(Map<String, dynamic>.from(v)));
    this.updatedAt = json.asString('updatedAt');
    this.userId = json.asInt('userId');
    this.isBooking = json.asBool('isBooking');
  }

  static ComicsDetailsModel toBean(Map<String, dynamic> json) =>
      ComicsDetailsModel.fromJson(json);
}

class ChapterList {
  int? chapterId;
  int? chapterNum;
  String? chapterTitle;
  int? comicsId;
  String? coverImg;
  String? createdAt;
  int? fakeWatchTimes;

  ChapterList({
    this.chapterId,
    this.chapterNum,
    this.chapterTitle,
    this.comicsId,
    this.coverImg,
    this.createdAt,
    this.fakeWatchTimes,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('chapterId', this.chapterId)
      ..put('chapterNum', this.chapterNum)
      ..put('chapterTitle', this.chapterTitle)
      ..put('comicsId', this.comicsId)
      ..put('coverImg', this.coverImg)
      ..put('createdAt', this.createdAt)
      ..put('fakeWatchTimes', this.fakeWatchTimes);
  }

  ChapterList.fromJson(Map<String, dynamic> json) {
    this.chapterId = json.asInt('chapterId');
    this.chapterNum = json.asInt('chapterNum');
    this.chapterTitle = json.asString('chapterTitle');
    this.comicsId = json.asInt('comicsId');
    this.coverImg = json.asString('coverImg');
    this.createdAt = json.asString('createdAt');
    this.fakeWatchTimes = json.asInt('fakeWatchTimes');
  }
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
