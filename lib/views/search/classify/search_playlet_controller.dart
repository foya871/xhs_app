import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';

import '../../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../../http/api/api.dart';
import '../../../../model/search/search_video_model.dart';

class SearchPlayletController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, VideoList> pagingControllers =
      PagingController(firstPageKey: 1);

  var domain = "";

  var searchType = 0;
  var keyword = "";

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getVideoList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getVideoList();
  }

  Future<IndicatorResult> getVideoList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getResultByKeyword(page,20,searchType,keyword);
      if (GetUtils.isBlank(response) == false) {
        domain = response?.domain ?? "";
        pagingControllers.appendPage(response?.videoList ?? [], page);
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
