part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiChoice on _Api {
  // 获取专题列表
  Future<List<VideoChoiceModel>?> fetchChoicesByClassify({
    required int classifyId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/choiceList',
        queryMap: {
          'classifyId': classifyId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: VideoChoiceModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
