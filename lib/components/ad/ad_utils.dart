import 'dart:math';

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:xhs_app/services/storage_service.dart';

import 'ad_enum.dart';
import 'ad_info_model.dart';

class AdUtils {
  static final _random = Random();
  //单例模式
  static final AdUtils _instance = AdUtils._internal();

  factory AdUtils() {
    return _instance;
  }

  AdUtils._internal();

  List<AdInfoModel> get ads => Get.find<StorageService>().ads ?? [];

  final adModelIndex = -1;

  bool isAdModelIndex(int i) => i == adModelIndex;

  /// 根据类型获取权重
  AdInfoModel? getAdInfo(AdApiType type) => getAdInfos(type, 1).firstOrNull;

  /// 根据类型获取权重，随机取 n 个不重复的广告
  List<AdInfoModel> getAdInfos(AdApiType type, int n) {
    if (type == AdApiType.INVALID) return [];
    if (ads.isEmpty) return [];
    var result = ads.where((e) => e.adPlace == type.name).toList();
    if (result.isEmpty) return [];
    List<AdInfoModel> selected = [];
    n = n.clamp(0, result.length);
    // 需要n个，没有这么多，直接shuffle返回
    if (n >= result.length) {
      result.shuffle(_random);
      return result;
    }
    for (int i = 0; i < n; i++) {
      // 不需要排序 也不需要weights辅助
      // result.sort(
      //     (a, b) => (a.importanceNum ?? 0).compareTo((b.importanceNum ?? 0)));
      // final weights = result.map((e) => e.importanceNum ?? 0).toList();
      final total =
          result.fold<int>(0, (prev, e) => prev + (e.importanceNum ?? 0));
      final random = _random.nextInt(total);

      int tempSum = 0;
      int index = 0;
      for (; index < result.length; index++) {
        tempSum += (result[index].importanceNum ?? 0);
        if (tempSum > random) break;
      }
      selected.add(result[index]);
      result.removeAt(index);
    }
    return selected;
  }

  ///获取广告插入间隔的权重
  int getInsertWeight(AdApiType type) {
    if (ads.isEmpty) return 5;
    final item = ads.firstWhereOrNull((e) => e.adPlace == type.name);
    if (item == null) return 5;
    final num = item.insertIntervalsNum ?? 0;
    if (num == 0) return 5;
    return num;
  }

  ///根据顺序加载广告
  List<AdInfoModel> getAdLoadInOrder(AdApiType type) {
    if (ads.isEmpty) return [];
    final items = ads.where((e) => e.adPlace == type.name).toList();
    return items;
  }

  int withAdLength(int modelsLength, {required int interval}) {
    if (interval == 0) return modelsLength;
    return modelsLength + modelsLength ~/ interval;
  }

  dynamic modelByBuildIndex<T>(int buildIndex,
      {required List<T> models,
      required int interval,
      required AdApiType place}) {
    final modelIndex = buildIndexToModelIndex(buildIndex, interval: interval);
    final isAd = isAdModelIndex(modelIndex);
    return isAd ? place : models[modelIndex];
  }

  int buildIndexToModelIndex(int buildIndex, {required int interval}) {
    if (interval == 0) return buildIndex;
    if ((buildIndex + 1) % (interval + 1) == 0) {
      return adModelIndex;
    }
    return buildIndex - (buildIndex ~/ (interval + 1));
  }
}

final adHelper = AdUtils();
