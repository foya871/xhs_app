import 'package:get/get.dart';

import 'comics_chapter_logic.dart';

class ComicsChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ComicsChapterLogic());
  }
}
