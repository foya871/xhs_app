import 'package:get/get.dart';

import '../../../model/video/product_detail_model.dart';

class ProductDetailState {
  ProductDetailState() {
    ///Initialize variables
  }

  ///详情
  var productDetail = ProductDetailModel().obs;

  var pageIndex = 1.obs;

  var recommendList = RxList<ProductDetailModel>.empty(growable: true);

}
