import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/model/mine/profit_model.dart';

import '../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../http/api/api.dart';

class MineProfitPageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, ProfitModel> pagingControllers =
      PagingController(firstPageKey: 1);

  RxInt incomeType = 1.obs;
  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getProfitListByType(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getProfitListByType();
  }

  Future<IndicatorResult> getProfitListByType({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getProfitListByType(
        page: page,
        pageSize: 20,
        incomeType: incomeType.value,
      );
      if (response!.isNotEmpty) {
        pagingControllers.appendPage(response, page);
        return IndicatorResult.success;
      } else {
        if (isRefresh) {
          pagingControllers.appendLastPage([]);
          return IndicatorResult.success;
        } else {
          pagingControllers.appendLastPage([]);
          return IndicatorResult.noMore;
        }
      }
    } catch (e) {
      return IndicatorResult.fail;
    }
  }
}
