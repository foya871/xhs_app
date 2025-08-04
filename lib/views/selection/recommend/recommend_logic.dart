import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/utils/logger.dart';
import 'package:xhs_app/views/selection/recommend/recommend_video_controller.dart';

import '../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../http/api/api.dart';
import '../../../model/community/community_classify_model.dart';
import '../../../model/video/video_classify_model.dart';
import '../../../utils/enum.dart';
import '../../community/common/classify_tabs/community_classify_factory.dart';
import '../../videotag/video_classify_factory.dart';
import 'recommend_state.dart';

class RecommendLogic extends GetxController
    with StateMixin, GetTickerProviderStateMixin {
  final RecommendState state = RecommendState();
  final optionalClassify = <VideoClassifyModel>[]; // 可选择的
  final tabs = RxList<VideoClassifyModel>.empty(growable: true);
  TabController? tabController;
  final expansionTileController = ExpansionTileController();
  final refreshController = Get.put(RecommendVideoController());

  @override
  void onInit() {
    refreshCommunityClassify();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  Future<void> refreshCommunityClassify([int? initialClassifyId]) async {
    // change(null, status: RxStatus.loading());
    final classifyList = await Api.getVideoClassifyOptionalList(mark: 4);
    final classifyListResult = await Api.getVideoClassifySelected() ?? [];
    if (classifyList.isEmpty) {
      // change(null, status: RxStatus.error());
      return;
    }

    tabs.assignAll(classifyListResult);
    int initialIndex = 0;

    if (initialClassifyId != null) {
      final index = tabs.indexWhere((e) => e.classifyId == initialClassifyId);
      if (index >= 0) {
        initialIndex = index;
      }
    }

    if (refreshController.classifyId.isEmpty && classifyListResult.isNotEmpty) {
      refreshController.classifyId = "${classifyListResult.first.classifyId}";
    }

    tabController?.dispose();
    tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: initialIndex,
    );
    refreshController.refreshController.callRefresh();

    // _bindTabs();
    // change(null, status: RxStatus.success());
  }

  // void _bindTabs() {
  //   for (final classify in tabs) {
  // VideoClassifyFactory.bind(classify);
  // }
  // }

  void onChangeTab(VideoClassifyModel model) {
    refreshController.classifyId = "${model.classifyId}";
    print("调用了吗的的 ${model.classifyId}");
    refreshController.refreshController.callRefresh(force: true);
  }

  Future<bool> loadOptionalClassify() async {
    if (optionalClassify.isNotEmpty) {
      return true;
    }
    final resp = await Api.getVideoClassifyOptionalList(mark: 4);
    if (resp.isEmpty) return false;
    optionalClassify.assignAll(resp);
    return true;
  }

  void onChangeClassify(VideoClassifyModel model) {
    final idx = tabs.indexWhere((e) => e.classifyId == model.classifyId);
    if (idx < 0) return;
    tabController?.index = idx;
    expansionTileController.collapse();
    refreshController.classifyId = "${model.classifyId ?? 0}";
    refreshController.refreshController.callRefresh();
  }

  void onEditDone(
    List<VideoClassifyModel> editedSelected,
    List<VideoClassifyModel> editedOptional,
  ) async {
    if (!_isSelectChange(editedSelected)) {
      return;
    }
    final ids = editedSelected.map((e) => e.classifyId ?? 0).toList();
    final future = Api.saveVideoClassifySelected(ids);
    final ok = await FutureLoadingDialog(future, tips: '保存中..').showUnsafe();
    if (!ok) return;

    expansionTileController.collapse();

    final currClassifyId =
        tabController != null ? tabs[tabController!.index].classifyId : null;
    // 直接整体刷新
    refreshCommunityClassify(currClassifyId);
  }

  // List<VideoClassifyModel> get selectedClassify =>
  //     tabs.where((e) => e.defaultSelected == true).toList();

  bool _isSelectChange(List<VideoClassifyModel> edited) {
    if (edited.length != tabs.length) {
      return true;
    }
    for (int i = 0; i < edited.length; i++) {
      if (edited[i].classifyId != tabs[i].classifyId) {
        return true;
      }
    }
    return false;
  }
}
