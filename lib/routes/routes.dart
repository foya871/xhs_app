/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-24 10:51:11
 * @LastEditors: wangdazhuang
 * @LastEditTime: 2025-03-04 17:26:55
 * @FilePath: /xhs_app/lib/routes/routes.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:get/get.dart';
import 'package:xhs_app/model/choice/choice_models.dart';
import 'package:xhs_app/model/community/community_base_model.dart';
import 'package:xhs_app/model/station_model.dart';
import 'package:xhs_app/utils/enum.dart';

import '../model/video_base_model.dart';
import '../views/player/controllers/video_play_controller.dart';

abstract class Routes {
  Routes._();

  // ignore: constant_identifier_names
  static const no_net_work = '/no_net_work';
  static const noSignal = '/no_signal';
  static const main = '/home';

  static const stationDetailSorting = '/station/detail/sorting';
  static const stationDetailRanking = '/station/detail/ranking';
  static const contentWh = '/content/wh';
  static const choiceDetail = '/choice/detail';
  static const bloggerCollectionDetail = '/bloggerCollectionDetail';

  static const videoBox = '/videobox';

  static const launch = '/launch';
  static const launchChooseClassify = '/launch/chooseClassify';

  static const videoplay = '/videoplay';
  static const portrayPlay = '/portray/play';
  static const search = '/search';
  static const searchresult = '/searchresult';
  static const searchuserresult = '/searchuserresult';
  static const videotag = '/videotag';
  static const tagvideos = '/tagvideos';
  static const producer = '/producer';
  static const creatorlist = '/creatorlist';
  static const starlist = '/starlist';
  static const vip = '/vip';
  static const recharge = '/recharge';
  static const vipRecord = '/vipRecord';
  static const rechargeRecord = '/rechargeRecord';
  static const share = '/share'; //我的分享
  static const shareRecord = '/shareRecord';
  static const annews = '/annews';
  static const commonplayer = '/commonplayer';
  static const webview = '/webview';

  static const login = '/login';
  static const register = '/register';
  static const check_in = '/check_in';
  static const redemption_record = '/redemption_record';

  ///媒体查看器
  static const mediaviewer = '/mediaviewer';

  static const minebuy = '/mine/minebuy';
  static const download = '/download';
  static const addlitevideos = '/addlitevideos';
  static const choosetags = "/choosetags";
  static const addliteVideoRule = "/addliteVideoRule";

  ///mine
  static const accountcredentials = '/mine/accountcredentials';
  static const profitmain = "/profitmain";
  static const editusername = '/mine/editusername';
  static const edituserintroduction = '/mine/edituserintroduction';
  static const edituserinfo = '/mine/edituserinfo';
  static const imageviewer = '/imageviewer';
  static const rechargehint = '/rechargehint';
  static const retrieveaccount = '/mine/retrieveaccount';
  static const scannercode = '/mine/scannercode';
  static const exchangevippage = '/mine/exchangevippage';
  static const invitecodepage = '/mine/invitecodepage';
  static const settingpage = '/mine/settingpage';
  static const my_publications = '/mine/my_publications';
  static const my_publications_local_drafts =
      '/mine/my_publications/local_drafts';
  static const favorite = '/mine/favorite';
  static const buy = '/mine/buy';
  static const service = '/mine/service';

  static const mine_fans_followers = '/mine/fans_followers';
  static const mine_new_followers = '/mine/new_followers';
  static const minesincomedynmaic = '/mine/minesincomedynmaic';
  static const minesincomevideo = '/mine/minesincomevideo';
  static const minesrelease = '/mine/minesrelease';
  static const minescreatecollection = '/mine/minescreatecollection';

  static const minesmessageinformation = '/mine/minesmessageinformation';
  static const minesmessagelike = '/mine/minesmessagelike';
  static const minesmessagefollow = '/mine/minesmessagefollow';
  static const minesmessagecomment = '/mine/minesmessagecomment';
  static const minesmessagecreategroup = '/mine/minesmessagecreategroup';
  static const minesmessagegroupchatplaza = '/mine/minesmessagegroupchatplaza';
  static const minebloggerauthentication = '/mine/minebloggerauthentication';
  static const minegroup = '/mine/group';

  static const minesgroupchatmessage = '/mine/minesgroupchatmessage';
  static const minesprivatechatmessage = '/mine/minesprivatechatmessage';
  static const minesmessagesystemnotice = '/mine/minesmessagesystemnotice';

  ///浏览记录
  static const minerecord = "/mine/minerecord";

  ///粉丝团
  static const minefansclub = "/mine/minefansclub";
  static const minefansclubrule = "/mine/minefansclubrule";
  static const minecreatefansclub = "/mine/minecreatefansclub";

  ///提现
  static const minewithdrawal = "/mine/minewithdrawal";
  static const mineprofit = "/mine/mineprofit";

  ///community
  static const communityDetail = '/community/communityDetail';
  static const communityComplaint = '/community/complaint'; // 投诉
  static const communityTopic = '/community/topic';
  static const communityCollection = '/community/collection';
  static const communityResourceRelease = '/community/resourcerelease';
  static const recommendAttention = '/recommendAttention'; // 推荐关注

