import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/shi_pin/common/base/shi_pin_sort_layout_controller.dart';
import 'package:tuple/tuple.dart';

import '../../../../components/base_refresh/base_refresh_share_tab_controller.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../http/api/api.dart';
import '../../../../model/choice/choice_models.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/consts.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import 'shi_pin_tab_base_controller.dart';

const _pageSize = 60;
const _useObs = true;

class _DataKeeper
    extends BaseRefreshDataKeeperWithScrollOffset<VideoBaseModel> {
  final int classifyId;
  final int sortType;

  _DataKeeper({required this.classifyId, required this.sortType});

  @override
  bool get useObs => _useObs;

  @override
  Future<List<VideoBaseModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return Api.fetchVideosByClassifyId(
      classifyId: classifyId,
      page: page,
      pageSize: _pageSize,
      sortType: sortType,
    );
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}

class ShiPinTabVideosController extends ShiPinTabBaseShareTabContorller
    with ShiPinSortLayoutController, GetSingleTickerProviderStateMixin {
  ShiPinTabVideosController(super.classify) : super(enableJump: false);

  static const sortTabs = <Tuple2>[
    Tuple2<String, int>('最近更新', VideoSortTypeEnum.latest),
    Tuple2<String, int>('最多观看', VideoSortTypeEnum.mostPlayed),
    Tuple2<String, int>('最多购买', VideoSortTypeEnum.mostSale),
    Tuple2<String, int>('十分钟以上', VideoSortTypeEnum.minute10),
  ];

  static int getSortTypeByIndex(int index) => sortTabs[index].item2;

  final choices = <VideoChoiceModel>[].obs;
  late final TabController tabContorller;

  @override
  bool get useObs => _useObs;

  @override
  BaseRefreshDataKeeperWithScrollOffset initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as BaseRefreshTabIndexKey;
    return _DataKeeper(
      classifyId: classify.classifyId,
      sortType: getSortTypeByIndex(key.index),
    );
  }

  @override
  Future<IndicatorResult> onRefresh([bool checkNoMore = false]) async {
    final choiceFuture = Api.fetchChoicesByClassify(
      classifyId: classify.classifyId,
      page: Consts.pageFirst,
      pageSize: Consts.pageSizeMax,
    );
    final result = await super.onRefresh(checkNoMore);
    final choicesResult = ((await choiceFuture) ?? [])
      ..add(VideoChoiceModel.ai());
    choices.assignAll(choicesResult);
    return result;
  }

  @override
  void onInit() {
    tabContorller = TabController(length: sortTabs.length, vsync: this)
      ..addFastListener((index) {
        onTabChange(BaseRefreshTabIndexKey(index));
      });
    currentTabKey = BaseRefreshTabIndexKey(tabContorller.index);
    super.onInit();
  }
}
