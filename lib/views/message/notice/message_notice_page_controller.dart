import 'package:easy_refresh/easy_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/model/mine/system_notice_model.dart';

import '../../../http/api/api.dart';

class MessageNoticePageController extends BaseRefreshController with BaseRefreshPageCounter{

  final PagingController<int, SystemNoticeModel> pagingController =
  PagingController(firstPageKey: 1);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getSystemNotice(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getSystemNotice();
  }

  //获取消息通知列表
  Future<IndicatorResult> getSystemNotice({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingController.refresh();
      }
      final response = await Api.fetchSystemNotice(page: page, pageSize: 20);
      if (response != null && response.isNotEmpty) {
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