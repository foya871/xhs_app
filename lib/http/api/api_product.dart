part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiProduct on _Api {


  // 获取可选classify
  Future<List<ProductClassifyModel>?> getProductClassifyOptionalList() async {
    try {
      final resp = await httpInstance.get(
        url: 'product/classify/list',
        complete: ProductClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<ProductDetailModel>?> getProductList(
      int page, int pageSize, String classifyId,String title) async {
    try {
      final resp = await httpInstance.get(
        url: 'product/list',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyId': classifyId,
          'title': title,
        },
        complete: ProductDetailModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<ProductModel>> getBuyProductList({
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'product/buyRecord',
        queryMap: {'page': page, 'pageSize': pageSize},
        complete: ProductModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }


  ///商品详情
  Future<ProductDetailModel?> getProductDetail(int id) async {
    try {
      final resp = await httpInstance.get(
        url: 'product/dtl',
        queryMap: {'id': id,},
        complete: ProductDetailModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///商品详情的推荐
  Future<List<ProductDetailModel>?> getProductRecommendList(int productId) async {
    try {
      final resp = await httpInstance.get(
        url: 'product/getRec',
        queryMap: {'productId': productId,},
        complete: ProductDetailModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }


  ///产品收藏
  Future<bool> productLike(int productId,bool isLike) async {
    try {
      final _ = await httpInstance.post(
        url: "product/like/submit",
        body: {'productId': productId,"isLike":isLike},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  //购买产品
  Future<bool> productBuy(Map<String,dynamic> body) async {
    try {
      final _ = await httpInstance.post(
        url: "product/buy",
        body: body,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///查询产品推荐搜索词
  Future<List<DynamicHotWordModel>?> getSearchRecWord() async {
    try {
      final resp = await httpInstance.get<DynamicHotWordModel>(
        url: 'product/getSearchRec',
        complete: DynamicHotWordModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }


}
