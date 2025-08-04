import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/adult_game_collection_model/adult_game_collection_model.dart';
import 'package:xhs_app/model/adult_game_detail_model/adult_game_detail_model.dart';
import 'package:xhs_app/model/adult_game_model/adult_game_model.dart';

const _pathName = "adultgame/";

String _generHttpUrl(String path) {
  return "$_pathName$path";
}

abstract class AdultGamesRepository {
  Future<List<AdultGameCollectionModel>> fetchAdultGameCollection();

  Future<List<AdultGameModel>> fetchAdultGameListByCollection(
    int page, {
    int? gameCollectionId,
    int? hostType,
  });

  Future<List<AdultGameModel>> fetchBuyAdultGameRecord(
    int page,
  );

  Future<AdultGameDetailModel> fetchAdultGameDetail(int id);

  /// gameId 游戏ID
  /// type 收藏-1 取消收藏-0
  Future<void> fetchAdultGameFavorite(int gameId, int type);

  Future<dynamic> fetchAdultGameBuy(
    int gameId,
  );

  Future<void> fetchAdultGameCheatNumBuy(
    int gameId,
  );
}

class AdultGamesRepositoryImpl implements AdultGamesRepository {
  @override
  Future<List<AdultGameCollectionModel>> fetchAdultGameCollection() async {
    List<AdultGameCollectionModel> result = await httpInstance.get(
        url: _generHttpUrl("getGameCollection"),
        queryMap: {"page": 1, "pageSize": 30},
        complete: AdultGameCollectionModel.fromJson);

    return result;
  }

  @override
  Future<List<AdultGameModel>> fetchAdultGameListByCollection(
    int page, {
    int? gameCollectionId,
    int? hostType,
  }) async {
    List<AdultGameModel> result = await httpInstance.get(
        url: _generHttpUrl("getGameList"),
        queryMap: {
          "page": page,
          "pageSize": 10,
          "gameCollectionId": gameCollectionId,
          "hostType": hostType
        },
        complete: AdultGameModel.fromJson);
    return result;
  }

  @override
  Future<List<AdultGameModel>> fetchBuyAdultGameRecord(int page) async {
    List<AdultGameModel> result = await httpInstance.get(
        url: _generHttpUrl("getBuyGameRecord"),
        queryMap: {
          "page": page,
          "pageSize": 10,
        },
        complete: AdultGameModel.fromJson);
    return result;
  }

  //adultgame/gameDetail
  @override
  Future<AdultGameDetailModel> fetchAdultGameDetail(int id) async {
    AdultGameDetailModel result = await httpInstance.get(
        url: _generHttpUrl("gameDetail"),
        queryMap: {
          "id": id,
        },
        complete: AdultGameDetailModel.fromJson);

    return result;
  }

  @override
  Future<void> fetchAdultGameFavorite(int gameId, int type) async {
    return await httpInstance.post(url: _generHttpUrl("favoriteGame"), body: {
      "gameId": gameId,
      "type": type,
    });
  }

  @override
  Future<dynamic> fetchAdultGameBuy(
    int gameId,
  ) async {
    return await httpInstance
        .post(url: _generHttpUrl("buyGame"), body: {"gameId": gameId});
  }

  @override
  Future<void> fetchAdultGameCheatNumBuy(
    int gameId,
  ) async {
    return await httpInstance.post(url: _generHttpUrl("buyCheatNum"), body: {
      "gameId": gameId,
    });
  }
}
