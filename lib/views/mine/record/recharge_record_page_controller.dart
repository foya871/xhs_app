import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/mine/record_model.dart';

class RechargeRecordPageController extends GetxController
    with BaseRefreshPageCounter {
  int type = 2;

  EasyRefreshController refreshController = EasyRefreshController();
  final PagingController<int, RecordModel> pagingControllers =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    type = Get.arguments['type'] ?? 2;
    super.onInit();
  }

  onRefresh() async {
    geRechargeRecordList(isRefresh: true);
  }

  onLoad() async {
    geRechargeRecordList(isRefresh: false);
  }

  geRechargeRecordList({required bool isRefresh}) async {
    if (isRefresh) {
      resetPage();
      pagingControllers.refresh();
    } else {
      incPage();
    }
    final response = await Api.geRechargeRecordList(
      tranType: type,
      page: page,
    );
    if (response.isNotEmpty) {
      pagingControllers.appendPage(response, page);
    } else {
      pagingControllers.appendLastPage([]);
    }
  }

  getPayType(int payType) {
    switch (payType) {
      case 1:
        return AppImagePath.icons_ali;
      case 2:
        return AppImagePath.icons_wx;
      case 3:
        return AppImagePath.icons_ysf;
      default:
        return AppImagePath.icons_pay_balance;
    }
  }
}
