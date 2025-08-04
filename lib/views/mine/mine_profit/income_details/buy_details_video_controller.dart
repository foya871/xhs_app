import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';

import '../../../../http/api/api.dart';
import '../../../../model/mine/buy_dynamic.dart';

class BuyDetailsVideoController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, BuyDynamic> pagingController =
      PagingController(firstPageKey: 1);
  var videoId = 0;
  var videoMark = 0; //1-长视频 2-刷片视频

  @override
  void onInit() {
    videoId = Get.arguments['videoId'] ?? 0;
    videoMark = Get.arguments['videoMark'] ?? 0;
    super.onInit();
  }

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getBuyDetailsDynamicList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getBuyDetailsDynamicList();
  }

  Future<IndicatorResult> getBuyDetailsDynamicList(
      {bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingController.refresh();
      }
      final response = await Api.getBuyVideoDetails(
          page: page, videoId: videoId, videoMark: videoMark);
      if (response!.isNotEmpty) {
        pagingController.appendPage(response, page);
        return IndicatorResult.success;
      } else {
        if (isRefresh) {
          pagingController.appendLastPage([]);
          return IndicatorResult.success;
        } else {
          pagingController.appendLastPage([]);
          return IndicatorResult.noMore;
        }
      }
    } catch (e) {
      return IndicatorResult.fail;
    }
  }
}
