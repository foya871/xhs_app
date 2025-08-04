import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/utils/logger.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';
import '../../../model/adult_game_model/adult_game_model.dart';
import '../../../../components/ad/ad_insert_helper.dart';

class AdultGameController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, AdultGameModel> pagingControllers =
      PagingController(firstPageKey: 1);

  var domain = "";

  var gameCollectionId = 0;

  final _adInsertHelper =
      AdInsertHelper<AdultGameModel>(AdApiType.ONE_COLUMN_WATERFALL_VERTICAL);

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
      final response = await Api.getAdultGameList(
        page,
        20,
        gameCollectionId,
      );
      if (isClosed) return IndicatorResult.fail;
      if (isRefresh) {
        _adInsertHelper.reset();
      }
      if (GetUtils.isBlank(response?.data) == false) {
        domain = response?.domain ?? "";
        final models = _adInsertHelper.insertWithType(
          response?.data ?? [],
          (place) => AdultGameModel.fromAd(place),
        );
        pagingControllers.appendPage(models, page);
        // pagingControllers.appendPage(response?.data ?? [], page);
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
