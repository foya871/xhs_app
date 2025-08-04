import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/model/community/community_model.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';

class MineCommunityController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, CommunityModel> pagingControllers =
      PagingController(firstPageKey: 1);
  RxString searchWord = ''.obs;
  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getBuyCommunityList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getBuyCommunityList();
  }

  Future<IndicatorResult> getBuyCommunityList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getPersonCommunityList(
          page: page, pageSize: 20, searchWord: searchWord.value);
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
