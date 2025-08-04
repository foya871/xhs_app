import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/video/product_detail_model.dart';


class PottraitController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, ProductDetailModel> pagingControllers =
      PagingController(firstPageKey: 1);

  var classifyId = "4";

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getProductList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getProductList();
  }

  Future<IndicatorResult> getProductList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getPictureList(page,20,classifyId,);
      if (GetUtils.isBlank(response) == false) {
        pagingControllers.appendPage(response ?? [], page);
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
