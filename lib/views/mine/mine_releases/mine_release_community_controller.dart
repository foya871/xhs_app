import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/http/api/login.dart';
import 'package:xhs_app/model/community/collection_base_model.dart';
import 'package:xhs_app/model/community/community_model.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';
import '../../../services/user_service.dart';

class MineReleaseCommunityController extends GetxController
    with BaseRefreshPageCounter {
  EasyRefreshController refreshController = EasyRefreshController();
  final PagingController<int, CommunityModel> pagingControllers =
      PagingController(firstPageKey: 1);
  var status = 0; //1-审核中，2-审核通过，3-审核拒绝
  RxBool exclusiveToFans = false.obs;

  final userService = Get.find<UserService>();

  @override
  void onInit() {
    super.onInit();
    queryCollection();
  }

  onRefresh(int status) async {
    this.status = status;
    resetPage();
    return await getReleaseCommunityList(isRefresh: true);
  }

  onLoad() async {
    incPage();
    return await getReleaseCommunityList();
  }

  getReleaseCommunityList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getMineReleaseCommunityDataList(
        page: page,
        pageSize: 20,
        status: status,
        exclusiveToFans: exclusiveToFans.value,
      );
      if (response!.isNotEmpty) {
        pagingControllers.appendPage(response, page);
      } else {
        pagingControllers.appendLastPage([]);
      }
    } catch (_) {}
  }

  onclickItem(int index, CommunityModel model) async {
    if (model.isSelected == true) {
      model.isSelected = false;
    } else {
      model.isSelected = true;
    }
    pagingControllers.itemList?[index] = model;
    update();
    pagingControllers.notifyListeners();
    // pagingControllers.
    // pagingControllers.itemList?.forEach((element) {
    //   if (element.dynamicId == model.dynamicId) {
    //     element.isSelected = !element.isSelected!;
    //   }
    // });
    // refresh();
    // if (status == 2) {
    //   Get.toCommunityDetailNew(dynamicId: model.dynamicId ?? 0);
    // } else if (status == 3) {
    //   List<int> ids = [];
    //   ids.add(model.dynamicId!);
    //   final resp = await Api.delCheckCommunity(dynamicIds: ids);
    //   if (resp) EasyToast.show("删除成功");
    //   onRefresh(status);
    // }
  }

  batchFans(int flag) async {
    final ids = pagingControllers.itemList
            ?.where((element) => element.isSelected == true)
            .map((e) => e.dynamicId)
            .toList() ??
        [];
    if (ids.isNotEmpty) {
      final response = await Api.batchFans(dynamicIds: ids, flag: flag);
      if (response) {
        EasyToast.show("设置成功");
        onRefresh(status);
      } else {
        EasyToast.show("设置失败");
      }
    } else {
      EasyToast.show("请选择要设置为粉丝专属的笔记");
    }
  }

  deleteCommunity() async {
    final ids = pagingControllers.itemList
            ?.where((element) => element.isSelected == true)
            .map((e) => e.dynamicId)
            .toList() ??
        [];
    if (ids.isNotEmpty) {
      final response = await Api.deleteCommunity(dynamicIds: ids);
      if (response) {
        EasyToast.show("删除成功");
        onRefresh(status);
      } else {
        EasyToast.show("删除失败");
      }
    } else {
      EasyToast.show("请选择要删除的笔记");
    }
  }

  RxList<CollectionBaseModel> collectionItems = <CollectionBaseModel>[].obs;
  Future<void> queryCollection() async {
    final response = await Api.queryCollectionByUser(
        page: 1, pageSize: 10, userId: userService.user.userId!);
    if (response.isNotEmpty) {
      collectionItems.value = response;
    }
  }

  Future<bool> batchCollection(List<int> ids, int selectIndex) async {
    final response = await Api.batchCollection(
        ids, collectionItems[selectIndex].collectionName ?? "", 1);
    if (response) {
      EasyToast.show("设置成功");
      return true;
    }
    return false;
  }
}
