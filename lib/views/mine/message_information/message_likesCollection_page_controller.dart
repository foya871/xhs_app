import 'package:easy_refresh/easy_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';

import '../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../http/api/api.dart';
import '../../../model/mine/message_notice_content_model.dart';

class MessageLikesCollectionPageController extends BaseRefreshController
    with BaseRefreshPageCounter {

  final PagingController<int, MessageNoticeContentModel> pagingController =
  PagingController(firstPageKey: 1);


  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getLikeContent(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getLikeContent();
  }

  //获取消息点赞收藏列表
  Future<IndicatorResult> getLikeContent({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingController.refresh();
      }
      final response = await Api.getMessageContents(informationType: 6, page: page);
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