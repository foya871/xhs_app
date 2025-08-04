/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-20 23:07:21
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-02-22 09:50:00
 * @FilePath: /xhs_app/lib/components/pay/model/vip_gold_type_model.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/components/pay/model/chat_model.dart';

import 'gold_model.dart';
import 'vip_model.dart';

class VipGoldTypeModel {
  List<VipModel>? vipCardList;
  List<GoldModel>? goldVipList;
  List<ChatModel>? chatVipCardList;

  VipGoldTypeModel({this.vipCardList, this.goldVipList, this.chatVipCardList});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('vipCardList', vipCardList?.map((v) => v.toJson()).toList())
      ..put('goldVipList', goldVipList?.map((v) => v.toJson()).toList())
      ..put(
          'chatVipCardList', chatVipCardList?.map((v) => v.toJson()).toList());
  }

  VipGoldTypeModel.fromJson(Map<String, dynamic> json) {
    try {
      vipCardList = json.asList<VipModel>('vipCardList',
          (v) => VipModel.fromJson(Map<String, dynamic>.from(v)));
    } catch (e) {
    }
    try {
      goldVipList = json.asList<GoldModel>('goldVipList',
          (v) => GoldModel.fromJson(Map<String, dynamic>.from(v)));
    } catch (e) {
    }

    // chatVipCardList = json.asList<ChatModel>('chatVipCardList',
    //     (v) => ChatModel.fromJson(Map<String, dynamic>.from(v)));
  }

  static VipGoldTypeModel toBean(Map<String, dynamic> json) {
    return VipGoldTypeModel.fromJson(json);
  }
}
