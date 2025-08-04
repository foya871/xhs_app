import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../http/api/api.dart';
import '../../../model/video/product_detail_model.dart';

class CollecttionProductLogic extends GetxController {
  final PagingController<int, ProductDetailModel> pagingControllers =
      PagingController(firstPageKey: 1);
  RxString searchWord = ''.obs;
  RxInt total = 0.obs;
  final int pageSize = 20;

  void firstRequest() {
    pagingControllers.addPageRequestListener((page) {
      _getUserProductList(page);
    });
    _getUserProductList(1);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pagingControllers.dispose();
    pagingControllers.removePageRequestListener((page) {
      _getUserProductList(page);
    });
    super.onClose();
  }

  Future<void> _getUserProductList(int page) async {
    final response = await Api.getBloggerCollectionProduct(
      page: page,
      pageSize: pageSize,
      searchWord: searchWord.value,
    );

    if (response != null) {
      final json = response['data'];
      total.value = response['total'];
      if (json is List) {
        List arr = json;
        final models = arr.map((e) {
          return ProductDetailModel.fromJson(e);
        }).toList();

        final isLastPage = pageSize * (page - 1) + models.length >= total.value;
        if (isLastPage) {
          pagingControllers.appendLastPage(models);
        } else {
          pagingControllers.appendPage(models, page + 1);
        }
      }
    }
  }
}
