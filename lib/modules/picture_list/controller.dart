import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/model/picture_cell_model/picture_cell_model.dart';
import 'package:xhs_app/repositories/picture.dart';

class PictureListParamsManagerController extends GetxController {
  final List<Map<String, dynamic>> viewFilterList = [
    {'value': null, 'text': '全部'},
    {'value': true, 'text': '已观看'},
    {'value': false, 'text': '未观看'},
  ];

  final List<Map<String, dynamic>> timeFilterList = [
    {'value': 1, 'text': '时间_新至旧'},
    {'value': 2, 'text': '时间_旧至新'},
    {'value': 3, 'text': '观看_多至少'},
  ];

  RxnBool viewed = RxnBool();

  RxInt sortType = 1.obs;

  void setViewed(bool? viewed) {
    this.viewed.value = viewed;
  }

  void setSortType(int sortType) {
    this.sortType.value = sortType;
  }
}

class PictureListController extends GetxController {
  final pagingController =
      PagingController<int, PictureCellModel>(firstPageKey: 1);

  final refreshController = EasyRefreshController();

  final paramsManagerController =
      Get.find<PictureListParamsManagerController>();

  Future<void> fetch({int page = 1}) async {
    final result = await PictureRepositoryImpl().fetchPictureList(
      page: page,
      sortType: paramsManagerController.sortType.value,
      viewed: paramsManagerController.viewed.value,
    );

    final isLastPage = result.length < 10;

    if (isLastPage == true) {
      pagingController.appendLastPage(result);
    } else {
      pagingController.appendPage(result, page + 1);
    }
  }

  void pagingCongrollerAddPageRequestListener(int pageKey) async {
    fetch(page: pageKey);
  }

  @override
  void onInit() {
    super.onInit();
    pagingController
        .addPageRequestListener(pagingCongrollerAddPageRequestListener);

    everAll([paramsManagerController.sortType, paramsManagerController.viewed],
        (value) {
      pagingController.refresh();
    });
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
