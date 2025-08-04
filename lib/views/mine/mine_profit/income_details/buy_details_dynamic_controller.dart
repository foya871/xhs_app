import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';

import '../../../../http/api/api.dart';
import '../../../../model/mine/buy_dynamic.dart';

class BuyDetailsDynamicController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, BuyDynamic> pagingController =
      PagingController(firstPageKey: 1);
  var dynamicId = 0;

  @override
  void onInit() {
    dynamicId = Get.arguments['dynamicId'] ?? 0;
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
      final response =
          await Api.getBuyDynamicDetails(page: page, dynamicId: dynamicId);
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
