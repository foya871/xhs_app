part of 'api.dart';

//写真相关api

extension ApiPortrait on _Api {
  // 获取分类(包含固定和已选的)
  Future<List<PortraitModel>?> getApiPortraitClassify() async {
    try {
      final resp = await httpInstance.get<PortraitModel>(
        url: '/portray/getPortrayClassify',
        complete: PortraitModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  getPictureList(int page, int pageSize, String classifyId) async {
    try {
      final resp = await httpInstance.get(
        url: 'portray/getPictureList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyId': classifyId
        },
        complete: ProductDetailModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
