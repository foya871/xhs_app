part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiCommunity on _Api {
  // 获取分类(包含固定和已选的)
  Future<List<CommunityClassifyModel>?> getCommunityClassify(bool post) =>
      _getCommunityClassify(post);

  Future<List<CommunityClassifyModel>?> _getCommunityClassify(bool post) async {
    try {
      final resp = await httpInstance.get<CommunityClassifyModel>(
        url: 'community/dynamic/classify/list',
        queryMap: {'post': post},
        complete: CommunityClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 点赞
  Future<bool> toggleCommunityLike(int dynamicId,
      {required bool isLike}) async {
    try {
      String apiUrl = '';
      if (isLike == true) {
        apiUrl = "community/dynamic/unLike";
      } else {
        apiUrl = "community/dynamic/like";
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {'dynamicId': dynamicId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // 收藏
  Future<bool> toggleCommunityFavorite(int dynamicId,
      {required bool isFavorite}) async {
    try {
      String apiUrl = '';
      if (isFavorite == true) {
        apiUrl = 'community/dynamic/unFavorite';
      } else {
        apiUrl = 'community/dynamic/favorite';
      }
      final _ = await httpInstance.post(
        url: apiUrl,
        body: {'dynamicId': dynamicId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // 获取可选classify
  Future<List<CommunityClassifyModel>?>
      getCommunityClassifyOptionalList() async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/classify/optionalList',
        complete: CommunityClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 刷动态
  Future<List<CommunityBaseModel>?> getCommunityBrushList({
    required int dynamicId,
    required int page,
    required int pageSize,
    int? userId,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/brushList',
        queryMap: {
          'dynamicId': dynamicId,
          'page': page,
          'pageSize': pageSize,
          'userId': userId,
        },
        complete: CommunityBaseModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  ///查询所有合集/用户的合集
  Future<List<CollectionBaseModel>> queryCollectionByUser(
      {required int page, required int pageSize, required int userId}) async {
    try {
      final resp = await httpInstance.get(
        url: 'bloggerCollection/queryCollectionByUser',
        queryMap: {'page': page, 'pageSize': pageSize, 'userId': userId},
        complete: CollectionBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  ///删除合集
  Future<bool?> delCollection(List<int> ids) async {
    try {
      await httpInstance.post(
        url: 'bloggerCollection/delCollection',
        body: {'collectionIds': ids},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///设置会移除合集
  Future<bool> batchCollection(
      List<int> dynamicIds, String collectionName, int flag) async {
    try {
      await httpInstance.post(url: 'community/dynamic/batchCollection', body: {
        'dynamicIds': dynamicIds,
        'collectionName': collectionName,
        "flag": flag
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // 获取我的classify
  Future<List<CommunityClassifyModel>> getCommunityClassifySelected() async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/classify/selectedList',
        complete: CommunityClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  ///资源分类列表
  Future<List<CommunityClassifyModel>?> getResourcesClassifyList() async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/resourcesClassify/list',
        complete: CommunityClassifyModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<ResourceDownloadModel?> getCommunityResourceList(
      int page, int pageSize, String classifyTitle) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/resources/list',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'classifyTitle': classifyTitle
        },
      );
      return ResourceDownloadModel.fromJson(resp);
    } catch (e) {
      return null;
    }
  }

  ///资源搜索
  Future<ResourceDownloadModel?> searchCommunityResourceList(
      int page, int pageSize, String title) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/resources/search',
        queryMap: {'page': page, 'pageSize': pageSize, 'title': title},
      );
      return ResourceDownloadModel.fromJson(resp);
    } catch (e) {
      return null;
    }
  }

  ///获取资源详情
  Future<ResourceInfoModel?> getCommunityResourceInfo(int resourcesId) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/resources/info',
        queryMap: {'resourcesId': resourcesId},
      );
      return ResourceInfoModel.fromJson(resp);
    } catch (e) {
      return null;
    }
  }

  ///获取资源反馈列表
  Future<List<ResourceReport>?> getCommunityResourcesReportList(
      int page, int pageSize, int resourcesId) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/resourcesReportList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'resourcesId': resourcesId
        },
        complete: ResourceReport.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<PictureCellModel>?> getPortrayPersonFindList(
      Map<String, dynamic>? body1,
      {int? page = 0,
      int? pageSize = 30}) async {
    Map<String, dynamic>? body = body1 ?? {};
    body["page"] = page;
    body["pageSize"] = pageSize;
    try {
      final resp = await httpInstance.get<PictureCellModel>(
        url: 'portray/getPictureList',
        queryMap: body,
        complete: PictureCellModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<PopularSkitsBaseFindModel>?> getPopularSkitsFindList(
      Map<String, dynamic>? body1,
      {int? page = 0,
      int? pageSize = 30}) async {
    Map<String, dynamic>? body = body1 ?? {};
    body["page"] = page;
    body["pageSize"] = pageSize;
    try {
      final resp = await httpInstance.get<PopularSkitsBaseFindModel>(
        url: 'short/video/getShortVideos',
        queryMap: body,
        complete: PopularSkitsBaseFindModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<IntensionMapBaseFindModel>?> getIntensionMapFindList(
      Map<String, dynamic>? body1,
      {int? page = 0,
      int? pageSize = 30}) async {
    Map<String, dynamic>? body = body1 ?? {};
    body["page"] = page;
    body["pageSize"] = pageSize;
    try {
      final resp = await httpInstance.get<IntensionMapBaseFindModel>(
        url: 'connotation/list',
        queryMap: body,
        complete: IntensionMapBaseFindModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<TagListOtherTagListItem>?> getPortrayPortrayClassify() async {
    Map<String, dynamic>? body = {};
    try {
      final resp = await httpInstance.get<TagListOtherTagListItem>(
        url: 'portray/getPortrayClassify',
        queryMap: body,
        complete: TagListOtherTagListItem.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<ShortVideoGetShortVideoClassify>?>
      getShortVideoShortVideoClassify(int mark) async {
    Map<String, dynamic>? body1 = {"mark": mark, "_t": 1741750116126};
    try {
      final resp = await httpInstance.get<ShortVideoGetShortVideoClassify>(
        url: 'short/video/getShortVideoClassify',
        queryMap: body1,
        complete: ShortVideoGetShortVideoClassify.fromJson,
      );

      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<ConnotationClassifyListTag>?> getConnotationClassifyList() async {
    Map<String, dynamic>? body = {};
    try {
      final resp = await httpInstance.get<ConnotationClassifyListTag>(
        url: 'connotation/classifyList',
        queryMap: body,
        complete: ConnotationClassifyListTag.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<OtherClassListOtherTagListItem>?>
      getComicsOtherClassList() async {
    Map<String, dynamic>? body = {};
    try {
      final resp = await httpInstance.get<OtherClassListOtherTagListItem>(
        url: 'comics/other/classList',
        queryMap: body,
        complete: OtherClassListOtherTagListItem.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<ComicsOtherTagListItem>?> getComicsOtherTagList() async {
    Map<String, dynamic>? body = {};
    try {
      final resp = await httpInstance.get<ComicsOtherTagListItem>(
        url: 'comics/other/tagList',
        queryMap: body,
        complete: ComicsOtherTagListItem.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类(包含固定和已选的)
  Future<List<IntensionMapDetailComment>?> getConnotationCommentList(
      {int? connotationId, int? page = 0, int? pageSize = 30}) async {
    Map<String, dynamic>? body = {};
    body["connotationId"] = connotationId;
    body["page"] = page;
    body["pageSize"] = pageSize;
    try {
      final resp = await httpInstance.get<IntensionMapDetailComment>(
        url: 'connotation/commentList',
        queryMap: body,
        complete: IntensionMapDetailComment.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取分类详情
  Future<IntensionMapDetailModel?> getIntensionMapDetailFindList(
      {int? connotationId, int? page = 0, int? pageSize = 30}) async {
    Map<String, dynamic>? body = {};
    body["page"] = page;
    body["pageSize"] = pageSize;
    body["connotationId"] = connotationId;
    try {
      final resp = await httpInstance.get(
        url: 'connotation/detail',
        queryMap: body,
      );
      return IntensionMapDetailModel.fromJson(resp);
    } catch (e) {
      return null;
    }
  }

  // 没有关注的时候，推荐的用户
  Future<List<PortrayGetPictureListItem>?> portrayGetPictureList(
      Map<String, dynamic>? body1,
      {int? page = 0,
      int? pageSize = 30}) async {
    Map<String, dynamic>? body = body1 ?? {};
    body["page"] = page;
    body["pageSize"] = pageSize;
    try {
      final resp = await httpInstance.get(
        url: 'portray/getPictureList',
        queryMap: body,
        complete: PortrayGetPictureListItem.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<CommunityResourceClassifyModel?>
      getCommunityResourceClassifyList() async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/resourcesClassify/list',
      );
      return CommunityResourceClassifyModel.fromJson(resp);
    } catch (e) {
      return null;
    }
  }

  // 保存classify
  Future<bool> saveCommunityClassifySelected(List<int> classifyIds) async {
    try {
      await httpInstance.post(
        url: 'community/dynamic/classify/add',
        body: {'classifyIds': classifyIds},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // 获取关注的人的动态
  Future<CommunityAttentionResp?> getCommunityAttentionList(
      {required int page, required int pageSize}) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/attentionList',
        queryMap: {'page': page, 'pageSize': pageSize},
        requestEntireModel: true,
        complete: CommunityAttentionResp.fromJson,
      );

      return resp;
    } catch (e) {
      return null;
    }
  }

  // 没有关注的时候，推荐的用户
  Future<List<CommunityNotConcernedModel>?> getCommunityNotConcernedList(
      {required int page, required int pageSize}) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/notConcerned/list',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityNotConcernedModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 投诉
  Future<bool> complaintCommunity({
    required int dynamicId,
    required int reason,
    String? remark,
    List<String>? imgs,
  }) async {
    try {
      if (remark?.isEmpty == true) remark = null;
      if (imgs?.isEmpty == true) imgs = null;

      await httpInstance.post(
        url: 'community/dynamic/complaint',
        body: {
          'dynamicId': dynamicId,
          'imgs': imgs,
          'reason': reason,
          'remark': remark,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // 拉取关注的人最新的动态消息
  Future<List<CommunityPushMessageModel>?> getCommunityPushMessage() async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/pushMessage',
        complete: CommunityPushMessageModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 是否是否可以观看
  Future<CommunityVideoCanWatchModel?> getCommunityVideoCanWatch(
      int dynamicId) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/canWatch',
        queryMap: {'dynamicId': dynamicId},
        complete: CommunityVideoCanWatchModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityModel>?> getRankDynamicList() async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/hotRankList',
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoBaseModel>?> queryPersonVideoByType({
    required int userId,
    required int videoMark,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/queryPersonVideoByType',
        queryMap: {
          'userId': userId,
          'videoMark': videoMark,
          'page': page,
          'pageSize': pageSize,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<bool?> addVideo({
    required String checkSum,
    required String id,
    int? price,
    int? size,
    required int playTime,
    required List<String> tagTitles,
    required String title,
    required String videoUrl,
    List<String>? coverImg,
    /**视频类型：0-普通视频 1-VIP视频 2-付费视频 */
    int? videoType,
    /**竖版封面 */
    List<String>? verticalImg,
  }) async {
    try {
      await httpInstance.post(url: "video/addVideo", body: {
        "checkSum": checkSum,
        "coverImg": coverImg,
        "id": id,
        "playTime": playTime,
        "price": price,
        "size": size,
        "tagTitles": tagTitles,
        "title": title,
        "videoUrl": videoUrl,
        "verticalImg": verticalImg,
        "videoType": videoType,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  // 短视频-发现
  Future<List<TagsModel>?> fetchShortVideoDiscoverTags() =>
      fetchAllVideoTags(1, true);

  // 片库
  Future<List<TagsModel>?> fetchVideoBoxTags() => fetchAllVideoTags(1);

  ///获取所有标签
  Future<List<TagsModel>?> fetchAllVideoTags(
      [int? mark, bool? isRecommend]) async {
    try {
      final res = await httpInstance.get<TagsModel>(
        url: "video/getVideoTags",
        queryMap: {'mark': mark, 'isRecommend': isRecommend},
        complete: TagsModel.fromJson,
      );
      return res;
    } catch (_) {
      return null;
    }
  }

  Future<bool> buyInfoPromotion({
    required int infoId,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: "infoPromotion/pur",
        body: {
          'infoId': infoId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

// 评论点赞
  Future<bool?> dynamicCommentLike(int commentId) async {
    try {
      await httpInstance.post(url: 'community/dynamic/comment/saveLike', body: {
        'commentId': commentId,
      });
      return true;
    } catch (e) {
      return null;
    }
  }

  // 取消评论点赞
  Future<bool?> dynamicCommentUnLike(int commentId) async {
    try {
      await httpInstance.post(
        url: 'community/dynamic/comment/unLike',
        body: {'commentId': commentId},
      );
      return true;
    } catch (e) {
      return null;
    }
  }

  // toogle 点赞
  Future<bool?> toogleDynamicCommentLike(int commentId, {required bool? like}) {
    if (like == true) {
      return dynamicCommentUnLike(commentId);
    } else {
      return dynamicCommentLike(commentId);
    }
  }

  // 创建合集
  Future<bool?> addBloggerCollection(
      String collectionName, String collectionCoverImg) async {
    try {
      await httpInstance.post(
        url: 'bloggerCollection/add',
        body: {
          'collectionName': collectionName,
          'collectionCoverImg': collectionCoverImg
        },
      );
      return true;
    } catch (e) {
      return null;
    }
  }

// 成人资讯评论点赞
  Future<bool?> infoCommentLike(int commentId) async {
    try {
      await httpInstance.post(url: 'infoPromotion/comment/saveLike', body: {
        'commentId': commentId,
      });
      return true;
    } catch (e) {
      return null;
    }
  }

  // 取消评论点赞
  Future<bool?> infoCommentUnLike(int commentId) async {
    try {
      await httpInstance.post(
        url: 'infoPromotion/comment/unLike',
        body: {'commentId': commentId},
      );
      return true;
    } catch (e) {
      return null;
    }
  }

  // toogle 点赞
  Future<bool?> toogleInfocCommentLike(int commentId, {required bool? like}) {
    if (like == true) {
      return infoCommentUnLike(commentId);
    } else {
      return infoCommentLike(commentId);
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<List<CommunityBaseModel>?> getCommunityListByClassify({
    required String classifyTitle,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/list',
        queryMap: {
          'classifyTitle': classifyTitle,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityDateModel>?> getDateDynamicList({
    required String queryDate,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityDateModel>(
        url: 'community/dynamic/list',
        queryMap: {
          'queryDate': queryDate,
        },
        complete: CommunityDateModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityDateModel>?> getDateDynamicList2({
    required String queryDate,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityDateModel>(
        url: 'community/dynamic/indexDaily',
        queryMap: {
          'queryDate': queryDate,
        },
        complete: CommunityDateModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityDateModel>?> getDayDynamicList({
    required int classifyId,
    required int viewed,
    required int sortType,
    required int page,
    required int pageSize,
  }) async {
    try {
      Map<String, dynamic>? queryMap;
      if (viewed == 0) {
        queryMap = {
          'classifyId': classifyId,
          'sortType': sortType,
          'page': page,
          'pageSize': pageSize,
        };
      } else if (viewed == 1) {
        queryMap = {
          'classifyId': classifyId,
          'viewed': false,
          'sortType': sortType,
          'page': page,
          'pageSize': pageSize,
        };
      } else if (viewed == 2) {
        queryMap = {
          'classifyId': classifyId,
          'viewed': true,
          'sortType': sortType,
          'page': page,
          'pageSize': pageSize,
        };
      }
      final resp = await httpInstance.get<CommunityDateModel>(
        url: 'community/dynamic/list',
        queryMap: queryMap,
        complete: CommunityDateModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityModel>?> getDynamicList({
    required int classifyId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/list',
        queryMap: {
          'classifyId': classifyId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityModel>?> getTopicDynamicList({
    required String topicId,
    required int sortType,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/list',
        queryMap: {
          'topicId': topicId,
          'sortType': sortType,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityModel>?> getHotTopicDynamicList({
    required String topicId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/list',
        queryMap: {
          'topicId': topicId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<BloggerModel>?> getHotBloggerList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<BloggerModel>(
        url: 'community/dynamic/hotUserList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: BloggerModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityBaseModel>?> getTopicInfo({
    required String name,
    required int page,
    required int pageSize,
    required int sortType,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityBaseModel>(
        url: 'topic/info',
        queryMap: {
          'name': name,
          'page': page,
          'pageSize': pageSize,
          'sortType': sortType,
        },
        complete: CommunityBaseModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  // 个人动态列表
  Future<List<CommunityBaseModel>?> getCommunityPersonList({
    String? collectionName,
    bool? exclusiveToFans,
    String? searchWord,
    int? status,
    int? userId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/person/list',
        queryMap: {
          'collectionName': collectionName,
          'exclusiveToFans': exclusiveToFans,
          'searchWord': searchWord,
          'status': status,
          'userId': userId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<CommunityModel>?> getActionDynamicList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/userAction',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<bool> communityRelease({
    required CommunityReleaseModel bean,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: "community/dynamic/release",
        body: bean.toJson(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> communityResourceRelease({
    required CommunityResourceModel bean,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: "community/dynamic/releaseResources",
        body: bean.toJson(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<CommunityTopicModel>?> getTopicList({
    required int page,
    required int pageSize,
    bool noPage = false,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityTopicModel>(
        url: 'topic/list',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'noPage': noPage,
        },
        complete: CommunityTopicModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoLabelModel>?> getVideoLabelList() async {
    try {
      final resp = await httpInstance.get<VideoLabelModel>(
        url: 'video/tagsList',
        queryMap: {
          // 'parentId': 0,
        },
        complete: VideoLabelModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<BloggerModel>?> getBloggerList({
    required int dynamicId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<BloggerModel>(
        url: 'community/dynamic/dynamicLikerList',
        queryMap: {
          'dynamicId': dynamicId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: BloggerModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // video类型需要canWatch接口的数据
  // 传入type， 并行发起请求，
  // 不传入type，串行请求，先发起详情，然后再发起canWath
  Future<CommunityModel?> getDynamicDetail(int dynamicId,
      {CommunityType? type}) async {
    try {
      Future<CommunityVideoCanWatchModel?>? canWatchFuture;
      if (type == CommunityTypeEnum.video) {
        canWatchFuture = getCommunityVideoCanWatch(dynamicId);
      }
      final detailFuture = httpInstance.get<CommunityModel>(
        url: 'community/dynamic/dynamicInfo',
        queryMap: {'dynamicId': dynamicId},
        complete: CommunityModel.fromJson,
      );
      CommunityVideoCanWatchModel? canWatch;
      if (canWatchFuture != null) {
        final can = await canWatchFuture;
        if (can == null) return null; // 认为失败
        canWatch = can;
      }
      final CommunityModel? detail = await detailFuture;
      if (detail == null) return null;
      if (canWatch == null && detail.isVideo) {
        canWatch = await getCommunityVideoCanWatch(dynamicId);
        if (canWatch == null) return null; // 认为失败
      }
      detail.resetByCanWatch(canWatch);
      return detail;
    } catch (e) {
      return null;
    }
  }

  Future<bool> buyCommunity(int dynamicId) async {
    try {
      final _ = await httpInstance.post(
        url: "community/dynamic/pur",
        body: {'dynamicId': dynamicId},
      );
      return true;
    } catch (e) {
      final model = ApiErrorWrap.wrap(e);
      if (model.msg != null) {
        EasyToast.show(model.msg ?? '');
      }
      return false;
    }
  }

  ///购买资源
  Future<bool> buyResourceUnlock(int resourcesId) async {
    try {
      final _ = await httpInstance.post(
        url: "community/dynamic/resources/unlock",
        body: {'resourcesId': resourcesId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///资源反馈
  Future<bool> resourceReport(
      int reason, int resourcesId, String remark) async {
    try {
      final _ = await httpInstance.post(
        url: "community/dynamic/resources/report",
        body: {'resourcesId': resourcesId, "reason": reason, "remark": remark},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> communityAttention({
    required int toUserId,
    required bool isAttention,
  }) async {
    try {
      String apiUrl = '';
      if (isAttention == true) {
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

  // 我的下载
  Future<List<DownloadResourceModel>?> getDownloadResourceList({
    String? classifyTitle,
    int? classifyId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get(
        // url: 'community/dynamic/my/downloads',
        url: 'community/dynamic/my/downloads',
        queryMap: {
          'classifyTitle': classifyTitle,
          'classifyId': classifyId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: DownloadResourceModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
