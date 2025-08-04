import 'package:json2dart_safe/json2dart.dart';

class FictionInfoModel{
  String? domain;
  int? fictionId;
  String? fictionTitle;
  String? coverImg;
  String? backImg;
  int? fictionType;
  int? fictionSpace;
  List<TagList>? tagList;
  List<ClassList>? classList;
  String? authorName;
  String? anchor;
  String? info;
  List<Chapters>? chapters;
  int? price;
  int? fakeLikes;
  int? fakeWatchTimes;
  int? commentNum;
  int? income;
  int? userId;
  String? nickName;
  String? logo;
  bool? isLike;
  String? lastReadChapterId;
  String? createdAt;
  String? updatedAt;

  FictionInfoModel({this.domain,this.fictionId,this.fictionTitle,this.coverImg,this.backImg,this.fictionType,this.fictionSpace,this.tagList,this.classList,this.authorName,this.anchor,this.info,this.chapters,this.price,this.fakeLikes,this.fakeWatchTimes,this.commentNum,this.income,this.userId,this.nickName,this.logo,this.isLike,this.lastReadChapterId,this.createdAt,this.updatedAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('domain',this.domain)
      ..put('fictionId',this.fictionId)
      ..put('fictionTitle',this.fictionTitle)
      ..put('coverImg',this.coverImg)
      ..put('backImg',this.backImg)
      ..put('fictionType',this.fictionType)
      ..put('fictionSpace',this.fictionSpace)
      ..put('tagList', this.tagList?.map((v)=>v.toJson()).toList())
      ..put('classList', this.classList?.map((v)=>v.toJson()).toList())
      ..put('authorName',this.authorName)
      ..put('anchor',this.anchor)
      ..put('info',this.info)
      ..put('chapters', this.chapters?.map((v)=>v.toJson()).toList())
      ..put('price',this.price)
      ..put('fakeLikes',this.fakeLikes)
      ..put('fakeWatchTimes',this.fakeWatchTimes)
      ..put('commentNum',this.commentNum)
      ..put('income',this.income)
      ..put('userId',this.userId)
      ..put('nickName',this.nickName)
      ..put('logo',this.logo)
      ..put('isLike',this.isLike)
      ..put('lastReadChapterId',this.lastReadChapterId)
      ..put('createdAt',this.createdAt)
      ..put('updatedAt',this.updatedAt);
  }

  FictionInfoModel.fromJson(Map<String, dynamic> json) {
    this.domain=json.asString('domain');
    this.fictionId=json.asInt('fictionId');
    this.fictionTitle=json.asString('fictionTitle');
    this.coverImg=json.asString('coverImg');
    this.backImg=json.asString('backImg');
    this.fictionType=json.asInt('fictionType');
    this.fictionSpace=json.asInt('fictionSpace');
    this.tagList=json.asList<TagList>('tagList',(v)=>TagList.fromJson(v as Map<String, dynamic>));
    this.classList=json.asList<ClassList>('classList',(v)=>ClassList.fromJson(v as Map<String, dynamic>));
    this.authorName=json.asString('authorName');
    this.anchor=json.asString('anchor');
    this.info=json.asString('info');
    this.chapters=json.asList<Chapters>('chapters',(v)=>Chapters.fromJson(v as Map<String, dynamic>));
    this.price=json.asInt('price');
    this.fakeLikes=json.asInt('fakeLikes');
    this.fakeWatchTimes=json.asInt('fakeWatchTimes');
    this.commentNum=json.asInt('commentNum');
    this.income=json.asInt('income');
    this.userId=json.asInt('userId');
    this.nickName=json.asString('nickName');
    this.logo=json.asString('logo');
    this.isLike=json.asBool('isLike');
    this.lastReadChapterId=json.asString('lastReadChapterId');
    this.createdAt=json.asString('createdAt');
    this.updatedAt=json.asString('updatedAt');
  }

  static FictionInfoModel toBean(Map<String, dynamic> json) => FictionInfoModel.fromJson(json);
}

class TagList{
  int? tagId;
  String? title;

  TagList({this.tagId,this.title,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('tagId',this.tagId)
      ..put('title',this.title);
  }

  TagList.fromJson(Map<String, dynamic> json) {
    this.tagId=json.asInt('tagId');
    this.title=json.asString('title');
  }
}

class ClassList{
  int? classId;
  String? title;

  ClassList({this.classId,this.title,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('classId',this.classId)
      ..put('title',this.title);
  }

  ClassList.fromJson(Map<String, dynamic> json) {
    this.classId=json.asInt('classId');
    this.title=json.asString('title');
  }
}

class Chapters{
  int? chapterId;
  String? chapterTitle;
  int? chapterNum;
  String? createdAt;

  Chapters({this.chapterId,this.chapterTitle,this.chapterNum,this.createdAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('chapterId',this.chapterId)
      ..put('chapterTitle',this.chapterTitle)
      ..put('chapterNum',this.chapterNum)
      ..put('createdAt',this.createdAt);
  }

  Chapters.fromJson(Map<String, dynamic> json) {
    this.chapterId=json.asInt('chapterId');
    this.chapterTitle=json.asString('chapterTitle');
    this.chapterNum=json.asInt('chapterNum');
    this.createdAt=json.asString('createdAt');
  }
}