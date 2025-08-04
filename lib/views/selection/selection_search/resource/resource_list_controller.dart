import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';
import '../../../../model/video/resource_download_model.dart';
import '../selection_search_logic.dart';

class ResourceListController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, ResourceInfo> pagingControllers =
      PagingController(firstPageKey: 1);

  var domain = "";
  var controller = Get.find<SelectionSearchLogic>();

  var resourceName = "";

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    resourceName = controller.textController.text;
    return await getResourceList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    // resourceName = controller.textController.text;
    return await getResourceList();
  }

  Future<IndicatorResult> getResourceList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.searchCommunityResourceList(page,20,resourceName,);
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
