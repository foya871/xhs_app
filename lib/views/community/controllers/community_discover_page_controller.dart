import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../http/api/api.dart';
import '../../../model/community/community_classify_model.dart';
import '../../../utils/enum.dart';
import '../common/classify_tabs/community_classify_factory.dart';

class CommunityDiscoverPageController extends GetxController
    with StateMixin, GetTickerProviderStateMixin {
  final optionalClassify = <CommunityClassifyModel>[]; // 可选择的
  final tabs = <CommunityClassifyModel>[];
  TabController? tabController;
  final expansionTileController = ExpansionTileController();

  Future<void> refreshCommunityClassify([int? initialClassifyId]) async {
    change(null, status: RxStatus.loading());
    final classifyList = await Api.getCommunityClassify(false);
    if (classifyList == null || classifyList.isEmpty) {
      change(null, status: RxStatus.error());
      return;
    }
    // 不知为何出现过重复，这里去除～
    final classifyListResult = <CommunityClassifyModel>[];
    for (final e in classifyList) {
      bool found =
          classifyListResult.indexWhere((v) => e.classifyId == v.classifyId) >=
              0;
      if (found) continue;
      classifyListResult.add(e);
    }

    tabs.assignAll(classifyListResult);
    int initialIndex = 0;

    if (initialClassifyId != null) {
      final index = tabs.indexWhere((e) => e.classifyId == initialClassifyId);
      if (index >= 0) {
        initialIndex = index;
      }
    }

    tabController?.dispose();
    tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: initialIndex,
    );

    _bindTabs();
    change(null, status: RxStatus.success());
  }

  void _bindTabs() {
    for (final classify in tabs) {
      CommunityClassifyFactory.bind(classify);
    }
  }

  List<CommunityClassifyModel> get fixedClassify =>
      tabs.where((e) => e.type != CommunityClassifyTypeEnum.optional).toList();

  List<CommunityClassifyModel> get selectedClassify =>
      tabs.where((e) => e.type == CommunityClassifyTypeEnum.optional).toList();

  Future<bool> loadOptionalClassify() async {
    if (optionalClassify.isNotEmpty) {
      return true;
    }
    final resp = await Api.getCommunityClassifyOptionalList();
    if (resp == null) return false;
    optionalClassify.assignAll(resp);
    return true;
  }

  void onChangeClassify(CommunityClassifyModel model) {
    final idx = tabs.indexWhere((e) => e.classifyId == model.classifyId);
    if (idx < 0) return;
    tabController?.index = idx;
    expansionTileController.collapse();
  }

  bool _isSelectChange(List<CommunityClassifyModel> edited) {
    if (edited.length != selectedClassify.length) {
      return true;
    }
    for (int i = 0; i < edited.length; i++) {
      if (edited[i].classifyId != selectedClassify[i].classifyId) {
        return true;
      }
    }
    return false;
  }

  void onEditDone(
    List<CommunityClassifyModel> editedSelected,
    List<CommunityClassifyModel> editedOptional,
  ) async
  {
    if (!_isSelectChange(editedSelected)) {
      return;
    }
    final ids = editedSelected.map((e) => e.classifyId).toList();
    final future = Api.saveCommunityClassifySelected(ids);
    final ok = await FutureLoadingDialog(future, tips: '保存中..').showUnsafe();
    if (!ok) return;

    expansionTileController.collapse();

    final currClassifyId =
        tabController != null ? tabs[tabController!.index].classifyId : null;
    // 直接整体刷新
    refreshCommunityClassify(currClassifyId);
  }

  @override
  void onInit() {
    refreshCommunityClassify();
    super.onInit();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }
}
