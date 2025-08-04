import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/model/message/private_message_detail_model.dart';
import 'package:xhs_app/model/video_base_model.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';

/// 我的-记录-视频
class MineRecordVideoController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final int videoMark;
  final PagingController<int, VideoBaseModel> pagingControllers =
      PagingController(firstPageKey: 1);

  MineRecordVideoController({required this.videoMark});

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getRecordVideoList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getRecordVideoList();
  }

  Future<IndicatorResult> getRecordVideoList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getRecordVideoList(
          page: page, pageSize: 20, videoMark: videoMark);
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
