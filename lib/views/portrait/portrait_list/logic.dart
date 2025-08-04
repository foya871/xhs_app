import 'package:get/get.dart';
import 'package:xhs_app/views/portrait/portrait_list/portrait_list_controller.dart';

import 'state.dart';

class PortraitListLogic extends GetxController {
  final refreshController = Get.put(PottraitController());

  final PortraitListState state = PortraitListState();
}
