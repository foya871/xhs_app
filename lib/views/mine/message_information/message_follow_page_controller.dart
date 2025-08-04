import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/routes/routes.dart';

import '../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../http/api/api.dart';
import '../../../model/mine/message_notice_content_model.dart';

class MessageFollowPageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, MessageNoticeContentModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getFollowContent(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getFollowContent();
  }

  //获取消息点赞收藏列表
  Future<IndicatorResult> getFollowContent({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingController.refresh();
      }
      final response =
          await Api.getMessageContents(informationType: 5, page: page);
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

  jumpBlogger(int userId) {
    Get.toBloggerDetail(userId: userId);
  }
}
