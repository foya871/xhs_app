/*
 * @Author: ziqi z3ba1233@gmail.com
 * @Date: 2024-07-25 16:08:46
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-12-02 14:04:32
 * @FilePath: /xhs_app/lib/src/utils/initAdvertisementInfo.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:math';

import 'package:xhs_app/model/advertisements/ad_resp_model.dart';
import 'package:xhs_app/services/storage_service.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:get/get.dart';

// 判断是否过期
bool timeMillisecond(String time) {
  var timerStr = DateTime.parse(time);

  var endTime = timerStr.microsecondsSinceEpoch;

  var nowTime = DateTime.now().millisecondsSinceEpoch;

  return endTime > nowTime;
}

// final storageService = Get.find<StorageService>();
// //权重加载广告
// AdvertisementInfos? initWeightAdvertisementInfo(String adPlaceEnum) {
//   if (storageService.advertisement == null) return null;
//   //广告模型
//   final ads = AdRspModel.fromJson(
//       Map<String, dynamic>.from(storageService.advertisement));
//   //广告位置
//   final places = ads.advertisementPlaces ?? [];
//   if (!places.any((v) => v.adPlaceEnum == adPlaceEnum)) {
//     return null;
//   }
//   //所有广告
//   final items = ads.advertisementInfos;
//   //获取广告位置Id
//   final place = places.firstWhere((e) => e.adPlaceEnum == adPlaceEnum);
//   final placeId = place.id!;
//   //当前位置广告列表
//   List<AdvertisementInfos> result = [];
//   //权重列表
//   List<int> weights = [];
//   if (items != null) {
//     for (var i = 0; i < items.length; i++) {
//       //取出当前位置的广告
//       if (items[i].placeId == placeId) {
//         result.add(items[i]);
//         weights.add(
//             items[i].adWeight!.toInt() > 0 ? items[i].adWeight!.toInt() : i);
//       }
//     }
//   }
//   if (result.isEmpty) {
//     return null;
//   }
//   if (result.length == 1) {
//     return result.first;
//   }
//   //生成随机数
//   var random = Random().nextInt(weights.reduce((p, v) => p + v));
//   //随机数加入权重列表，升序排序
//   weights.add(random);
//   weights.sort((a, b) => a.compareTo(b));
//   //权重随机数在权重数组中的位置
//   var randomIndex = weights.indexOf(random);
//   //权重随机数下标不能超过当前位置广告列表长度-1，
//   randomIndex = min(randomIndex, result.length - 1);
//   return result[randomIndex];
// }

// //顺序加载广告
// List<AdvertisementInfos> initSequenceAdvertisementInfo(
//     AdPlaceEnum adPlaceEnum) {
//   if (storageService.advertisement == null) return [];
//   //广告模型
//   final ads = AdRspModel.fromJson(
//       Map<String, dynamic>.from(storageService.advertisement));
//   if (ads.advertisementInfos == null || ads.advertisementPlaces == null) {
//     return [];
//   }
//   //广告位置
//   if (ads.advertisementPlaces!.isEmpty) {
//     return [];
//   }
//   final places = ads.advertisementPlaces;
//   if (places == null || places.isEmpty) {
//     return [];
//   }
//   if (!places.any((v) => v.adPlaceEnum == adPlaceEnum)) {
//     return [];
//   }
//   //所有广告
//   final items = ads.advertisementInfos;
//   //获取广告位置Id
//   final placeId = places.firstWhere((e) => e.adPlaceEnum == adPlaceEnum).id;
//   //当前位置广告列表
//   List<AdvertisementInfos> result = [];
//   if (items != null) {
//     for (var i = 0; i < items.length; i++) {
//       //取出当前位置且的广告
//       if (items[i].placeId == placeId) {
//         result.add(items[i]);
//       }
//     }
//   }
//   return result;
// }

// int initRuleIntervalNum(String adPlaceEnum) {
//   if (storageService.advertisement == null) return 0;
//   //广告模型
//   final ads = AdRspModel.fromJson(
//       Map<String, dynamic>.from(storageService.advertisement));
//   //广告位置
//   final places = ads.advertisementPlaces ?? [];

//   if (!places.any((v) => v.adPlaceEnum == adPlaceEnum)) {
//     return 0;
//   }
//   //获取插入间隔数
//   final ruleIntervalNum =
//       places.firstWhere((e) => e.adPlaceEnum == adPlaceEnum).ruleIntervalNum;

//   return ruleIntervalNum ?? 0;
// }
