import 'package:get/get.dart';

import '../../controllers/blogger_collection/blogger_collection_detail_page_controller.dart';

class BloggerCollectionDetailPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BloggerCollectionDetailPageController());
  }
}
