import 'package:easy_refresh/easy_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/model/comics/comics_base.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';
/// 我的-记录-漫画
class MineRecordComicsController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, ComicsBaseModel> pagingControllers =
      PagingController(firstPageKey: 1);

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
      final response = await Api.getRecordComicsList(
        page: page,
        pageSize: 20,
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
