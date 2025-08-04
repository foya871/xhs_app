import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';

import '../../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../../http/api/api.dart';
import '../../../../model/video/product_detail_model.dart';
import '../../../../model/video/short_videos_resp.dart';
import '../selection_search_logic.dart';
import '../../../../components/ad/ad_insert_helper.dart';

class ProductListController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, ProductDetailModel> pagingControllers =
      PagingController(firstPageKey: 1);

  var classifyId = "";
  var title = "";
  SelectionSearchLogic? controller;
  final _adInsertHelper = AdInsertHelper<ProductDetailModel>(
      AdApiType.TWO_COLUMN_WATERFALL_VERTICAL);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    if (Get.isRegistered<SelectionSearchLogic>()) {
      controller = Get.find<SelectionSearchLogic>();
    }
    title = controller?.textController.text ?? "";
    return await getProductList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    // title = controller.textController.text;
    return await getProductList();
  }

  Future<IndicatorResult> getProductList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getProductList(page, 20, classifyId, title);
      if (isClosed) return IndicatorResult.fail;
      if (GetUtils.isBlank(response) == false) {
        final models = _adInsertHelper.insertWithType(
          response ?? [],
          (place) => ProductDetailModel.fromAd(place),
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
