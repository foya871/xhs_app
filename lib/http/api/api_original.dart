part of 'api.dart';

extension ApiOriginal on _Api {
  ///发布原味
  Future<bool> publishOriginal({
    required String title,
    required int price,
    required bool isOrigin,
    required List<String> images,
    required Map<String, dynamic> certVideo,
  }) async {
    final Map<String, dynamic> request = {
      "title": title,
      "price": price,
      "isOrigin": isOrigin,
      "images": images,
    };
    if (certVideo.isNotEmpty) {
      request["certVideo"] = certVideo;
    }
    try {
      await httpInstance.post(
        url: 'product/release',
        body: request,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///我的购买
  Future<List<OriginalPurchaseModel>> getMyPurchaseOriginal({
    required int orderType,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'product/buyRecord',
        queryMap: {'orderType': orderType, 'page': page, 'pageSize': pageSize},
        complete: OriginalPurchaseModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///我的发布
  Future<List<OriginalPublishModel>> getMyReleaseOriginal({
    required int searchType,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'product/myRelease',
        queryMap: {
          'searchType': searchType,
          'page': page,
          'pageSize': pageSize
        },
        complete: OriginalPublishModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///下架原味
  Future<bool> offShelfOriginal({
    required int productId,
  }) async {
    try {
      await httpInstance.post(
        url: 'product/off',
        body: {'productId': productId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///获取正在售卖的原味列表
  Future<List<OriginalPublishModel>> getOriginalList({
    String? title,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'product/list',
        queryMap: {'title': title, 'page': page, 'pageSize': pageSize},
        complete: OriginalPublishModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///购买商品
  Future<bool> buyOriginal({
    required int productId,
    required String name,
    required String contactDetails,
    required String address,
    required String detailAddress,
  }) async {
    try {
      await httpInstance.post(
        url: 'product/buy',
        body: {
          'productId': productId,
          'name': name,
          'contactDetails': contactDetails,
          'address': address,
          'detailAddress': detailAddress
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///确认收货
  Future<bool> confirmOriginal({
    required String tradeNo,
  }) async {
    try {
      await httpInstance.post(
        url: 'product/arrivedGoods',
        body: {'tradeNo': tradeNo},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