  ///博主
  static const blogger = '/blogger/blogger';
  static const bloggerReport = '/blogger/report';
  static const bloggerGroupChat = '/blogger/groupchat';
  static const bloggerCollection = '/blogger/collection';
  static const bloggerPrivateGroup = '/blogger/privategroup';

  ///原味
  static const original = '/community/original';
  static const originalMyOrders = '/community/original/myOrders';
  static const originalpublish = '/community/original/publish';

  ///engagement
  static const engagementDetail = '/engagement/engagementDetail';
  static const engagementStationMorePage =
      '/engagement/engagementStationMorePage';
  static const engagement_search = '/engagement/search';
  static const engagement_search_result = '/engagement/search/result';

  static const shortvideoplayer = '/shortvideoplayer';

  static const welfare = '/welfare';

  static const adultGameListByCollection = '/adult/game/list/by/collection';

  static const adultGameDetail = '/adult/game/detail';

  static const adultGameSearchResult = '/adult/game/search/result';

  static const audltGameSearchHot = '/audlt/game/search/hot';

  //comics
  static const bookshelf = '/bookshelf';

  ///message
  static const message_service = '/message_service';
  static const message_chat = '/message_chat';
  static const message_search = '/message_search';

  ///novel(小说)
  static const novel = '/novel';
  static const novel_search = '/novel/search';
  static const novel_search_result = '/novel/search/result';
  static const novel_tag = '/novel/tag';
  static const novel_details = '/novel/details';

  //漫画详情
  static const comicDetail = '/comic/detail';

  //漫画章节
  static const comicChapter = '/comic/chapter';

  static const intensionMapDetailPage = '/intensionMapDetailPage';

  ///活动
  static const activity = '/activity';
  static const activityMy = '/activity/my';
  static const activityDetail = '/activity/details';
  static const activityPlayer = '/activity/player';

  /// product
  static const productDetail = '/product/detail';

  /// resource
  static const resourceDetail = '/resource/detail';

  ///naked chat
  static const nakedChatDetail = '/naked/chat/detail';

  ///资源反馈
  static const resourceFeedback = "/resource/feedback";

  ///添加地址
  static const newAddress = "/new/address";

  ///添加联系方式
  static const newContact = "/new/contact";

  ///精选
  static const selectionSearch = '/selection/search';
}

// 带参页面，统一写到这里
extension ToNamedWithParamsGet on GetInterface {
  offHome([int? index]) => offNamed(Routes.main, arguments: index);

  ///视频播放
  toPlayVideo({required int videoId}) {
    if (Get.isRegistered<VideoPlayController>()) {
      final vc = Get.find<VideoPlayController>();
      vc.fetchVideoDetailById(videoId);
      until(
          (route) => (route.settings.name ?? '').startsWith(Routes.videoplay));
      return;
    }
    toNamed(
      Routes.videoplay,
      parameters: {
        'id': videoId.toString(),
      },
    );
  }

  toPortrayPlay({required int portrayPicId}) => toNamed(
        Routes.portrayPlay,
        parameters: {
          'portrayPicId': portrayPicId.toString(),
        },
      );

  toComonVideoPlay({required String url, double? asp}) =>
      toNamed(Routes.commonplayer,
          arguments: url,
          parameters: asp != null ? {'asp': asp.toString()} : null);

  toStationDetail(StationModel station) {
    if (station.detailStyle == StationDetailStyle.rank) {
      toNamed(
        Routes.stationDetailRanking,
        arguments: {'station': station},
      );
    } else {
      toNamed(
        Routes.stationDetailSorting,
        arguments: {'station': station},
      );
    }
  }

  toChoiceDetail(VideoChoiceModel choice) =>
      toNamed(Routes.choiceDetail, arguments: {'choice': choice});

  toBloggerCollectionDetail(int collectionId) =>
      toNamed(Routes.bloggerCollectionDetail,
          arguments: {'collectionId': collectionId});

  ///图片查看器
  toImageViewer(List<String> images, {int? currentIndex}) => toNamed(
        Routes.imageviewer,
        arguments: images,
        parameters: currentIndex != null
            ? {
                "index": currentIndex.toString(),
              }
            : {},
      );

  toShortVideoPlay(List<VideoBaseModel> items, {required int idx}) => toNamed(
        Routes.shortvideoplayer,
        arguments: items,
        parameters: {"idx": '$idx'},
      );

  ///媒体查看器（视频+ 图片混合的）
  toMediaViewer({
    required List<String> images,
    String? playPath,
    String? extraInfo,
  }) =>
      toNamed(Routes.mediaviewer, arguments: {
        "images": images,
        "video": playPath
      }, parameters: {
        'extra': extraInfo ?? '',
      });

  ///产品详情
  toProductDetail({required int id}) => toNamed(
        Routes.productDetail,
        arguments: id,
        preventDuplicates: false,
      );

  ///资源详情
  toResourceDetail({required int id}) => toNamed(
        Routes.resourceDetail,
        arguments: id,
        preventDuplicates: false,
      );

