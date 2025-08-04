/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 14:09:31
 * @LastEditTime: 2025-03-04 15:47:12
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/http/api/api_short_player.dart
 */
part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiShortPlayer on _Api {
  /// 上传观影记录
  Future uploadWatchRc(
      {required int duration,
      ////观看方式 1:免费次数 2：vip观看 3： 金币观看 4：试看
      required int lookType,
      required int videoId,

      ///进度(视频看到多少秒)
      required int progress}) async {
    try {
      await httpInstance.post(
        url: 'video/addStatisticsTimes',
        body: {
          'videoId': videoId,
          'duration': duration,
          "lookType": lookType,
          "progress": progress
        },
      );
    } catch (_) {}
  }

  /// 获取classify下的视频
  Future<List<VideoBaseModel>?> fetchShortVideoListByClassifyId(
      {required int page,
      required int pageSize,
      required String classifyId}) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/queryShortVideo',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyId': classifyId
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoBaseModel>?> fetchRcommendVideoList() async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/recommendVideo',
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///购买视频
  Future<bool?> buyVideoAction({required int videoId}) async {
    try {
      await httpInstance
          .post(url: 'tran/pur/video', body: {"videoId": videoId});
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取视频详情
  Future<VideoDetail?> fetchShortVideoDetail({
    required int videoId,
    CancelToken? token,
  }) async {
    try {
      final resp = await httpInstance.get<VideoDetail>(
        url: 'video/getVideoById',
        queryMap: {"videoId": videoId},
        complete: VideoDetail.fromJson,
        token: token,
      );
      return resp ?? VideoDetail.fromJson({});
    } catch (e) {
      return null;
    }
  }

  /// 关注或者取关某人
  Future<bool> focusAction(
      {required int userId, required bool attention}) async {
    try {
      await httpInstance.post(
        url: attention ? 'user/attention/cancel' : 'user/attention',
        body: {"toUserId": userId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取猜你喜欢
  Future<List<VideoBaseModel>?> fetchGuessLikeVideoList({
    required int videoId,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/guessLike',
        queryMap: {"videoId": videoId},
        complete: VideoBaseModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  // /// 获取相关作品
  // Future<List<VideoBaseModel>?> fetchRelatedVideoListById({
  //   required int userId,
  // }) async {
  //   try {
  //     final resp = await httpInstance.get<VideoBaseModel>(
  //       url: 'video/queryPersonVideoByType',
  //       queryMap: {"userId": userId, "masterWork": true},
  //       complete: VideoBaseModel.fromJson,
  //     );
  //     return resp;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  ///线路CDN列表
  Future<List<CdnRsp>?> fetchCdnLines() async {
    try {
      final resp = await httpInstance.get<CdnRsp>(
        url: 'video/cdn/cdnList',
        complete: CdnRsp.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  ///点赞视频评论
  Future<bool> likeVideoComment(
      {required bool toLike, required int commentId}) async {
    try {
      await httpInstance.post(
        url: toLike ? 'video/comment/saveLike' : 'video/comment/unLike',
        body: {"commentId": commentId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取收藏或者购买的视频
  Future<List<VideoBaseModel>?> fetchBuyedOrLikeShortVideoList(
      {required int page,
      required int pageSize,
      required int userId,
      required bool isBuy}) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: isBuy ? 'video/userPurVideo' : 'video/userFavorites',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'userId': userId,
          "videoMark": 2
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///详情
  Future<VideoDetail?> fetchVideoDetailById({required int videoId}) async {
    try {
      final resp = await httpInstance.get<VideoDetail>(
          url: "video/getVideoById",
          complete: VideoDetail.fromJson,
          queryMap: {"videoId": videoId});
      return resp;
    } catch (_) {
      return null;
    }
  }

  ///收藏合集
  Future<bool> favoriteUserCollect(
      {required bool isCollect, required int collectionId}) async {
    try {
      await httpInstance.post(
        url: isCollect
            ? 'bloggerCollection/cancelFavorite'
            : 'bloggerCollection/favorite',
        body: {"collectionId": collectionId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> toogleVideoFavorite(int videoId,
      {required bool? favorite}) async {
    try {
      await httpInstance.post(
        url: favorite == true
            ? 'video/cancelVideoFavorite'
            : 'video/favoriteVideo',
        body: {"videoId": videoId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///购买视频
  Future<bool> purchaseVideo({required int videoId}) async {
    try {
      await httpInstance
          .post(url: "tran/pur/video", body: {"videoId": videoId});
      return true;
    } catch (_) {
      return false;
    }
  }
}
