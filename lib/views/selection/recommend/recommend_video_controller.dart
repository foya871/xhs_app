import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_insert_helper.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';
import '../../../model/video/short_videos_resp.dart';

class RecommendVideoController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, ShortVideoModel> pagingControllers =
      PagingController(firstPageKey: 1);

  var domain = "";

  var classifyId = "";

  final _adInsertHelper =
      AdInsertHelper<ShortVideoModel>(AdApiType.ONE_COLUMN_WATERFALL_VERTICAL);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getShortVideos(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getShortVideos();
  }

  Future<IndicatorResult> getShortVideos({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getShortVideos(
        page: page,
        pageSize: 20,
        classifyId: classifyId,
        videoMark: 4,
      );
      if (isClosed) return IndicatorResult.fail;
      if (isRefresh) {
        _adInsertHelper.reset();
      }
      if (GetUtils.isBlank(response) == false) {
        domain = response!.domain ?? "";
        final models = _adInsertHelper.insertWithType(
          response.data ?? [],
          (place) => ShortVideoModel.fromAd(place),
        );
        pagingControllers.appendPage(models, page);
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

  @override
  void onClose() {
    pagingControllers.dispose();
    super.onClose();
  }
}
