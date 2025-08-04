import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/utils/consts.dart';

abstract class BrushBasePageController<T> extends GetxController {
  final pageController = PageController();
  final pagingController = PagingController<int, T>(
    firstPageKey: Consts.pageFirst,
    invisibleItemsThreshold: 3,
  );

  void onVisibleChanged(bool visible);
  void onPageIndexChanged(int pageIndex);

  @override
  void onClose() {
    pageController.dispose();
    pagingController.dispose();
    super.onClose();
  }
}
