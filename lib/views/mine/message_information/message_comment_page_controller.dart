import 'package:easy_refresh/easy_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';

import '../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../http/api/api.dart';
import '../../../model/mine/message_notice_content_model.dart';

class MessageCommentPageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, MessageNoticeContentModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getCommentContent(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getCommentContent();
  }

  //获取消息评价列表
  Future<IndicatorResult> getCommentContent({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingController.refresh();
      }
      final response =
          await Api.getMessageContents(informationType: 4, page: page);
      if (response.isNotEmpty) {
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
