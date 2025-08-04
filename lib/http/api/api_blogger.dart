part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiBlogger on _Api {
  ///获取博主信息
  Future<UserInfo?> queryBloggerInfo(String userId) async {
    try {
      final s = await httpInstance.post(
          url: "user/base/info",
          body: {'userId': userId},
          complete: UserInfo.fromJson);
      return s;
    } catch (e) {
      return null;
    }
  }

  ///举报用户
  Future<bool?> complaintUser({
    required int userId,
    required int reason,
    required String remark,
    required List<String> imgs,
  }) async {
    try {
      Map<String, dynamic> body = {
        "beUserId": userId,
        "imgs": imgs,
        "reason": reason,
        "remark": remark
      };
      await httpInstance.post(
        url: 'user/report',
        body: body,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///获取博主笔记列表,私人团列表
  Future<List<CommunityBaseModel>> getBloggerNoteList({
    required int userId,
    required int page,
    bool exclusiveToFans = false,
    String searchWord = "",
    int pageSize = 20,
  }) async {
    Map<String, dynamic> queryMap = {
      'userId': userId,
      'exclusiveToFans': exclusiveToFans,
      'page': page,
      'pageSize': pageSize,
    };
    if (searchWord.isNotEmpty) {
      queryMap['searchWord'] = searchWord;
    }

    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/person/list',
        queryMap: queryMap,
        complete: CommunityBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取博主收藏笔记列表
  Future<List<CommunityBaseModel>> getBloggerCollectionNoteList({
    required int userId,
    required int page,
    String searchWord = "",
    int pageSize = 20,
  }) async {
    Map<String, dynamic> queryMap = {
      'userId': userId,
      'page': page,
      'pageSize': pageSize,
    };
    if (searchWord.isNotEmpty) {
      queryMap['searchWord'] = searchWord;
    }

    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/userFavorite',
        queryMap: queryMap,
        complete: CommunityBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }
  Future<List<ComicsBaseModel>> getBloggerCollectionCommodityList({
    required int userId,
    required int page,
    String searchWord = "",
    int pageSize = 20,
  }) async {
    Map<String, dynamic> queryMap = {
      'userId': userId,
      'page': page,
      'pageSize': pageSize,
    };
    if (searchWord.isNotEmpty) {
      queryMap['searchWord'] = searchWord;
    }

    try {
      final resp = await httpInstance.get(
        url: 'product/like/list',
        queryMap: queryMap,
        complete: ComicsBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }
  ///获取博主资源列表
  Future<List<CommunityBaseModel>> getBloggerResourceList({
    required int userId,
    required int page,
    String searchWord = "",
    int pageSize = 20,
  }) async {
    Map<String, dynamic> queryMap = {
      'userId': userId,
      'page': page,
      'pageSize': pageSize,
    };
    if (searchWord.isNotEmpty) {
      queryMap['searchWord'] = searchWord;
    }

    try {
      final resp = await httpInstance.get(
        url: 'community/dynamic/personResourcesList',
        queryMap: queryMap,
        complete: CommunityBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取博主的群聊列表
  Future<List<GroupChatroomModel>?> queryChatRoomByUserId(
      int userId, int page, int pageSize) async {
    try {
      final resp = await httpInstance.get(
        url: 'chatRoom/myRoomList',
        queryMap: {
          'userId': userId,
          'page': page,
          'pageSize': pageSize,
        },
        complete: GroupChatroomModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///获取热门群聊列表
  Future<List<GroupChatroomModel>?> queryHotChatRoomList() async {
    try {
      final resp = await httpInstance.get(
        url: 'chatRoom/hotList',
        complete: GroupChatroomModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///加入群聊
  Future<bool> joinGroupChat(int roomId) async {
    try {
      await httpInstance.post(
        url: 'chatRoom/join',
        body: {'roomId': roomId},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///获取博主的粉丝团
  Future<BloggerFansGroupModel?> queryFansGroupByUserId(int? userId) async {
    try {
      final resp = await httpInstance.get(
        url: 'bloggerFansGroup/queryFansGroupByUserId',
        queryMap: {'userId': userId},
        complete: BloggerFansGroupModel.fromJson,
      );

      return resp;
    } catch (e) {
      return null;
    }
  }

  ///获取粉丝排行榜
  Future<List<BloggerFansModel>> queryFansRankingList(
      int userId, int page, int pageSize) async {
    try {
      final resp = await httpInstance.get(
        url: 'bloggerFansGroup/queryFansGroupRank',
        queryMap: {'userId': userId, 'page': page, 'pageSize': pageSize},
        complete: BloggerFansModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取粉丝团团票
  Future<List<BloggerFansTicketModel>> queryFansGroupTicket() async {
    try {
      final resp = await httpInstance.get(
        url: 'bloggerFansGroup/getTicketList',
        complete: BloggerFansTicketModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return [];
    }
  }

  ///加入粉丝团
  ///[ticketType] 团票类型(1-月票,2-季票,3-年票)
  Future<bool> joinFansGroup(int groupId, int ticketType) async {
    try {
      await httpInstance.post(
        url: 'bloggerFansGroup/join',
        body: {'groupId': groupId, 'ticketType': ticketType},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///获取粉丝团成员列表
  Future<List<BloggerFansModel>?> queryFansGroupUser({
    required int userId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'bloggerFansGroup/queryFansGroupUser',
        queryMap: {'userId': userId, 'page': page, 'pageSize': pageSize},
        complete: BloggerFansModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
