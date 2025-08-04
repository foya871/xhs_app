import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/utils/logger.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';
import '../../../../model/adult_game_model/adult_game_model.dart';
import '../selection_search_logic.dart';

class GameListController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, AdultGameModel> pagingControllers =
      PagingController(firstPageKey: 1);
  var controller = Get.find<SelectionSearchLogic>();

  var domain = "";

  var gameName = "";

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    gameName = controller.textController.text;
    return await getSearchGame(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    // gameName = controller.textController.text;
    return await getSearchGame();
  }

  Future<IndicatorResult> getSearchGame({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getAdultSearchGame(page,20,gameName,);
      if (GetUtils.isBlank(response?.data) == false) {
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
