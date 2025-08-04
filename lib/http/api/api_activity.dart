part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiActivity on _Api {
  Future<MerchatPicture?> getActivityImages(int type) async {
    try {
      final resp = await httpInstance.get(
          url: 'info/activity/images',
          queryMap: {
            'type': type,
          },
          complete: MerchatPicture.fromJson);

      return resp;
    } catch (e) {
      return null;
    }
  }

  ///获取活动分类列表
  Future<List<AdStations>> fetchActivityClassifyList() async {
    try {
      final resp = await httpInstance.get(
        url: 'all/ad/station/list',
        complete: AdStations.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  ///根据分类获取活动列表
  // Future<List<ActivityNewModel>> fetchActivityListByClassifyId({
  //   required int stationId,
  //   required int page,
  //   required int pageSize,
  // }) async {

  //   try {
  //     final resp = await httpInstance.get(
  //       url: 'sys/partner/list',
  //       queryMap: {
  //         'stationId': stationId,
  //         'page': page,
  //         'pageSize': pageSize,
  //       },
  //       complete: ActivityNewModel.fromJson,
  //     );
  //     return resp ?? [];
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<bool?> joinByActivityId(int activityId) async {
    try {
      await httpInstance.post(
        url: 'info/activity/join',
        body: {'activityId': activityId},
      );
      return true;
    } catch (e) {
      return null;
    }
  }
}
