import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_insert_helper.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';
import 'package:xhs_app/model/video/fiction_base_find_model.dart';
import 'package:xhs_app/model/video/find_video_classify_model.dart';
import 'package:xhs_app/model/video/popular_skits_base_model.dart';
import 'package:xhs_app/views/main/views/recreation/popular_skits/popular_skits_logic.dart';

class PopularSkitsController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, PopularSkitsBaseFindModel> pagingControllers =
      PagingController(firstPageKey: 1);
  Map<String, dynamic> bodyParmas = {};
  var domain = "";

  var classifyTitle = "";

  final _adInsertHelper = AdInsertHelper<PopularSkitsBaseFindModel>(
      AdApiType.THREE_COLUMN_WATERFALL_VERTICAL);

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
      final response = await Api.getPopularSkitsFindList(bodyParmas,
          page: page, pageSize: 20);
      if (isClosed) return IndicatorResult.fail;
      if (GetUtils.isBlank(response) == false) {
        final models = _adInsertHelper.insertWithType(
          response ?? [],
          (place) => PopularSkitsBaseFindModel.fromAd(place),
        );
        pagingControllers.appendPage(models, page);
        Get.find<PopularSkitsLogic>().update();
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
