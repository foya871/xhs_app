part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiVideo on _Api {
  // 查询网黄
  Future<PornographyListResp?> fetchPornography({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'content/getPornographyList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: PornographyListResp.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  // 短视频-关注
  Future<List<VideoBaseModel>?> fetchShortVideoFocusList({
    required int page,
    required int pageSize,
  }) =>
      _fetchShortVideo(
        page: page,
        pageSize: pageSize,
        recommend: false,
      );

  // 短视频-推荐
  Future<List<VideoBaseModel>?> fetchShortVideoRecommend({
    required int page,
    required int pageSize,
    bool? refresh,
  }) =>
      _fetchShortVideo(
          page: page, pageSize: pageSize, recommend: true, refresh: refresh);

  // 短视频
  Future<List<VideoBaseModel>?> _fetchShortVideo({
    required int page,
    required int pageSize,
    bool? recommend,
    bool? refresh,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/queryBrushVideos',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          //排序：1-关注 2-推荐
          'sortType': recommend == true ? 2 : 1,
          "refresh": refresh,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoBaseModel>?> fetchVideoHouse({
    required int page,
    required int pageSize,
    int? sortMark,
    int? videoType,
    String? tagsTitle,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/queryVideoHouse',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'sortMark': sortMark,
          'videoType': videoType,
          'tagsTitle': tagsTitle,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<AttentionUserVideosResp?> fetchAttentionUserVideo({
    required int page,
    required int pageSize,
    VideoSortType? sortType,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/attentionUserVideo',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'sortType': sortType,
        },
        complete: AttentionUserVideosResp.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  // 标签列表
  Future<List<TagsModel>?> fetchTagsList({int? parentId}) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/tagsList',
        queryMap: {
          'parentId': parentId,
        },
        complete: TagsModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<VideoClassifyModel>?> getVideoClassify() async {
    try {
      final resp = await httpInstance.get<VideoClassifyModel>(
        url: 'video/classifyList',
        queryMap: {
          'mark': 4,
        },
        complete: VideoClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<ComicsBaseModel>?> getBaseFindList(Map<String, dynamic>? body1,
      {int? page = 0, int? pageSize = 20}) async {
    Map<String, dynamic>? body = body1 ?? {};
    body["page"] = page;
    body["pageSize"] = pageSize;
    try {
      final resp = await httpInstance.post<ComicsBaseModel>(
        url: 'comics/base/findList',
        body: body,
        complete: ComicsBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  /// 获取可选classify
  /// [mark] 1-禁区视频 2-短视频 3-禁播奇案 4-精选推荐
  Future<List<VideoClassifyModel>> getVideoClassifyOptionalList(
      {required int mark}) async {
    try {
      final resp = await httpInstance.get(
        url: 'video/queryClassifyList',
        queryMap: {
          'mark': mark,
        },
        complete: VideoClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  // 获取我的classify
  Future<List<VideoClassifyModel>?> getVideoClassifySelected() async {
    try {
      final resp = await httpInstance.get(
        url: 'video/selectedClassifyList',
        queryMap: {'mark': 4, 'withDefault': true},
        complete: VideoClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 保存classify
  Future<bool> saveVideoClassifySelected(List<int> classifyIds) async {
    try {
      await httpInstance.post(
        url: 'video/addSelectedClassify',
        body: {'classifyIds': classifyIds},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 获取短视频分类
  ///[mark] 1-禁区视频 2-短视频 3-禁播奇案 4-精选推荐
  Future<List<VideoClassifyModel>> getShortVideoClassify(
      {required int mark}) async {
    try {
      final resp = await httpInstance.get<VideoClassifyModel>(
        url: 'short/video/getShortVideoClassify',
        queryMap: {
          'mark': mark,
        },
        complete: VideoClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  //用户购买视频
  Future<ShortVideosResp?> getShortVideos({
    required int page,
    required int pageSize,
    required String classifyId,
    required int videoMark, //视频标记：1-禁区视频 2-短视频 3-禁播视频 4-精选推荐
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'short/video/getShortVideos',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyId': classifyId,
          'videoMark': videoMark,
        },
      );
      return ShortVideosResp.fromJson(resp);
    } catch (e) {
      return null;
    }
  }

  /// 根据分类获取短视频
  /// [videoMark] 视频标记：1-禁区视频 2-短视频 3-禁播视频 4-精选推荐
  Future<List<ShortVideoModel>> getShortVideoLists({
    required int page,
    required int pageSize,
    required String classifyId,
    required int videoMark,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'short/video/getShortVideos',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyId': classifyId,
          'videoMark': videoMark,
        },
        complete: ShortVideoModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }
}
