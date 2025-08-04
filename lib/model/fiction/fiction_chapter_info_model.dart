import 'package:json2dart_safe/json2dart.dart';

class FictionChapterInfoModel{
  String? domain;
  int? chapterId;
  String? chapterTitle;
  String? coverImg;
  String? backImg;
  String? fictionUrl;
  String? playPath;
  String? info;
  String? playTime;
  int? size;
  int? fictionType;
  int? fictionSpace;
  List<TagList>? tagList;
  List<ClassList>? classList;
  int? price;
  int? fakeLikes;
  int? fakeWatchTimes;
  int? commentNum;
  int? income;
  int? userId;
  bool? canWatch;
  String? reasonType;
  String? createdAt;
  String? updatedAt;

  FictionChapterInfoModel({this.domain,this.chapterId,this.chapterTitle,this.coverImg,this.backImg,this.fictionUrl,this.playPath,this.info,this.playTime,this.size,this.fictionType,this.fictionSpace,this.tagList,this.classList,this.price,this.fakeLikes,this.fakeWatchTimes,this.commentNum,this.income,this.userId,this.canWatch,this.reasonType,this.createdAt,this.updatedAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('domain',this.domain)
      ..put('chapterId',this.chapterId)
      ..put('chapterTitle',this.chapterTitle)
      ..put('coverImg',this.coverImg)
      ..put('backImg',this.backImg)
      ..put('fictionUrl',this.fictionUrl)
      ..put('playPath',this.playPath)
      ..put('info',this.info)
      ..put('playTime',this.playTime)
      ..put('size',this.size)
      ..put('fictionType',this.fictionType)
      ..put('fictionSpace',this.fictionSpace)
      ..put('tagList', this.tagList?.map((v)=>v.toJson()).toList())
      ..put('classList', this.classList?.map((v)=>v.toJson()).toList())
      ..put('price',this.price)
      ..put('fakeLikes',this.fakeLikes)
      ..put('fakeWatchTimes',this.fakeWatchTimes)
      ..put('commentNum',this.commentNum)
      ..put('income',this.income)
      ..put('userId',this.userId)
      ..put('canWatch',this.canWatch)
      ..put('reasonType',this.reasonType)
      ..put('createdAt',this.createdAt)
      ..put('updatedAt',this.updatedAt);
  }

  FictionChapterInfoModel.fromJson(Map<String, dynamic> json) {
    this.domain=json.asString('domain');
    this.chapterId=json.asInt('chapterId');
    this.chapterTitle=json.asString('chapterTitle');
    this.coverImg=json.asString('coverImg');
    this.backImg=json.asString('backImg');
    this.fictionUrl=json.asString('fictionUrl');
    this.playPath=json.asString('playPath');
    this.info=json.asString('info');
    this.playTime=json.asString('playTime');
    this.size=json.asInt('size');
    this.fictionType=json.asInt('fictionType');
    this.fictionSpace=json.asInt('fictionSpace');
    this.tagList=json.asList<TagList>('tagList',(v)=>TagList.fromJson(v as Map<String, dynamic>));
    this.classList=json.asList<ClassList>('classList',(v)=>ClassList.fromJson(v as Map<String, dynamic>));
    this.price=json.asInt('price');
    this.fakeLikes=json.asInt('fakeLikes');
    this.fakeWatchTimes=json.asInt('fakeWatchTimes');
    this.commentNum=json.asInt('commentNum');
    this.income=json.asInt('income');
    this.userId=json.asInt('userId');
    this.canWatch=json.asBool('canWatch');
    this.reasonType=json.asString('reasonType');
    this.createdAt=json.asString('createdAt');
    this.updatedAt=json.asString('updatedAt');
  }

  static FictionChapterInfoModel toBean(Map<String, dynamic> json) => FictionChapterInfoModel.fromJson(json);
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



