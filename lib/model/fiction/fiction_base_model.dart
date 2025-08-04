/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-25 13:08:27
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 17:41:44
 * @FilePath: /xhs_app/lib/model/fiction/FictionBaseModel.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';

///小说实体类

class FictionBaseModel {
  List<FictionBase>? data;
  String? domain;

  FictionBaseModel({
    this.data,
    this.domain,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('data', this.data?.map((v) => v.toJson()).toList())
      ..put('domain', this.domain);
  }

  FictionBaseModel.fromJson(Map<String, dynamic> json) {
    this.data = json.asList<FictionBase>(
        'data', (v) => FictionBase.fromJson(v as Map<String, dynamic>));
    this.domain = json.asString('domain');
  }

  static FictionBaseModel toBean(Map<String, dynamic> json) =>
      FictionBaseModel.fromJson(json);
}

class FictionBase {
  int? fictionId;
  String? fictionTitle;
  String? coverImg;
  int? fictionType;
  String? fictionSpace;
  List<TagList>? tagList;
  String? info;
  int? fakeLikes;
  int? fakeWatchTimes;
  int? chapterNewNum;
  bool? end;
  bool? watched;
  String? updatedAt;

  //前端
  AdApiType? ad;
  bool get isAd => ad != null;
  FictionBase.fromAd(this.ad) : fictionId = -987654321;

  FictionBase({
    this.fictionId,
    this.fictionTitle,
    this.coverImg,
    this.fictionType,
    this.fictionSpace,
    this.tagList,
    this.info,
    this.fakeLikes,
    this.fakeWatchTimes,
    this.chapterNewNum,
    this.end,
    this.watched,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('fictionId', this.fictionId)
      ..put('fictionTitle', this.fictionTitle)
      ..put('coverImg', this.coverImg)
      ..put('fictionType', this.fictionType)
      ..put('fictionSpace', this.fictionSpace)
      ..put('tagList', this.tagList?.map((v) => v.toJson()).toList())
      ..put('info', this.info)
      ..put('fakeLikes', this.fakeLikes)
      ..put('fakeWatchTimes', this.fakeWatchTimes)
      ..put('chapterNewNum', this.chapterNewNum)
      ..put('end', this.end)
      ..put('watched', this.watched)
      ..put('updatedAt', this.updatedAt);
  }

  FictionBase.fromJson(Map<String, dynamic> json) {
    this.fictionId = json.asInt('fictionId');
    this.fictionTitle = json.asString('fictionTitle');
    this.coverImg = json.asString('coverImg');
    this.fictionType = json.asInt('fictionType');
    this.fictionSpace = json.asString('fictionSpace');
    this.tagList = json.asList<TagList>(
        'tagList', (v) => TagList.fromJson(v as Map<String, dynamic>));
    this.info = json.asString('info');
    this.fakeLikes = json.asInt('fakeLikes');
    this.fakeWatchTimes = json.asInt('fakeWatchTimes');
    this.chapterNewNum = json.asInt('chapterNewNum');
    this.end = json.asBool('end');
    this.watched = json.asBool('watched');
    this.updatedAt = json.asString('updatedAt');
  }

  static FictionBase toBean(Map<String, dynamic> json) =>
      FictionBase.fromJson(json);
}

class TagList {
  int? tagId;
  String? title;

  TagList({
    this.tagId,
    this.title,
  });

  Map<dynamic, dynamic> toJson() {
    return Map<dynamic, dynamic>()
      ..put('tagId', this.tagId)
      ..put('title', this.title);
  }

  TagList.fromJson(Map<dynamic, dynamic> json) {
    this.tagId = json.asInt('tagId');
    this.title = json.asString('title');
  }
}
