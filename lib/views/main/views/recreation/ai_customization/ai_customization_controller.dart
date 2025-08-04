import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/model/adult_game_model/adult_game_model.dart';

import '../../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../../http/api/api.dart';

class AiCustomizationController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, AdultGameModel> pagingControllers =
      PagingController(firstPageKey: 1);

  var domain = "";

  var gameCollectionId = 0;

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
      final response = await Api.getAdultGameList(page,20,gameCollectionId,);
      if (GetUtils.isBlank(response) == false) {
        domain = response?.domain ?? "";
        pagingControllers.appendPage(response?.data ?? [], page);
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
