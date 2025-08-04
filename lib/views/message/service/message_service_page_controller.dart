import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/message/service_message_model.dart';

class MessageServicePageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  RxList<ServiceMessageModel> serviceMessageList = <ServiceMessageModel>[].obs;
  Rx<ServiceMessageModel> serviceMessage = ServiceMessageModel().obs;

  @override
  Future<IndicatorResult> onRefresh() async {
    return getServiceMessageList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    return getServiceMessageList(isRefresh: false);
  }

  ///获取服务消息列表
  Future<IndicatorResult> getServiceMessageList(
      {required bool isRefresh}) async {
    if (isRefresh) {
      serviceMessageList.clear();
      resetPage();
    } else {
      incPage();
    }
    final response = await Api.getServiceMessageList(
      page: page,
    );
    if (response.isNotEmpty) {
      serviceMessageList.addAll(response);
      return IndicatorResult.success;
    } else {
      if (!isRefresh) {
        return IndicatorResult.noMore;
      }
    }
    return IndicatorResult.success;
  }
}
