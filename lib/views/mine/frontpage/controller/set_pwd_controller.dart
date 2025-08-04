import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../services/storage_service.dart';

class SetPwdController extends GetxController {
  final service = Get.find<StorageService>();
  final FocusNode textNode = FocusNode();
  var resultDataNew = ''.obs;
  var resultDataAgain = ''.obs;
  var isAgain = false.obs;
  var text = ''.obs;
}
