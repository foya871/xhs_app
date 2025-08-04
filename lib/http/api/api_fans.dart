// ignore_for_file: library_private_types_in_public_api

part of 'api.dart';

extension ApiFans on _Api {
  Future<int?> getFansGroupConfig() async {
    try {
      final resp = await httpInstance.get(
        url: 'bloggerFansGroup/getFansGroupConfig',
      );
      return resp['price'];
    } catch (e) {
      return 0;
    }
  }

  Future<bool?> createFansGroup({
    required String coverImg,
    required String groupAnno,
    required String groupName,
    required double monthTicketPrice,
    required double seasonTicketPrice,
    required double yearTicketPrice,
  }) async {
    try {
      final resp = await httpInstance.post(
        url: 'bloggerFansGroup/create',
        body: {
          'coverImg': coverImg,
          'groupAnno': groupAnno,
          'groupName': groupName,
          'monthTicketPrice': monthTicketPrice,
          'seasonTicketPrice': seasonTicketPrice,
          'yearTicketPrice': yearTicketPrice,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> updateGroup({
    required int groupId,
    required String coverImg,
    required String groupAnno,
    required String groupName,
    required double monthTicketPrice,
    required double seasonTicketPrice,
    required double yearTicketPrice,
  }) async {
    try {
      final resp = await httpInstance.post(
        url: 'bloggerFansGroup/edit',
        body: {
          'groupId': groupId,
          'coverImg': coverImg,
          'groupAnno': groupAnno,
          'groupName': groupName,
          'monthTicketPrice': monthTicketPrice,
          'seasonTicketPrice': seasonTicketPrice,
          'yearTicketPrice': yearTicketPrice,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///获取人气粉丝团列表
  Future<List<FansClubModel>?> getHostList() async {
    try {
      final resp = await httpInstance.get<FansClubModel>(
        url: 'bloggerFansGroup/getHotList',
        complete: FansClubModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
