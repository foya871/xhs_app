part of 'api.dart';

extension ApiMine on _Api {
  ///获取充值记录
  ///[tranType] 2:VIP记录 3:金币记录
  Future<List<RecordModel>> geRechargeRecordList({
    required int tranType,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get<RecordModel>(
        url: 'rech/list',
        queryMap: {
          'rechType': tranType,
          'page': page,
          'pageSize': pageSize,
        },
        complete: RecordModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  //用户推广记录
  Future<List<ShareRecordModel>?> getShareRecordList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<ShareRecordModel>(
        url: 'user/getUserProcess',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ShareRecordModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //用户收藏视频
  Future<List<VideoBaseModel>?> getUserFavoritesList({
    required int page,
    required int pageSize,
    required int videoMark, //1-长视频 2-短视频
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/userFavorites',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'videoMark': videoMark,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //用户收藏资源
  Future<List<ResourceModel>?> getUserFavoritesResourceList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<ResourceModel>(
        url: 'resource/userLikeList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ResourceModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //用户观看视频
  Future<List<VideoBaseModel>?> getBrowseRecord({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/getBrowseRecord',
        queryMap: {
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

  //用户购买视频
  Future<List<VideoBaseModel>?> getUserPurVideo({
    required int page,
    required int pageSize,
    required int videoMark, //1-长视频 2-短视频
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/userPurVideo',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'videoMark': videoMark,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //清理用户观看/收藏/购买/下载记录
  Future<bool> clearUserRecord({
    required int type,
    required List<int> videoIds,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: 'video/clearUserRecord',
        body: {
          'type': type, //清理类型:1-观看2-收藏3-购买4-下载
          'videoIds': videoIds,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  //删除资源
  Future<bool> clearUserResource({
    required List<int> resourceIds,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: 'resource/delLike',
        body: {
          'resourceIds': resourceIds,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  //获取分享链接
  Future<ShareRespModel?> getShareLink() async {
    final resp = await httpInstance.get<ShareRespModel>(
      url: 'user/shared/link',
      complete: ShareRespModel.fromJson,
    );
    return resp;
  }

  //在线客服
  Future<ServiceModel?> getOnlineService() async {
    try {
      final resp = await httpInstance.get<ServiceModel>(
        url: 'news/customer/sign',
        complete: ServiceModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  //获取支付链接
  Future<PayLinkModel?> getRechargeUrl(RechargeRequestModel req) async {
    try {
      final resp = await httpInstance.post<PayLinkModel>(
        url: 'rech/sumbit',
        body: req.toJson(),
        complete: PayLinkModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  // 获取支付链接 authored by dzw
  Future<BaseRespModel> buyToFetchResult(RechargeRequestModel req) {
    return ApiCode.warp(
      httpInstance.post(
        url: 'rech/sumbit',
        body: req.toJson(),
      ),
    );
  }

//我的发布--帖子
  Future<List<PublicationsPostsModel>?> getPublicationsPostsList({
    required int userId,
    required int status,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'community/dynamic/person/list',
        queryMap: {
          'userId': userId,
          'status': status,
          'page': page,
          'pageSize': pageSize,
        },
        complete: PublicationsPostsModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return null;
    }
  }

  //个人主页视频查询_精选、up主推荐、合集或者粉丝专属
  Future<List<VideoBaseModel>?> getPublicationsVideosList({
    bool? bzRecommend,
    String? collectionName,
    int? featuredOrFans, //视频上传类型(1-精选视频，2-粉丝专属)
    int? userId,
    required int page,
    int pageSize = 60,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'video/queryPersonVideoByType',
        queryMap: {
          'bzRecommend': bzRecommend,
          'collectionName': collectionName,
          'featuredOrFans': featuredOrFans,
          'page': page,
          'pageSize': pageSize,
          'userId': userId,
        },
        complete: VideoBaseModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return null;
    }
  }

  ///我邀请的人
  Future<List<SpreadUserModel>?> fecthSpreadUserList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<SpreadUserModel>(
        url: 'user/getUserProcess',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: SpreadUserModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///动态收益
  Future<List<ProfitDynamicItemModel>?> fecthSpreadDynamiProfitList({
    required int page,
    required int pageSize,
    required int incomeType,
  }) async {
    try {
      final resp = await httpInstance.get<ProfitDynamicItemModel>(
        url: 'user/income',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          "incomeType": incomeType,
        },
        complete: ProfitDynamicItemModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<ProfitModel>?> getProfitListByType({
    required int page,
    required int pageSize,
    required int incomeType,
  }) async {
    try {
      final resp = await httpInstance.get<ProfitModel>(
        url: 'user/income',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          "incomeType": incomeType,
        },
        complete: ProfitModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///用户收益统计
  Future<ProfitTotalModel?> fecthSpreadTotalData() async {
    try {
      final resp = await httpInstance.get<ProfitTotalModel>(
        url: 'user/incomeStat',
        complete: ProfitTotalModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  ///拼团会员
  Future<List<GroupMembersModel>?> getGroupMembersList(
      {required int page}) async {
    try {
      final response = await httpInstance.get(
          url: 'group/groupList',
          queryMap: {
            'page': page,
            'pageSize': 20,
          },
          complete: GroupMembersModel.fromJson);
      return response ?? [];
    } catch (_) {
      return null;
    }
  }

  ///拼团记录
  Future<List<GroupMembersModel>?> getGroupMembersHistoryList(
      {required int page}) async {
    try {
      final response = await httpInstance.get(
          url: 'group/history',
          queryMap: {
            'page': page,
            'pageSize': 20,
          },
          complete: GroupMembersModel.fromJson);
      return response ?? [];
    } catch (_) {
      return null;
    }
  }

  ///会员卡和金币列表
  Future<VipGoldTypeModel?> getVipGoldCards() async {
    try {
      final response = await httpInstance.get(
        url: 'user/vip/card/list',
        complete: VipGoldTypeModel.fromJson,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  ///帖子收益详情
  Future<List<BuyDynamic>?> getBuyDynamicDetails(
      {required int page, required int dynamicId}) async {
    try {
      final response = await httpInstance.get(
        url: 'community/dynamic/user/purDetails',
        queryMap: {
          'page': page,
          'pageSize': 20,
          'dynamicId': dynamicId,
        },
        complete: BuyDynamic.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return null;
    }
  }

  ///视频收益详情
  Future<List<BuyDynamic>?> getBuyVideoDetails(
      {required int page, required int videoId, required int videoMark}) async {
    try {
      final response = await httpInstance.get(
        url: 'video/getPurVideoRecordByVideoId',
        queryMap: {
          'page': page,
          'pageSize': 20,
          'videoId': videoId,
          'videoMark': videoMark,
        },
        complete: BuyDynamic.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return null;
    }
  }

  //用户收藏的合集
  Future<List<CollectionBaseModel>?> getUserFavoritesCollectList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CollectionBaseModel>(
        url: 'bloggerCollection/userFavorites',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: CollectionBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///获取博主收藏的商品
  Future<Map<String, dynamic>?> getBloggerCollectionProduct({
    required int page,
    String searchWord = "",
    int pageSize = 20,
  }) async {
    Map<String, dynamic> queryMap = {
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
        complete: null,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  //删除审核未通过的视频
  Future<bool> delCheckVideo({
    required List<int> videoId,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: 'video/delAuditFailVideo',
        body: {
          'videoId': videoId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  //删除审核未通过的G圈
  Future<bool> delCheckCommunity({
    required List<int> dynamicIds,
  }) async {
    try {
      final _ = await httpInstance.post(
        url: 'community/dynamic/del',
        body: {
          'dynamicIds': dynamicIds,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  //G圈购买列表
  Future<List<CommunityModel>?> getBuyCommunityList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/user/purList',
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

  ///笔记浏览记录
  Future<List<CommunityModel>?> getRecordCommunityList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/getBrowseRecord',
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

  ///漫画浏览记录
  Future<List<ComicsBaseModel>?> getRecordComicsList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<ComicsBaseModel>(
        url: 'comics/base/getBrowseRecord',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ComicsBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///写真浏览记录
  Future<List<PictureCellModel>?> getRecordPortrayList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<PictureCellModel>(
        url: 'portray/getBrowseRecord',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: PictureCellModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///内涵图浏览记录
  Future<List<ConnotationModel>?> getRecordConnotationList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<ConnotationModel>(
        url: 'connotation/getBrowseRecord',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ConnotationModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoBaseModel>?> getRecordVideoList({
    required int page,
    required int pageSize,
    required int videoMark,
  }) async {
    try {
      final resp = await httpInstance.get<VideoBaseModel>(
        url: 'video/getBrowseRecord',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'videoMark': videoMark,
        },
        complete: VideoBaseModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///商品浏览记录
  Future<List<ProductModel>?> getRecordProductList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<ProductModel>(
        url: 'product/getBrowseRecord',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ProductModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///游戏浏览记录
  Future<List<AdultGameModel>?> getRecordGameList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<AdultGameModel>(
        url: 'adultgame/getBrowseRecord',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: AdultGameModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //G圈收藏列表
  Future<List<CommunityDateModel>?> getFavoriteCommunityDataList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityDateModel>(
        url: 'community/dynamic/userFavorite',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: CommunityDateModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //我的笔记收藏列表
  Future<Map<String, dynamic>?> getMineCollectCommunityDataList(
      {required int page,
      required int pageSize,
      String searchWord = ''}) async {
    try {
      final resp = await httpInstance.get<CommunityDateModel>(
        url: 'community/dynamic/userFavorite',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'searchWord': searchWord
        },
        complete: null,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  //我发布的G圈列表
  Future<List<CommunityModel>?> getMineReleaseCommunityDataList({
    required int page,
    required int pageSize,
    required int status, //1-审核中，2-审核通过，3-审核拒绝
    required bool exclusiveToFans,

    ///是否粉丝专属
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/person/list',
        queryMap: {
          'status': status,
          'exclusiveToFans': exclusiveToFans,
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

  ///批量设置粉丝专属
  Future<bool> batchFans({
    required List<int> dynamicIds,
    required int flag, //1-粉丝专属 2-取消粉丝专属
  }) async {
    try {
      await httpInstance.post(url: "community/dynamic/batchFans", body: {
        "dynamicIds": dynamicIds,
        "flag": flag,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteCommunity({
    required List<int> dynamicIds,
  }) async {
    try {
      final resp = await httpInstance.post(url: "community/dynamic/del", body: {
        "dynamicIds": dynamicIds,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  ///我的购买-游戏记录
  Future<List<AdultGameModel>?> getBuyGameRecord({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<AdultGameModel>(
        url: 'adultgame/getBuyGameRecord',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: AdultGameModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //粉丝团购买列表
  Future<List<FansClubModel>?> getBuyFansClubDataList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<FansClubModel>(
        url: 'bloggerFansGroup/getMyJoinList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: FansClubModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///获取聊天列表
  Future<List<ChatListMessageModel>> getChatList({
    required int page,
  }) async {
    try {
      List<ChatListMessageModel> resp =
          await httpInstance.get<ChatListMessageModel>(
        url: 'privateChat/chatList',
        queryMap: {
          'page': page,
          'pageSize': 20,
        },
        complete: ChatListMessageModel.fromJson,
      );
      return resp;
    } catch (e) {
      return [];
    }
  }

  ///删除某个聊天
  Future<bool> deleteItem(int toUserId) async {
    try {
      final resp = await httpInstance.post(url: "privateChat/delChat", body: {
        "toUserId": toUserId,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  ///获取消息通知内容
  Future<List<MessageNoticeContentModel>> getMessageContents(
      {int? informationType, required int page}) async {
    try {
      List<MessageNoticeContentModel> resp = await httpInstance.get(
          url: "information/user/notice",
          queryMap: {
            "informationType": informationType,
            "page": page,
            "pageSize": 20,
          },
          complete: MessageNoticeContentModel.fromJson);
      return resp;
    } catch (_) {
      return [];
    }
  }

  Future<bool> messageFollowAttention({
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

  Future<bool> withdrawal(String accountNo, double money, int payType,
      int purType, String receiptName) async {
    try {
      final _ = await httpInstance.post(
        url: "wd/apply",
        body: {
          'accountNo': accountNo,
          'money': money,
          'payType': payType,
          'purType': purType,
          'receiptName': receiptName,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///获取群分类
  Future<List<GroupClassificationModel>> getGroupCLassification() async {
    try {
      List<GroupClassificationModel> resp = await httpInstance.get(
          url: "chatRoom/classify/List",
          complete: GroupClassificationModel.fromJson);
      return resp;
    } catch (_) {
      return [];
    }
  }

  ///创建聊天室
  Future<bool> createGroup(
      String classifyName, String info, String roomName) async {
    try {
      final resp = await httpInstance.post(url: "chatRoom/create", body: {
        "classifyName": classifyName,
        "info": info,
        "roomName": roomName,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  ///获取聊天室列表
  Future<List<GroupChatroomModel>> getGroupChatRooms(
      {String? classifyName, required int page}) async {
    try {
      List<GroupChatroomModel> resp = await httpInstance.get(
          url: "chatRoom/list",
          queryMap: {
            "classifyName": classifyName,
            "page": page,
            "pageSize": 20,
          },
          complete: GroupChatroomModel.fromJson);
      return resp;
    } catch (_) {
      return [];
    }
  }

  ///获取群消息
  Future<List<ChatMessageXhsModel>> getGroupChatMessage(
      {int? lastId, int? roomId}) async {
    try {
      List<ChatMessageXhsModel> resp = await httpInstance.get(
          url: "chatMessage/list",
          queryMap: {
            "lastId": lastId == 0 ? null : lastId,
            "pageSize": 20,
            "roomId": roomId,
          },
          complete: ChatMessageXhsModel.fromJson);
      return resp;
    } catch (_) {
      return [];
    }
  }

  ///加入聊天室
  Future<bool> joinGroupChatRoom(int roomId) async {
    try {
      final resp = await httpInstance.post(url: "chatRoom/join", body: {
        "roomId": roomId,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  ///退出聊天室
  Future<bool> exitGroupChatRoom(int roomId) async {
    try {
      final resp = await httpInstance.post(url: "chatRoom/exit", body: {
        "roomId": roomId,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  ///解散聊天室
  Future<bool> disbandGroupChatRoom(int roomId) async {
    try {
      final resp = await httpInstance.post(url: "chatRoom/disband", body: {
        "roomId": roomId,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  ///发送群消息
  Future<bool> sendGroupChatMessage(
      {String? content, List<String>? imgs, required int roomId}) async {
    try {
      final resp = await httpInstance.post(url: "chatMessage/send", body: {
        "roomId": roomId == 0 ? null : roomId,
        "imgs": imgs,
        "content": content,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  ///发送私聊消息
  Future<bool> sendPrivateChatMessage(
      {String? content, List<String>? imgs, required int toUserId}) async {
    try {
      final resp = await httpInstance.post(url: "privateChat/send", body: {
        "toUserId": toUserId == 0 ? null : toUserId,
        "imgs": imgs,
        "content": content,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  ///获取私聊消息列表
  Future<PrivateChatmessageListModel?> getPrivateChatMessage(
      {int? lastId, int? toUserId}) async {
    try {
      final resp = await httpInstance.get(
        url: "privateChat/messageList",
        queryMap: {
          "lastId": lastId == 0 ? null : lastId,
          "pageSize": 20,
          "toUserId": toUserId,
        },
        complete: PrivateChatmessageListModel.fromJson,
        requestEntireModel: true,
      );
      if (resp != null) {
        return resp;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  ///获取用户消息/全部(不含系统)
  Future<List<MessageConterModel>?> getUserMessageList({
    required int informationType,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<MessageConterModel>(
        url: "information/user/notice",
        queryMap: {
          "page": page,
          "pageSize": pageSize,
          "informationType": 6,
        },
        complete: MessageConterModel.fromJson,
      );
      return resp;
    } catch (_) {
      return [];
    }
  }

  ///个人中心笔记
  Future<List<CommunityModel>?> getPersonCommunityList({
    required int page,
    required int pageSize,
    required String searchWord,
  }) async {
    try {
      final resp = await httpInstance.get<CommunityModel>(
        url: 'community/dynamic/person/list',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'searchWord': searchWord,
        },
        complete: CommunityModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///个人中心漫画
  Future<Map<String, dynamic>?> getPersonComicsList({
    required int page,
    required int pageSize,
    String searchWord = '',
  }) async {
    try {
      final resp = await httpInstance.get<ComicsBaseModel>(
        url: 'comics/like/list',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'searchWord': searchWord,
        },
        complete: null,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  ///个人中心资源
  Future<List<DownloadResourceModel>?> getPersonResourceList({
    required int page,
    required int pageSize,
    required String searchWord,
  }) async {
    try {
      final resp = await httpInstance.get<DownloadResourceModel>(
        url: 'community/dynamic/personResourcesList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'searchWord': searchWord,
        },
        complete: DownloadResourceModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }
}
