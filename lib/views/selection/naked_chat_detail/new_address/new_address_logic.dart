import 'package:get/get.dart';
import 'package:xhs_app/components/diolog/dialog.dart';

import 'new_address_state.dart';

class NewAddressLogic extends GetxController {
  final NewAddressState state = NewAddressState();

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
    if(GetUtils.isNullOrBlank(state.username) == true){
      showToast("请输入收货人姓名");
      return;
    }
    if(GetUtils.isNullOrBlank(state.phone) == true){
      showToast("请输入手机号码");
      return;
    }
    if(GetUtils.isNullOrBlank(state.city) == true){
      showToast("请输入地区省/市/区");
      return;
    }
    if(GetUtils.isNullOrBlank(state.area) == true){
      showToast("请输入详细地址 列:XX街/XX路/XX号");
      return;
    }

    Get.back(result: {"address":state.city,"detailAddress":state.area,"contactDetails":state.phone,"name":state.username,});

  }


}
