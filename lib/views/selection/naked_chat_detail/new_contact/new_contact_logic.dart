import 'package:get/get.dart';

import '../../../../components/diolog/dialog.dart';
import 'new_contact_state.dart';

class NewContactLogic extends GetxController {
  final NewContactState state = NewContactState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void submitReport(){
    if(GetUtils.isNullOrBlank(state.contact) == true){
      showToast("请输入手机号码");
      return;
    }
    Get.back(result: {"address":"","detailAddress":"","contactDetails":state.contact,"name":"",});

  }

}
