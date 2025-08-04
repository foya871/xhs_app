import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../../http/api/api.dart';
import '../../../model/video/product_detail_model.dart';
import 'naked_chat_detail_state.dart';

class NakedChatDetailLogic extends GetxController {
  final NakedChatDetailState state = NakedChatDetailState();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void loadData() {
    Api.getProductDetail(Get.arguments).then((resp){
      state.productDetail.value = resp ?? ProductDetailModel();
    });
    Api.getProductRecommendList(Get.arguments).then((resp){
      state.recommendList.assignAll(resp ?? []);
    });
  }

  void productLike(bool isLike){
    SmartDialog.showLoading(msg: '提交中...');
    Api.productLike(state.productDetail.value.productId ?? 0, !isLike).then((resp){
      loadData();
      SmartDialog.dismiss();
    });
  }






}
