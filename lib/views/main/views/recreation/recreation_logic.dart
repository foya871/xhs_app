import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../http/api/api.dart';
import '../../../../model/community/community_classify_model.dart';
import 'recreation_state.dart';

class RecreationLogic extends GetxController
    with StateMixin, GetTickerProviderStateMixin {
  final RecreationState state = RecreationState();
  final expansionTileController = ExpansionTileController();
  final optionalClassify = <CommunityClassifyModel>[]; // 可选择的
  TabController? tabController;
  List<CommunityClassifyModel> get selectedClassify => state.tabs
      .map((e) => CommunityClassifyModel.fromJson({"classifyTitle": e ?? ""}))
      .toList();
  Future<bool> loadOptionalClassify() async {
    if (optionalClassify.isNotEmpty) {
      return true;
    }
    final resp = await Api.getCommunityClassifyOptionalList();
    if (resp == null) return false;
    optionalClassify.assignAll(resp);
    return true;
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

  int initialIndex = 0;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    tabController?.dispose();
    tabController = TabController(
      length: state.tabs.length,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  void onChangeClassify(CommunityClassifyModel model) {
    final idx = state.tabs.indexWhere((e) => e == model.classifyTitle);
    if (idx < 0) return;
    tabController?.index = idx;
    expansionTileController.collapse();
  }

  void onEditDone(
    List<CommunityClassifyModel> editedSelected,
    List<CommunityClassifyModel> editedOptional,
  ) async {
    if (!_isSelectChange(editedSelected)) {
      return;
    }
    final ids = editedSelected.map((e) => e.classifyId).toList();
    final future = Api.saveCommunityClassifySelected(ids);
    final ok = await FutureLoadingDialog(future, tips: '保存中..').showUnsafe();
    if (!ok) return;

    expansionTileController.collapse();

    final currClassifyId =
        tabController != null ? state.tabs[tabController!.index] : null;
    // 直接整体刷新
    // refreshCommunityClassify(currClassifyId);
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }
}
