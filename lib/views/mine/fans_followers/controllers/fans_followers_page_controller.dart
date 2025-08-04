import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/mine/fans_follower_model.dart';
import 'package:xhs_app/model/mine/official_community_model.dart';

class FansFollowersPageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  var title = '粉丝'.obs;
  final String getParameters = Get.parameters['title'] ?? "粉丝";

  RxList<FansFollowerModel> list = <FansFollowerModel>[].obs;
  RxList<OfficialCommunityModel> ocLists = <OfficialCommunityModel>[].obs;

  RxBool isLoaded = false.obs;
  @override
  void onInit() {
    super.onInit();
    initDatas();
  }

  void initDatas() {
    title.value = getParameters;
    fetchData();
  }

  void fetchData() {
    if (title.value == '粉丝') {
      getFans();
    } else if (title.value == '关注') {
      getFollowers();
    } else {
      getOfficialCommunity();
    }
  }

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    if (title.value == '加群开车') {
      ocLists.clear();
    } else {
      list.clear();
    }
    return await fetchDataByTitle();
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return title.value == '加群开车'
        ? IndicatorResult.none
        : await fetchDataByTitle();
  }

  Future<IndicatorResult> fetchDataByTitle() async {
    try {
      if (title.value == '粉丝') {
        return await getFans();
      } else if (title.value == '关注') {
        return await getFollowers();
      } else {
        return await getOfficialCommunity();
      }
    } catch (e) {
      return IndicatorResult.fail;
    }
  }

  Future<IndicatorResult> getFans() async {
    try {
      final response = await httpInstance.get(
          url: 'user/fansList',
          queryMap: {
            'page': page,
            'pageSize': 20,
          },
          complete: FansFollowerModel.fromJson);
      isLoaded.value = true;
      if (response != null) {
        list.addAll(response);
        return IndicatorResult.success;
      }
      return IndicatorResult.noMore;
    } catch (e) {
      return IndicatorResult.fail;
    }
  }

  Future<IndicatorResult> getFollowers() async {
    try {
      final response = await httpInstance.get(
        url: 'user/attentionList',
        queryMap: {
          'page': page,
          'pageSize': 20,
        },
        complete: FansFollowerModel.fromJson,
      );
      isLoaded.value = true;
      if (response != null) {
        list.addAll(response);
        return IndicatorResult.success;
      }
      return IndicatorResult.noMore;
    } catch (e) {
      return IndicatorResult.fail;
    }
  }

  ///加群聊骚
  Future<IndicatorResult> getOfficialCommunity() async {
    try {
      final response = await httpInstance.get(
        url: 'sys/group/list',
        complete: OfficialCommunityModel.fromJson,
      );
      if (response != null) {
        ocLists.addAll(response);
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
