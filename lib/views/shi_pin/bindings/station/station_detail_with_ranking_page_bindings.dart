import 'package:get/get.dart';
import 'package:xhs_app/views/shi_pin/controllers/station/station_detail_with_ranking_page_controller.dart';

class StationDetailWithRankingPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StationDetailWithRankdingPageController());
  }
}
