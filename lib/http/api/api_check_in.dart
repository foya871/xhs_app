part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiCheckIn on _Api {
  /// 获取签到信息
  Future<CheckInInfoModel?> getUserCheckInInfo() async {
    try {
      final response = await httpInstance.get(
          url: 'checkIn/getUserSignInInfo',
          complete: CheckInInfoModel.fromJson);
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 签到
  /// [type] 1:签到 2:补签
  /// [date] 签到时间(补签必传)
  Future<bool> checkInStart() async {
    try {
      await httpInstance.post(url: 'checkIn/do', body: {
        'type': 1,
        // 'date': DateTime.now().millisecondsSinceEpoch,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  ///查询福利任务信息
  Future<CheckInTasksModel?> getDailySignInTasks() async {
    try {
      final response = await httpInstance.get(
        url: 'checkIn/queryMissionTaskInfo',
        complete: CheckInTasksModel.fromJson,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  ///积分领取
  Future<bool> getIntegralPrizes(int missionId) async {
    try {
      await httpInstance.post(url: 'checkIn/receiveIntegral', body: {
        'id': missionId,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  ///积分兑换
  Future<bool> exchangeIntegralPrizes(int prizeId) async {
    try {
      await httpInstance.post(url: 'checkIn/exchange', body: {
        'prizeId': prizeId,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  ///兑换记录
  Future<List<RedemptionRecordModel>> getExchangeRecord({
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'checkIn/queryExchangeIntegralRecords',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: RedemptionRecordModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }
}