  ///裸聊详情
  toNakedChatDetail({required int id}) => toNamed(
        Routes.nakedChatDetail,
        arguments: id,
        preventDuplicates: false,
      );

  ///漫画详情
  toComicsDetail({required int comicsId}) => toNamed(
        Routes.comicDetail,
        parameters: {"comicId": "${comicsId}"},
        preventDuplicates: false,
      );

  ///小说详情
  Future<T?>? toNovelDetail<T>({required int id}) => toNamed(
        Routes.novel_details,
        arguments: id,
        preventDuplicates: false,
      );

  ///博主详情
  toBloggerDetail({required int userId}) => toNamed(
        Routes.blogger,
        arguments: {
          'userId': userId,
        },
      );

  ///帖子详情
  toCommunityDetail(CommunityBaseModel base) =>
      toCommunityDetailById(base.dynamicId, dynamicType: base.dynamicType);

  // 有type会更快打开页面
  toCommunityDetailById(int dynamicId, {CommunityType? dynamicType}) => toNamed(
        Routes.communityDetail,
        arguments: {'dynamicId': dynamicId, 'dynamicType': dynamicType},
      );

  toCommunityTopic(String topic) =>
      toNamed(Routes.communityTopic, arguments: {'topic': topic});

  toEngagementDetail({required int meetUserId}) => toNamed(
        Routes.engagementDetail,
        parameters: {
          'meetUserId': '$meetUserId',
        },
      );

  toEngagementStationMore(
          {required int stationId, required String stationName}) =>
      toNamed(
        Routes.engagementStationMorePage,
        parameters: {
          'stationId': '$stationId',
          'stationName': stationName,
        },
      );

  ///游戏详情
  toGameDetail(int id) => toNamed(
        Routes.adultGameDetail,
        parameters: {
          "id": id.toString(),
        },
      );

  toAdultGameSearchResultByWord(String word) => toNamed(
        Routes.adultGameSearchResult,
        parameters: {
          "word": word,
        },
      );

  toAdultGameSearchResultByWordReplace(String word) => offNamed(
        Routes.adultGameSearchResult,
        parameters: {
          "word": word,
        },
      );

  ///前往聊天
  ///[userId] 聊天对象
  ///[userNickName] 聊天对象昵称
  ///[msgId] 消息id  用于搜索跳转
  toChat(
          {required int userId,
          required String userNickName,
          int messageId = -1}) =>
      toNamed(Routes.message_chat, arguments: {
        'userId': userId,
        'userNickName': userNickName,
        'messageId': messageId,
      });

  ///分享
  toShare({int tabIndex = 0}) =>
      toNamed(Routes.share, arguments: {'tabIndex': tabIndex});

  ///充值记录
  ///[type] 2:vip  3:金币
  toRechargeRecord({required int type}) =>
      toNamed(Routes.rechargeRecord, arguments: {'type': type});

  toActivityDetail(int activityId) =>
      toNamed(Routes.activityDetail, arguments: {'activityId': activityId});

  toIncomeDynamicDetail({int dynamicId = 0}) =>
      toNamed(Routes.minesincomedynmaic, arguments: {'dynamicId': dynamicId});

  toIncomeVideoDetail({int videoId = 0, int videoMark = 0}) =>
      toNamed(Routes.minesincomevideo, arguments: {
        'videoId': videoId,
        'videoMark': videoMark,
      });

  ///去会员界面
  ///[tabInitIndex]0 会员  1 金币充值
  toVip({int tabInitIndex = 0}) =>
      toNamed(Routes.vip, arguments: {'tabInitIndex': tabInitIndex});

  toCommunityComplaint(CommunityBaseModel model) => toNamed(
        Routes.communityComplaint,
        arguments: model,
      );

  toGroupChatMessage(
          {required String logo,
          required String name,
          required int userid,
          required int roomid}) =>
      toNamed(Routes.minesgroupchatmessage, arguments: {
        'logo': logo,
        'name': name,
        'userid': userid,
        'roomId': roomid,
      });

  toPrivateChatMessage(
          {required String logo, required String name, required int userid}) =>
      toNamed(Routes.minesprivatechatmessage, arguments: {
        'logo': logo,
        'name': name,
        'userid': userid,
      });

  ///去博主举报
  toBloggerReport({required int userId}) => toNamed(
        Routes.bloggerReport,
        arguments: {
          'userId': userId,
        },
      );

  ///去博主的群聊
  toBloggerGroupChat({required int userId, required String nickName}) =>
      toNamed(
        Routes.bloggerGroupChat,
        arguments: {
          'userId': userId,
          'nickName': nickName,
        },
      );

  ///去博主的合集
  toBloggerCollection({required int userId}) => toNamed(
        Routes.bloggerCollection,
        arguments: {
          'userId': userId,
        },
      );

  ///去博主的私人团
  toBloggerPrivateGroup({required int userId}) => toNamed(
        Routes.bloggerPrivateGroup,
        arguments: {
          'userId': userId,
        },
      );
}
