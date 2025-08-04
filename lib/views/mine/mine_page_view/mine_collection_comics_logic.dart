import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../http/api/api.dart';
import '../../../model/comics/comics_base.dart';

class CollecttionComicsyLogic extends GetxController {
  final PagingController<int, ComicsBaseModel> pagingControllers =
      PagingController(firstPageKey: 1);
  RxString searchWord = ''.obs;
  RxInt total = 0.obs;
  final int pageSize = 20;

  void firstRequest() {
    pagingControllers.addPageRequestListener((page) {
      _getUserComicList(page);
    });
    _getUserComicList(1);
  }

  @override
  void onClose() {
    pagingControllers.dispose();
    pagingControllers.removePageRequestListener((page) {
      _getUserComicList(page);
    });
    super.onClose();
  }

  Future<void> _getUserComicList(int page) async {
    final response = await Api.getPersonComicsList(
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
          return ComicsBaseModel.fromJson(e);
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
