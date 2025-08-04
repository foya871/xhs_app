part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiUser on _Api {
  // 关注
  Future<bool> attentionUser(int userId) async {
    try {
      await httpInstance.post(
        url: 'user/attention',
        body: {'toUserId': userId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // 取消关注
  Future<bool> cancelAttentionUser(int userId) async {
    try {
      await httpInstance.post(
        url: 'user/attention/cancel',
        body: {'toUserId': userId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // toogle关注
  Future<bool> toggleAttentionUser(int userId, {required bool? attention}) =>
      attention == true ? cancelAttentionUser(userId) : attentionUser(userId);

  // 推荐用户列表
  Future<List<RecommendUserModel>?> getUserRecommendList(
      {required int page, required int pageSize}) async {
    try {
      final resp = await httpInstance.get(
        url: 'user/recommendList',
        queryMap: {'page': page, 'pageSize': pageSize},
        complete: RecommendUserModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///在线/同城
  Future<List<BloggerBaseModel>?> getNearBy({
    required int page,
    required int pageSize,
    String? bodyShape,
    String? cityName,
    String? emotion,
    int? endAge,
    int? endHeight,
    int? endWeight,
    String? intention,
    required int loadType,
    String? prefer,
    int? startAge,
    int? startHeight,
    int? startWeight,
    String? searchWord,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'user/nearby/list',
        queryMap: {
          'bodyShape': bodyShape,
          'cityName': cityName,
          'emotion': emotion,
          'endAge': endAge,
          'endHeight': endHeight,
          'endWeight': endWeight,
          'intention': intention,
          'loadType': loadType,
          'page': page,
          'pageSize': pageSize,
          'prefer': prefer,
          'startAge': startAge,
          'startHeight': startHeight,
          'startWeight': startWeight,
          'searchWord': searchWord
        },
        complete: BloggerBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
