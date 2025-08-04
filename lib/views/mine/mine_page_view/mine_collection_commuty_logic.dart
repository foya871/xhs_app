import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../http/api/api.dart';
import '../../../model/community/community_base_model.dart';

class CollecttionCommuntyLogic extends GetxController {
  final PagingController<int, CommunityBaseModel> pagingControllers =
      PagingController(firstPageKey: 1);
  RxString searchWord = ''.obs;
  RxInt total = 0.obs;
  final int pageSize = 20;

  @override
  void onReady() {
    pagingControllers.addPageRequestListener((page) {
      _getBuyCommunityList(page);
    });
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pagingControllers.dispose();
    pagingControllers.removePageRequestListener((page) {
      _getBuyCommunityList(page);
    });
    super.onClose();
  }

  Future<void> _getBuyCommunityList(int page) async {
    final response = await Api.getMineCollectCommunityDataList(
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
          return CommunityBaseModel.fromJson(e);
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
