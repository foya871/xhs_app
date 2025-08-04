import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/mine/message_conter_model.dart';

class NewFollowersPageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  RxList<MessageConterModel> messageItems = <MessageConterModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initDatas();
  }

  void initDatas() {
    getNewFollowers(5);
  }

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    messageItems.clear();
    return await fetchDataByTitle();
  }

  @override
  Future<IndicatorResult> onLoad() async {
    return await fetchDataByTitle();
  }

  Future<IndicatorResult> fetchDataByTitle() async {
    try {
      return await getNewFollowers(6);
    } catch (e) {
      return IndicatorResult.fail;
    }
  }

  Future<IndicatorResult> getNewFollowers(int informationType) async {
    try {
      final response = await Api.getUserMessageList(
        informationType: informationType,
        page: page,
        pageSize: 20,
      );
      if (response != null) {
        messageItems.addAll(response);
        return IndicatorResult.success;
      }
      return IndicatorResult.noMore;
    } catch (e) {
      return IndicatorResult.fail;
    }
  }

  Future<IndicatorResult> follwers({required int toUserId}) async {
    try {
      final response = await httpInstance.post(
        url: 'user/attention',
        body: {
          'toUserId': toUserId,
        },
      );
      if (response != null) {}
      return IndicatorResult.success;
    } catch (e) {
      return IndicatorResult.fail;
    }
  }

  Future<IndicatorResult> follwersCancel({required int toUserId}) async {
    try {
      final response = await httpInstance.post(
        url: 'user/attention/cancel',
        body: {
          'toUserId': toUserId,
        },
      );
      if (response != null) {}
      return IndicatorResult.success;
    } catch (e) {
      return IndicatorResult.fail;
    }
  }
}
