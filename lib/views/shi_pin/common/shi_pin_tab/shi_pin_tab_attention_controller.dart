import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../http/api/api.dart';
import '../base/shi_pin_sort_layout_controller.dart';
import '../base/shi_pin_sort_tab_bar.dart';
import 'shi_pin_tab_base_controller.dart';

const _useObs = true;
const _pageSize = 60;

enum ShiPinTabAttentionMode { none, video, recommend }

class ShiPinTabAttentionController extends ShiPinTabBaseController
    with ShiPinSortLayoutController, GetSingleTickerProviderStateMixin {
  ShiPinTabAttentionController(super.classify);

  late final TabController tabController;
  final mode = ShiPinTabAttentionMode.none.obs;

  @override
  bool get useObs => _useObs;

  @override
  Future<List?> dataFetcher(int page, {required bool isRefresh}) async {
    int? sortType;
    if (mode.value == ShiPinTabAttentionMode.video) {
      sortType = ShiPinSortTabBar.getSortType(tabController.index);
    }
    final resp = await Api.fetchAttentionUserVideo(
      page: page,
      pageSize: _pageSize,
      sortType: sortType,
    );
    if (resp == null) return null;
    if (isRefresh) {
      // 第一页如果返回视频，那么后面就都认为是视频
      // 第一页如果返回推荐，那么后面就都认为是推荐
      if (resp.attentionVideoList.isNotEmpty) {
        mode.value = ShiPinTabAttentionMode.video;
      } else if (resp.userRecommendList.isNotEmpty) {
        mode.value = ShiPinTabAttentionMode.recommend;
      } else {
        mode.value = ShiPinTabAttentionMode.none;
      }
    }
    if (mode.value == ShiPinTabAttentionMode.video) {
      return resp.attentionVideoList;
    } else if (mode.value == ShiPinTabAttentionMode.recommend) {
      return resp.userRecommendList;
    } else {
      return [];
    }
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;

  void _onTabIndexChange() {
    FutureLoadingDialog(onRefresh()).show();
  }

  @override
  void onInit() {
    tabController = TabController(
      length: ShiPinSortTabBar.tabsLength,
      vsync: this,
      initialIndex: ShiPinSortTabBar.defaultIndex,
    )..addListener(() => _onTabIndexChange());

    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
