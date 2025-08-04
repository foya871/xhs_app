/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-27 12:51:46
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 18:32:39
 * @FilePath: /xhs_app/lib/model/community/collection_base_model.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:json2dart_safe/json2dart.dart';

class CollectionBaseModel {
  String? collectionCoverImg;
  int? collectionId;
  String? collectionName;
  String? createdAt;
  int? dynamicNum;
  int? sortNum;
  int? userId;
  bool? isSelected; 
  CollectionBaseModel({
    this.collectionCoverImg,
    this.collectionId,
    this.collectionName,
    this.createdAt,
    this.dynamicNum,
    this.sortNum,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('collectionCoverImg', this.collectionCoverImg)
      ..put('collectionId', this.collectionId)
      ..put('collectionName', this.collectionName)
      ..put('createdAt', this.createdAt)
      ..put('dynamicNum', this.dynamicNum)
      ..put('sortNum', this.sortNum)
      ..put('userId', this.userId)
      ..put('isSelected', this.isSelected);
  }

  CollectionBaseModel.fromJson(Map<String, dynamic> json) {
    this.collectionCoverImg = json.asString('collectionCoverImg');
    this.collectionId = json.asInt('collectionId');
    this.collectionName = json.asString('collectionName');
    this.createdAt = json.asString('createdAt');
    this.dynamicNum = json.asInt('dynamicNum');
    this.sortNum = json.asInt('sortNum');
    this.userId = json.asInt('userId');
    this.isSelected = json.asBool('isSelected');
  }

  static CollectionBaseModel toBean(Map<String, dynamic> json) =>
      CollectionBaseModel.fromJson(json);
}
