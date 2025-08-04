import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../../http/api/api.dart';
import '../../../model/video/product_detail_model.dart';
import 'product_detail_state.dart';

class ProductDetailLogic extends GetxController {
  final ProductDetailState state = ProductDetailState();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

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
      SmartDialog.dismiss();
    });
  }


}
