/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-01 13:23:34
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 13:30:00
 * @FilePath: /xhs_app/lib/model/community/community_resource_model.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:json2dart_safe/json2dart.dart';

class CommunityResourceModel {
  String? classifyTitle;
  String? decompressPassword;
  String? extractionCode;
  List<String>? images; //图片
  String? info; //动态文本内容
  double? price; //价格

  String? resourcesTitle; //动态标题

  String? website; //动态类型:1-图文 2-视频

  CommunityResourceModel.fromJson(Map<String, dynamic> json) {
    classifyTitle = json.asString('classifyTitle');
    decompressPassword = json.asString('decompressPassword');
    extractionCode = json.asString('extractionCode');
    images = json.asList<String>('images');
    info = json.asString('info');
    price = json.asDouble('price');
    resourcesTitle = json.asString('resourcesTitle');
    website = json.asString('website');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('classifyTitle', classifyTitle)
      ..put('decompressPassword', decompressPassword)
      ..put('extractionCode', extractionCode)
      ..put('images', images)
      ..put('info', info)
      ..put('price', price)
      ..put('resourcesTitle', resourcesTitle)
      ..put('website', website);
  }

  static CommunityResourceModel toBean(dynamic json) =>
      CommunityResourceModel.fromJson(json);
}
