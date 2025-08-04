part of 'api.dart';

extension ApiInfoPromotion on _Api {
  Future<bool> infoPromotionPraise({
    required int infoId,
    required bool like,
  }) async {
    try {
      String apiUrl = '';
      if (like == true) {
        apiUrl = "infoPromotion/unLike";
      } else {
        apiUrl = "infoPromotion/like";
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {
          'infoId': infoId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> infoPromotionFavorite({
    required int infoId,
    required bool favorite,
  }) async {
    try {
      String apiUrl = '';
      if (favorite == true) {
        apiUrl = "community/dynamic/unFavorite";
      } else {
        apiUrl = "infoPromotion/favorite";
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {
          'infoId': infoId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> infoPromotionAttention({
    required int toUserId,
    required bool attention,
  }) async {
    try {
      String apiUrl = '';
      if (attention == true) {
        apiUrl = "user/attention/cancel";
      } else {
        apiUrl = "user/attention";
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {
          'toUserId': toUserId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
