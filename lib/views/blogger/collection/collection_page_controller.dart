import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/community/collection_base_model.dart';

class CollectionPageController extends GetxController {
  final EasyRefreshController easyRefreshController = EasyRefreshController();
  int userId = 0;
  int pageindex = 1;
  RxList<CollectionBaseModel> collectionList = <CollectionBaseModel>[].obs;

  @override
  void onInit() {
    userId = Get.arguments['userId'];
    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
    getUserCollectionList(isRefresh: true);
  }

  getUserCollectionList({required bool isRefresh}) {
    if (isRefresh) {
      pageindex = 1;
    }
    Api.queryCollectionByUser(userId: userId, page: pageindex, pageSize: 20)
        .then((value) {
      if (value.isNotEmpty) {
        if (isRefresh) {
          collectionList.clear();
        }
        collectionList.addAll(value);
        pageindex++;
      }
    });
  }
}
