/*
 * @Author: wdz
 * @Date: 2025-03-05 15:46:32
 * @LastEditTime: 2025-06-18 19:31:09
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /xhs_app/lib/services/app_service.dart
 */
import 'dart:async';
import 'package:get/get.dart';
import '../http/api/api.dart';
import '../model/ai/ai_models.dart';
import '../model/classify/classify_models.dart';
import '../utils/logger.dart';

class AppService extends GetxService {
  // 暂时没有提供obs, 手动update, 有需要再改
  List<ClassifyModel> shiPinTabs = <ClassifyModel>[];

  // 暂时没有提供obs, 手动update, 有需要再改
  AiEntranceConfigModel aiEntrance = AiEntranceConfigModel.empty();

  ///是否展示选择感兴趣的
  bool showChooseClassifys = false;

  String? androidLandURL;

  // <error>
  Completer<Object?> networkInitCompleter = Completer();

  Future<Object?> sendNetworkInitReq() {
    Future.wait([
      _updateClassifyTabs(),
      Api.fetchAILink(),
      getSharedLink(),
      _getChooseClassifyList(),
    ]).then((_) {
      networkInitCompleter.complete(null);
      // if (shiPinTabs.isEmpty) {
      //   networkInitCompleter.complete('首页初始化失败');
      // } else {
      //   networkInitCompleter.complete(null);
      // }
    }).onError((err, stack) {
      networkInitCompleter.complete(err ?? '初始化失败');
    });
    return networkInitCompleter.future;
  }

  Future<bool> _updateClassifyTabs() async {
    final shiPinClassify = await Api.fetchShiPinClasifyList();
    if (shiPinClassify != null) {
      // 前端加上关注
      shiPinTabs.assignAll([ClassifyModel.attention(), ...shiPinClassify]);
    }
    return true;
  }

  ///是否选择了感兴趣的
  Future _getChooseClassifyList() async {
    final list = await Api.getCommunityClassifySelected();
    if (list.isEmpty) {
      showChooseClassifys = true;
    }
  }

  ///作为安卓更新用的
  Future getSharedLink() async {
    try {
      final result = await Api.getShareLink();
      androidLandURL = result?.url ?? '';
    } catch (e) {
      logger.d('$e');
    }
  }
}
