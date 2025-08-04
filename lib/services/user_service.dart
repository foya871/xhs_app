import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xhs_app/model/community/city_list_model.dart';
import 'package:xhs_app/model/community/province_list_model.dart';
import 'package:xhs_app/services/storage_service.dart';

import '../http/service/api_service.dart';
import '../model/user/user_assets_model.dart';
import '../model/user/user_info_model.dart';
import '../utils/enum.dart';
import '../utils/logger.dart';

class UserService extends GetxService with ChangeNotifier {
  Completer<bool>? _updateAllCompleter;

//用户信息
  final _userInfo = UserInfo.fromJson({}).obs;

  /////防止乱几把篡改 所以这里用get方法
  bool get isVIP => _userInfo.value.vipType! > 0;
  bool get isChatVIP => _userInfo.value.chatVipType! > 0;

  ///是否能看禁区
  bool get canWatchSmallWorld =>
      _userInfo.value.vipType == 10 || _userInfo.value.vipType == 11;

  String get token => _userInfo.value.token!;

  String get imageDomain => _userInfo.value.imgDomain!;

  UserInfo get user => _userInfo.value;

  bool checkGold(num gold) => assets.gold! >= gold;

  AiCostType checkAiCost(
      {int? costAiNum, int? costAiMovie, required num costGold}) {
    if (costAiNum != null &&
        costAiNum > 0 &&
        costAiNum <= (_userInfo.value.aiNum ?? 0)) {
      return AiCostType.num;
    }
    if (costAiMovie != null &&
        costAiMovie > 0 &&
        costAiMovie <= (_userInfo.value.aiMovie ?? 0)) {
      return AiCostType.num;
    }
    return checkGold(costGold) ? AiCostType.gold : AiCostType.fail;
  }

  // Prevent Duplicate
  Future<bool> updateAll() async {
    if (_updateAllCompleter?.isCompleted == false) {
      return _updateAllCompleter!.future;
    }
    _updateAllCompleter = Completer<bool>();
    Future.wait([
      updateAPIUserInfo(),
      updateAPIAssetsInfo(),
    ]).then((result) {
      final ok = result.every((ok) => ok);
      _updateAllCompleter!.complete(ok);
    });
    return _updateAllCompleter!.future;
  }

  Future<bool> updateAPIUserInfo() async {
    try {
      final s = await httpInstance.post(
          url: "user/base/info", complete: UserInfo.fromJson);
      if (s is UserInfo == false) {
        return false;
      }
      final beforeUserId = _userInfo().userId;
      _userInfo.value = s;
      _saveUserInfo(s);
      if (beforeUserId != _userInfo().userId && beforeUserId != 0) {
        notifyListeners();
      }
      return true;
    } catch (e) {
      logger.d("updateAPIUserInfo error:${e.toString()}");
      return false;
    }
  }

  final storageService = Get.find<StorageService>();

  void _saveUserInfo(UserInfo v) {
    _userInfo.value = v;
    storageService.saveUserInfo(v);
  }

  /// 用户的钱
  final _ass = UseAssetsModel.fromJson({}).obs;

  ///防止乱几把篡改 所以这里用get方法
  UseAssetsModel get assets => _ass.value;

  /// 更新钱
  Future<bool> updateAPIAssetsInfo() async {
    try {
      final s = await httpInstance.get(
          url: "user/acc/getAccFunds", complete: UseAssetsModel.fromJson);
      if (s is UseAssetsModel == false) {
        return false;
      }
      _ass.value = s;
      _saveAssetsInfo(s);
      return true;
    } catch (e) {
      logger.d("updateAPIAssetsInfo error:${e.toString()}");
      return false;
    }
  }

  void _saveAssetsInfo(UseAssetsModel v) {
    _ass.value = v;
  }

  // final _online = ServiceModel.fromJson({}).obs;

  // String get url => _online.value.signUrl!;

  // Future<bool> getOnlineService() async {
  //   try {
  //     final s = await httpInstance.get(
  //       url: 'news/customer/sign',
  //       complete: ServiceModel.fromJson,
  //     );
  //     if (s is ServiceModel == false) {
  //       return false;
  //     }
  //     _online.value = s;
  //     return true;
  //   } catch (e) {
  //     logger.d("getOnlineService error:${e.toString()}");
  //     return false;
  //   }
  // }

  final _city = CityListModel.fromJson({}).obs;

  CityListModel get city => _city.value;

  Future<bool> getCity() async {
    try {
      final s = await httpInstance.get(
        url: 'region/regionList',
        complete: CityListModel.fromJson,
      );
      if (s is CityListModel == false) {
        return false;
      }
      _city.value = s;
      return true;
    } catch (e) {
      logger.d("getCity error:${e.toString()}");
      return false;
    }
  }

  final _province = ProvinceListModel.fromJson({}).obs;

  ProvinceListModel get province => _province.value;

  Future<bool> getProvinceCityList() async {
    try {
      final s = await httpInstance.get(
          url: 'region/provinceCityList',
          complete: ProvinceListModel.fromJson,
          requestEntireModel: true);

      if (s is ProvinceListModel == false) {
        return false;
      }

      _province.value = s;
      return true;
    } catch (e) {
      logger.d("getProvinceCityList error:${e.toString()}");
      return false;
    }
  }
}
