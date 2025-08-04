import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';
import '../../../model/video/resource_download_model.dart';
import '../../../components/ad/ad_insert_helper.dart';

class ResourceDownloadController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, ResourceInfo> pagingControllers =
      PagingController(firstPageKey: 1);

  var domain = "";

  var classifyTitle = "";

  final _adInsertHelper =
      AdInsertHelper<ResourceInfo>(AdApiType.ONE_COLUMN_WATERFALL_VERTICAL);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getResourceList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getResourceList();
  }

  Future<IndicatorResult> getResourceList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getCommunityResourceList(
        page,
        20,
        classifyTitle,
      );
      if (isClosed) return IndicatorResult.fail;
      if (isRefresh) {
        _adInsertHelper.reset();
      }
      if (GetUtils.isBlank(response) == false) {
        domain = response?.domain ?? "";
        final models = _adInsertHelper.insertWithType(
          response?.data ?? [],
          (place) => ResourceInfo.fromAd(place),
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
