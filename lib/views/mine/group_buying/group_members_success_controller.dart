import 'package:easy_refresh/easy_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/mine/group_members_model.dart';

import '../../../components/base_refresh/base_refresh_page_counter.dart';

class GroupMembersSuccessController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, GroupMembersModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getMembersList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getMembersList();
  }

  Future<IndicatorResult> getMembersList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingController.refresh();
      }
      final response = await Api.getGroupMembersHistoryList(page: page);
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
