part of 'api.dart';


extension ApiGame on _Api {

  // 获取我的classify
  Future<AdultGameClassifyModel?> getAdultGameClassify() async {
    try {
      final resp = await httpInstance.get(
        url: 'adultgame/getGameCollection',
        queryMap: {'page': 1, 'pageSize': 100,},
      );
      return AdultGameClassifyModel.fromJson(resp);
    } catch (e) {
      return null;
    }
  }

  Future<AdultGameResp?> getAdultGameList(int page, int pageSize,int gameCollectionId) async {
    try {
      final resp = await httpInstance.get(
        url: 'adultgame/getGameList',
        queryMap: {'page': page, 'pageSize': pageSize, 'gameCollectionId':gameCollectionId},
      );
      // logger.i("返回了多少条数据呀123 ${(resp["data"]).length}");
      return AdultGameResp.fromJson(resp);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<AdultGameResp?> getAdultSearchGame(int page, int pageSize,String gameName) async {
    try {
      final resp = await httpInstance.get(
        url: 'adultgame/searchGame',
        queryMap: {'page': page, 'pageSize': pageSize, 'gameName':gameName},
      );
      // logger.i("返回了多少条数据呀123 ${(resp["data"]).length}");
      return AdultGameResp.fromJson(resp);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }


}