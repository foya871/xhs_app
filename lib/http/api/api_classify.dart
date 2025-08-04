/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 14:09:31
 * @LastEditTime: 2024-09-25 09:47:19
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/http/api/api_classify.dart
 */
part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiClassify on _Api {
  /// classify的列表
  Future<List<ClassifyModel>?> fetchShiPinClasifyList() => _fetchClassifyList();

  Future<List<ClassifyModel>?> _fetchClassifyList() async {
    try {
      final resp = await httpInstance.get<ClassifyModel>(
        url: 'video/classifyList',
        complete: ClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  /// 获取classify下的频道
  Future<List<StationModel>?> fetchStationsByClassifyId({
    required int classifyId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<StationModel>(
        url: 'video/list',
        queryMap: {
          'classifyId': classifyId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: StationModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoBaseModel>?> fetchVideosByClassifyId({
    required int classifyId,
    required int page,
    required int pageSize,
    required VideoSortType sortType,
  }) =>
      _fetchVideosByClassify(
        classifyId: classifyId,
        page: page,
        pageSize: pageSize,
        sortType: sortType,
      );

  Future<List<VideoBaseModel>?> fetchVideosByChoiceId({
    required int choiceId,
    required int page,
    required int pageSize,
    required VideoSortType sortType,
  }) =>
      _fetchVideosByClassify(
        choiceId: choiceId,
        page: page,
        pageSize: pageSize,
        sortType: sortType,
      );

  Future<List<VideoBaseModel>?> fetchVideosByStationId({
    required int stationId,
    required int page,
    required int pageSize,
    VideoSortType? sortType,
  }) =>
      _fetchVideosByClassify(
        stationId: stationId,
        page: page,
        pageSize: pageSize,
        sortType: sortType,
      );

  Future<List<VideoBaseModel>?> fetchVideosByCollectionId({
    required int collectionId,
    required int page,
    required int pageSize,
    required VideoSortType sortType,
  }) =>
      _fetchVideosByClassify(
        collectionId: collectionId,
        page: page,
        pageSize: pageSize,
        sortType: sortType,
      );

  /// 查询视频(分类，合集，专题，频道)
  Future<List<VideoBaseModel>?> _fetchVideosByClassify({
    int? classifyId,
    int? choiceId,
    int? collectionId,
    int? stationId,
    required int page,
    required int pageSize,
    VideoSortType? sortType,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/getVideoByClassify',
        queryMap: {
          'classifyId': classifyId,
          'choiceId': choiceId,
          'collectionId': collectionId,
          'stationId': stationId,
          'page': page,
          'pageSize': pageSize,
          'sortType': sortType,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //  查询频道排行视频(更多)
  Future<List<VideoBaseModel>?> fetchVideosByRanking({
    required int page,
    required int pageSize,
    required int type,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/getVideoByRanking',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'type': type,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
