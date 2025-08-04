import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_viewer/image_viewer_bindings.dart';
import 'package:xhs_app/components/image_viewer/image_viewer_page.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/views/adult_game/detail/binding.dart';
import 'package:xhs_app/views/adult_game/detail/view.dart';
import 'package:xhs_app/views/adult_game/list_by_collection/binding.dart';
import 'package:xhs_app/views/adult_game/list_by_collection/view.dart';
import 'package:xhs_app/views/adult_game/sarch_result/binding.dart';
import 'package:xhs_app/views/adult_game/sarch_result/view.dart';
import 'package:xhs_app/views/adult_game/search_hot/view.dart';
import 'package:xhs_app/views/blogger/blogger_page.dart';
import 'package:xhs_app/views/blogger/blogger_page_controller.dart';
import 'package:xhs_app/views/blogger/collection/collection_page.dart';
import 'package:xhs_app/views/blogger/collection/collection_page_controller.dart';
import 'package:xhs_app/views/blogger/group_chat/group_chat_page.dart';
import 'package:xhs_app/views/blogger/group_chat/group_chat_page_controller.dart';
import 'package:xhs_app/views/blogger/private_group/private_group_page.dart';
import 'package:xhs_app/views/blogger/private_group/private_group_page_controller.dart';
import 'package:xhs_app/views/blogger/report/report_page.dart';
import 'package:xhs_app/views/blogger/report/report_page_controller.dart';
import 'package:xhs_app/views/blogger/tab_child/collection_view.dart';
import 'package:xhs_app/views/blogger/tab_child/note_view.dart';
import 'package:xhs_app/views/blogger/tab_child/private_group_view.dart';
import 'package:xhs_app/views/blogger/tab_child/resource_view.dart';
import 'package:xhs_app/views/comic/comic_detail_page.dart';
import 'package:xhs_app/views/community/bindings/community_complaint_page_bindings.dart';
import 'package:xhs_app/views/community/bindings/community_detail_page_bindings.dart';
import 'package:xhs_app/views/community/bindings/community_topic_page_bindings.dart';
import 'package:xhs_app/views/community/bindings/recommend_attention_page_bindings.dart';
import 'package:xhs_app/views/community/views/community_detail_page.dart';
import 'package:xhs_app/views/community/views/community_topic_page.dart';
import 'package:xhs_app/views/community/views/communtiy_complaint_page.dart';
import 'package:xhs_app/launch_page.dart';
import 'package:xhs_app/views/community/views/recommend_attention_page.dart';
import 'package:xhs_app/views/main/bindings/main_bindings.dart';
import 'package:xhs_app/views/main/views/main_page.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map_detail/intension_map_detail_page.dart';
import 'package:xhs_app/views/media_viewer/media_viewer_page.dart';
import 'package:xhs_app/views/message/notice/message_notice_page.dart';
import 'package:xhs_app/views/message/notice/message_notice_page_controller.dart';
import 'package:xhs_app/views/message/service/message_service_page.dart';
import 'package:xhs_app/views/message/service/message_service_page_controller.dart';
import 'package:xhs_app/views/mine/edit_userinfo/edituserintroduction_page.dart';
import 'package:xhs_app/views/mine/fans_followers/controllers/fans_followers_page_controller.dart';
import 'package:xhs_app/views/mine/fans_followers/views/fans_followers_page.dart';
import 'package:xhs_app/views/mine/favorite/controllers/mine_favorite_brushvideo_controller.dart';
import 'package:xhs_app/views/mine/favorite/controllers/mine_favorite_collection_controller.dart';
import 'package:xhs_app/views/mine/favorite/controllers/mine_favorite_community_controller.dart';
import 'package:xhs_app/views/mine/favorite/controllers/mine_favorite_video_controller.dart';
import 'package:xhs_app/views/mine/favorite/views/favorite_page_tab.dart';
import 'package:xhs_app/views/mine/frontpage/account_credentials_page.dart';
import 'package:xhs_app/views/mine/frontpage/bindings/edituserinfo/edituserinfo_page_bindings.dart';
import 'package:xhs_app/views/mine/frontpage/bindings/loginregister/login_register_page_bindings.dart';
import 'package:xhs_app/views/mine/frontpage/exchange_vip_page.dart';
import 'package:xhs_app/views/mine/frontpage/login_page.dart';
import 'package:xhs_app/views/mine/frontpage/mine_retrieve_account.dart';
import 'package:xhs_app/views/mine/frontpage/qr_code_scanner.dart';
import 'package:xhs_app/views/mine/frontpage/register_page.dart';
import 'package:xhs_app/views/mine/group_chat/create_groupchat_page.dart';
import 'package:xhs_app/views/mine/group_chat/create_groupchat_page_controller.dart';
import 'package:xhs_app/views/mine/group_chat/group_chat_message_page.dart';
import 'package:xhs_app/views/mine/group_chat/group_chatroom_page_controller.dart';
import 'package:xhs_app/views/mine/group_chat/groupchat_plaza_tab_controller.dart';
import 'package:xhs_app/views/mine/group_chat/groupchat_plaza_tab_page.dart';
import 'package:xhs_app/views/mine/group_chat/private_chat_message_page_controller.dart';
import 'package:xhs_app/views/mine/invitecode/invite_code_page.dart';
import 'package:xhs_app/views/mine/invitecode/invite_code_page_controller.dart';
import 'package:xhs_app/views/mine/message_information/message_comment_page.dart';
import 'package:xhs_app/views/mine/message_information/message_comment_page_controller.dart';
import 'package:xhs_app/views/mine/message_information/message_follow_page.dart';
import 'package:xhs_app/views/mine/message_information/message_follow_page_controller.dart';
import 'package:xhs_app/views/mine/message_information/message_information_page.dart';
import 'package:xhs_app/views/mine/message_information/message_information_page_controller.dart';
import 'package:xhs_app/views/mine/message_information/message_likesCollection_page_controller.dart';
import 'package:xhs_app/views/mine/message_information/message_likescollection_page.dart';
import 'package:xhs_app/views/mine/mine_blogger/mine_blogger_authentication_page.dart';
import 'package:xhs_app/views/mine/mine_buy/buy_page_tab.dart';
import 'package:xhs_app/views/mine/mine_buy/mine_buy_comunity_controller.dart';
import 'package:xhs_app/views/mine/mine_buy/mine_buy_video_controller.dart';
import 'package:xhs_app/views/mine/mine_fans_club/mine_fans_club_rule_page.dart';
import 'package:xhs_app/views/mine/mine_group/mine_group_page.dart';
import 'package:xhs_app/views/mine/mine_group/mine_group_page_controller.dart';
import 'package:xhs_app/views/mine/mine_profit/income_details/buy_details_dynamic.dart';
import 'package:xhs_app/views/mine/mine_profit/income_details/buy_details_video.dart';
import 'package:xhs_app/views/mine/mine_profit/income_details/buy_details_video_controller.dart';
import 'package:xhs_app/views/mine/mine_profit/mine_profit_page.dart';
import 'package:xhs_app/views/mine/mine_record/bindings/mine_record_page_binding.dart';
import 'package:xhs_app/views/mine/mine_record/record_page_tab.dart';
import 'package:xhs_app/views/mine/mine_releases/community_collection_page.dart';
import 'package:xhs_app/views/mine/mine_releases/mine_create_collection_page.dart';
import 'package:xhs_app/views/mine/mine_releases/mine_release_community_controller.dart';
import 'package:xhs_app/views/mine/mine_releases/mine_releases_index_tab.dart';
import 'package:xhs_app/views/mine/mine_setting_page.dart';
import 'package:xhs_app/views/mine/my_publications/view/posts_local_drafts_page.dart';
import 'package:xhs_app/views/mine/new_follower/controllers/new_followers_page_controller.dart';
import 'package:xhs_app/views/mine/new_follower/views/new_followers_page.dart';
import 'package:xhs_app/views/mine/record/recharge_record_page.dart';
import 'package:xhs_app/views/mine/record/recharge_record_page_controller.dart';
import 'package:xhs_app/views/mine/share/agent/agent_page_controller.dart';
import 'package:xhs_app/views/mine/share/share_page.dart';
import 'package:xhs_app/views/mine/share/share_page_controller.dart';
import 'package:xhs_app/views/mine/vip/vip_page.dart';
import 'package:xhs_app/views/mine/vip/vip_page_controller.dart';
import 'package:xhs_app/views/mine/withdrawal/withdrawal_page.dart';
import 'package:xhs_app/views/no_signal/no_net_work_page.dart';
import 'package:xhs_app/views/no_signal/no_signal.dart';
import 'package:xhs_app/views/player/common_player_page.dart';
import 'package:xhs_app/views/player/video_play_page.dart';
import 'package:xhs_app/views/portray_play/binding.dart';
import 'package:xhs_app/views/portray_play/view.dart';

import 'package:xhs_app/views/search/search_logic.dart';
import 'package:xhs_app/views/search/search_page.dart';
import 'package:xhs_app/views/shi_pin/bindings/blogger_collection/blogger_collection_detail_page_bindings.dart';
import 'package:xhs_app/views/shi_pin/bindings/choice/choice_detail_page_binds.dart';
import 'package:xhs_app/views/shi_pin/bindings/content/content_wh_bindings.dart';
import 'package:xhs_app/views/shi_pin/bindings/station/station_detail_with_ranking_page_bindings.dart';
import 'package:xhs_app/views/shi_pin/bindings/station/station_detail_with_sorting_page_bindings.dart';
import 'package:xhs_app/views/shi_pin/views/blogger_collection/blogger_collection_detail_page.dart';
import 'package:xhs_app/views/shi_pin/views/choice/choice_detail_page.dart';
import 'package:xhs_app/views/shi_pin/views/content/content_wh_page.dart';
import 'package:xhs_app/views/shi_pin/views/station/station_detail_with_ranking_page.dart';
import 'package:xhs_app/views/shi_pin/views/station/station_detail_with_sorting_page.dart';
import 'package:xhs_app/views/sign_in/check_in_page.dart';
import 'package:xhs_app/views/sign_in/check_in_page_controller.dart';
import 'package:xhs_app/views/sign_in/redemption_record_page.dart';

import '../views/comic/comics_chapter/comics_chapter_binding.dart';
import '../views/comic/comics_chapter/comics_chapter_page.dart';
import '../views/douyin/short_video_player/common/short_v_p_cell_controller.dart';
import '../views/douyin/short_video_player/controllers/short_video_player_page_controller.dart';
import '../views/douyin/short_video_player/views/short_video_player_page.dart';
import '../launch_classify_controller.dart';
import '../launch_classify_page.dart';
import '../views/main/views/recreation/novel_detail/novel_detail_page.dart';
import '../views/media_viewer/media_viewer_controller.dart';
import '../views/mine/edit_userinfo/edituser_name_page.dart';
import '../views/mine/edit_userinfo/edituserinfo_page.dart';
import '../views/mine/frontpage/bindings/setpage/mineset_page_bindings.dart';
import '../views/mine/group_chat/group_chat_message_page_controller.dart';
import '../views/mine/group_chat/private_chat_message_page.dart';
import '../views/mine/mine_buy/mine_buy_game_controller.dart';
import '../views/mine/mine_buy/mine_buy_product_controller.dart';
import '../views/mine/mine_download/mine_download_page.dart';
import '../views/mine/mine_download/mine_download_page_controller.dart';
import '../views/mine/mine_fans_club/mine_create_fans_club_page.dart';
import '../views/mine/mine_fans_club/mine_fans_club_page.dart';
import '../views/mine/mine_fans_club/mine_fans_club_page_controller.dart';
import '../views/mine/mine_profit/income_details/buy_details_dynamic_controller.dart';
import '../views/mine/mine_profit/mine_profit_page_controller.dart';
import '../views/mine/mine_releases/community_resource_page.dart';
import '../views/mine/mine_releases/community_resource_page_controller.dart';
import '../views/mine/mine_releases/mine_release_collection_controller.dart';
import '../views/mine/share/share_record_page.dart';
import '../views/mine/share/share_record_page_controller.dart';
import '../views/mine/withdrawal/withdrawal_page_controller.dart';
import '../views/player/controllers/common_video_play_controller.dart';
import '../views/player/controllers/video_play_controller.dart';
import '../views/selection/naked_chat_detail/naked_chat_detail_page.dart';
import '../views/selection/naked_chat_detail/new_address/new_address_binding.dart';
import '../views/selection/naked_chat_detail/new_address/new_address_page.dart';
import '../views/selection/naked_chat_detail/new_contact/new_contact_binding.dart';
import '../views/selection/naked_chat_detail/new_contact/new_contact_page.dart';
import '../views/selection/product_detail/product_detail_page.dart';
import '../views/selection/resource_detail/resource_detail_page.dart';
import '../views/selection/resource_feedback/resource_feedback_binding.dart';
import '../views/selection/resource_feedback/resource_feedback_page.dart';
import '../views/selection/selection_search/selection_search_binding.dart';
import '../views/selection/selection_search/selection_search_page.dart';

class Pages {
  Pages._();

  static final pages = [
    GetPage(name: Routes.no_net_work, page: () => const NoNetWorkPage()),
    GetPage(name: Routes.noSignal, page: () => const NoSignalPage()),
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      binding: MainBindings(),
    ),
    GetPage(
      name: Routes.launch,
      page: () => const LaunchPage(),
    ),
    GetPage(
      name: Routes.launchChooseClassify,
      page: () => const LaunchClassifyPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LaunchClassifyController>(() => LaunchClassifyController());
      }),
    ),
    GetPage(
      name: Routes.videoplay,
      page: () => const VideoPlayPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<VideoPlayController>(() => VideoPlayController());
      }),
    ),
    GetPage(
      name: Routes.check_in,
      page: () => const CheckInPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CheckInPageController());
      }),
    ),
    GetPage(
      name: Routes.redemption_record,
      page: () => const RedemptionRecordPage(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SearchLogic());
      }),
    ),
    // GetPage(
    //   name: Routes.searchresult,
    //   page: () => const SearchResultPage(),
    //   binding: SearchResultBindings(),
    // ),
    // GetPage(
    //   name: Routes.searchuserresult,
    //   page: () => const SearchUserResultPage(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<SearchUserPageController>(() => SearchUserPageController());
    //   }),
    // ),
    GetPage(
      name: Routes.blogger,
      page: () => const BloggerPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => BloggerPageController());
      }),
    ),
    GetPage(
      name: Routes.bloggerReport,
      page: () => const ReportPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ReportPageController());
      }),
    ),
    GetPage(
      name: Routes.bloggerGroupChat,
      page: () => const GroupChatPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => GroupChatPageController());
      }),
    ),
    GetPage(
      name: Routes.bloggerCollection,
      page: () => const CollectionPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CollectionPageController());
      }),
    ),
    GetPage(
      name: Routes.bloggerPrivateGroup,
      page: () => const PrivateGroupPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PrivateGroupPageController());
      }),
    ),
    GetPage(
      name: Routes.vip,
      page: () => const VipPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => VipPageController());
      }),
    ),
    GetPage(
      name: Routes.download,
      page: () => const DownloadPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MineDownloadPageController());
      }),
    ),
    GetPage(
      name: Routes.mediaviewer,
      page: () => const MediaViewerPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MediaViewerController>(() => MediaViewerController());
      }),
    ),
    GetPage(
      name: Routes.commonplayer,
      page: () => const CommonPlayerPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CommonVideoPlayerController>(
            () => CommonVideoPlayerController());
      }),
    ),
    GetPage(
      name: Routes.minewithdrawal,
      page: () => const MineWithdrawalPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MineWithdrawalPageController());
      }),
    ),
    GetPage(
      name: Routes.communityCollection,
      page: () => const CommunityCollectionPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MineReleaseCollectionController());
      }),
    ),
    GetPage(
      name: Routes.communityResourceRelease,
      page: () => const CommunityResourcePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CommunityResourcePageController());
      }),
    ),
    GetPage(
      name: Routes.recommendAttention,
      page: () => const RecommendAttentionPage(),
      binding: RecommendAttentionPageBindings(),
    ),
    GetPage(
      name: Routes.mineprofit,
      page: () => const MineProfitPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MineProfitPageController(), tag: "笔记收益");
        Get.lazyPut(() => MineProfitPageController(), tag: "粉丝团收益");
        Get.lazyPut(() => MineProfitPageController(), tag: "下载资源收益");
      }),
    ),
    GetPage(
      name: Routes.minegroup,
      page: () => const MineGroupPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MineGroupPageController());
      }),
    ),
    GetPage(
      name: Routes.rechargeRecord,
      page: () => const RechargeRecordPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RechargeRecordPageController());
      }),
    ),
    GetPage(
      name: Routes.share,
      page: () => const SharePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SharePageController());
        Get.lazyPut(() => AgentPageController());
        // Get.lazyPut(() => ShareRecordPageController());
      }),
      // binding: SharePageBinding(),
    ),
    GetPage(
      name: Routes.shareRecord,
      page: () => const ShareRecordPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ShareRecordPageController());
      }),
      // binding: SharePageBinding(),
    ),
    GetPage(
      name: Routes.stationDetailSorting,
      page: () => const StationDetailWithSortingPage(),
      binding: StationDetailWithSortingPageBindings(),
    ),
    GetPage(
      name: Routes.stationDetailRanking,
      page: () => const StationDetailWithRankingPage(),
      binding: StationDetailWithRankingPageBindings(),
    ),
    GetPage(
      name: Routes.choiceDetail,
      page: () => const ChoiceDetailPage(),
      binding: ChoiceDetailPageBinds(),
    ),
    GetPage(
      name: Routes.bloggerCollectionDetail,
      page: () => const BloggerCollectionDetailPage(),
      binding: BloggerCollectionDetailPageBindings(),
    ),
    GetPage(
      name: Routes.my_publications_local_drafts,
      page: () => const PostsLocalDraftsPage(),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut<PostsPageController>(() => PostsPageController());
      // }),
    ),
    GetPage(
      name: Routes.favorite,
      page: () => FavoriteTabPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MineFavoriteVideoController>(
            () => MineFavoriteVideoController());
        Get.lazyPut<MineFavoriteBrushVideoController>(
            () => MineFavoriteBrushVideoController());
        Get.lazyPut<MineFavoriteCollectionController>(
            () => MineFavoriteCollectionController());
        Get.lazyPut<MineFavoriteCommunityController>(
            () => MineFavoriteCommunityController());
      }),
    ),
    GetPage(
      name: Routes.buy,
      page: () => MineBuyTabPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MineBuyCommunityController>(
            () => MineBuyCommunityController());
        Get.lazyPut<MineBuyProductController>(() => MineBuyProductController());
        Get.lazyPut<MineBuyVideoController>(() => MineBuyVideoController());
        Get.lazyPut<MineBuyGameController>(() => MineBuyGameController());
      }),
    ),
    GetPage(
      name: Routes.minerecord,
      page: () => MineRecordTabPage(),
      binding: MineRecordPageBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginRegisterPageBindings(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: LoginRegisterPageBindings(),
    ),
    GetPage(
      name: Routes.minebloggerauthentication,
      page: () => const MineBloggerAuthenticationPage(),
    ),
    GetPage(
      name: Routes.mine_fans_followers,
      page: () => const FansFollowersPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<FansFollowersPageController>(
            () => FansFollowersPageController());
      }),
    ),
    GetPage(
      name: Routes.mine_new_followers,
      page: () => const NewFollowersPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NewFollowersPageController>(
            () => NewFollowersPageController());
      }),
    ),
    GetPage(
      name: Routes.minefansclub,
      page: () => const MineFansClubPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MineFansClubPageController>(
            () => MineFansClubPageController());
      }),
    ),
    GetPage(
      name: Routes.minefansclubrule,
      page: () => const MineFansClubRulePage(),
    ),
    GetPage(
      name: Routes.minecreatefansclub,
      page: () => const MineCreateFansClubPage(),
    ),
    GetPage(
      name: Routes.accountcredentials,
      page: () => const AccountCredentialsPage(),
    ),
    GetPage(
      name: Routes.editusername,
      page: () => const EdituserNamePage(),
      binding: EditUserInfoPageBindings(),
    ),
    GetPage(
      name: Routes.edituserintroduction,
      page: () => const EditUserIntroductionPage(),
      binding: EditUserInfoPageBindings(),
    ),
    GetPage(
      name: Routes.edituserinfo,
      page: () => const EditUserInfoPage(),
      binding: EditUserInfoPageBindings(),
    ),
    GetPage(
      name: Routes.imageviewer,
      page: () => const ImageViewer(),
      binding: ImageViewerBindings(),
    ),
    GetPage(
      name: Routes.retrieveaccount,
      page: () => const MineRetrieveAccount(),
    ),
    GetPage(
      name: Routes.scannercode,
      page: () => ScanPage(),
    ),
    GetPage(
      name: Routes.portrayPlay,
      page: () => const PortrayPlayPage(),
      binding: PicturePlayBindings(),
    ),
    GetPage(
      name: Routes.minesincomedynmaic,
      page: () => const BuyDynamicDetails(),
      binding: BindingsBuilder(() {
        Get.lazyPut<BuyDetailsDynamicController>(
            () => BuyDetailsDynamicController());
      }),
    ),
    GetPage(
      name: Routes.minesincomevideo,
      page: () => const BuyVideoDetails(),
      binding: BindingsBuilder(() {
        Get.lazyPut<BuyDetailsVideoController>(
            () => BuyDetailsVideoController());
      }),
    ),
    GetPage(
      name: Routes.minesrelease,
      page: () => MineRealeasesIndexTab(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MineReleaseCollectionController>(
            () => MineReleaseCollectionController());
        Get.lazyPut<MineReleaseCommunityController>(
            () => MineReleaseCommunityController());
      }),
    ),
    GetPage(
      name: Routes.minescreatecollection,
      page: () => const MineCreateCollectionPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MineReleaseCollectionController>(
            () => MineReleaseCollectionController());
      }),
    ),
    GetPage(
      name: Routes.minesmessageinformation,
      page: () => const MessageInformationPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MessageInformationPageController>(
            () => MessageInformationPageController());
      }),
    ),
    GetPage(
      name: Routes.minesmessagelike,
      page: () => const MessageLikesCollectionPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MessageLikesCollectionPageController>(
            () => MessageLikesCollectionPageController());
      }),
    ),
    GetPage(
      name: Routes.minesmessagefollow,
      page: () => const MessageFollowPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MessageFollowPageController>(
            () => MessageFollowPageController());
      }),
    ),
    GetPage(
      name: Routes.minesmessagecomment,
      page: () => const MessageCommentPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MessageCommentPageController>(
            () => MessageCommentPageController());
      }),
    ),
    GetPage(
      name: Routes.minesmessagecreategroup,
      page: () => const CreateGroupChatPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CreateGroupChatPageController>(
            () => CreateGroupChatPageController());
      }),
    ),
    GetPage(
      name: Routes.minesmessagegroupchatplaza,
      page: () => const GroupChatPlazaTabPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<GroupChatPlazaTabPageController>(
            () => GroupChatPlazaTabPageController());
        Get.lazyPut<GroupChatRoomPageController>(
            () => GroupChatRoomPageController());
      }),
    ),
    GetPage(
      name: Routes.minesgroupchatmessage,
      page: () => const GroupChatMessagePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<GroupChatMessagePageController>(
            () => GroupChatMessagePageController());
      }),
    ),
    GetPage(
      name: Routes.minesprivatechatmessage,
      page: () => const PrivateChatMessagePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PrivateChatMessagePageController>(
            () => PrivateChatMessagePageController());
      }),
    ),
    GetPage(
      name: Routes.minesmessagesystemnotice,
      page: () => const MessageNoticePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MessageNoticePageController>(
            () => MessageNoticePageController());
      }),
    ),
    GetPage(
      name: Routes.comicDetail,
      page: () => ComicDetailPage(),
    ),
    GetPage(
      name: Routes.intensionMapDetailPage,
      page: () => IntensionMapDetailPage(),
    ),
    ...shortVideoRelated,
    ...message,
    ...content,
  ];

  /// ******************短视频相关
  static final shortVideoRelated = <GetPage>[
    GetPage(
      name: Routes.shortvideoplayer,
      page: () => const ShortVideoPlayerPage(mode: ShortVideoPlayerMode.local),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ShortVideoPlayerPageController(),
            tag: ShortVideoPlayerMode.local.index.toString());
        Get.create(() => ShortVPCellController(),
            tag: ShortVideoPlayerMode.local.index.toString());
      }),
    ),
  ];

  static final message = <GetPage>[
    GetPage(
      name: Routes.message_service,
      page: () => const MessageServicePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MessageServicePageController());
      }),
    ),
  ];

  static final content = <GetPage>[
    GetPage(
      name: Routes.contentWh,
      page: () => const ContentWhPage(),
      binding: ContentWhPageBindings(),
    ),

    // GetPage(
    //   name: Routes.topicClassifyPage,
    //   page: () => const TopicClassifyPage(),
    //   binding: TopicClassifyPageBindings(),
    // ),
    // GetPage(
    //   name: Routes.topicDetail,
    //   page: () => TopicDetailPage(),
    //   binding: TopicDetailPageBinding(),
    // ),
    GetPage(
      name: Routes.communityDetail,
      page: () => CommunityDetailPage(key: UniqueKey()),
      binding: CommunityDetailPageBindings(),
    ),
    // GetPage(
    //   name: Routes.communityDetailNew,
    //   page: () => const CommunityDetailNewPage(),
    //   binding: CommunityDetailNewPageBindings(),
    // ),
    // GetPage(
    //   name: Routes.radioDetail,
    //   page: () => const RadioDetailPage(),
    //   binding: RadioDetailPageBindings(),
    // ),
    GetPage(
      name: Routes.communityComplaint,
      page: () => const CommuntiyComplaintPage(),
      binding: CommunityComplaintPageBindings(),
    ),
    GetPage(
      name: Routes.communityTopic,
      page: () => const CommunityTopicPage(),
      binding: CommunityTopicPageBindings(),
    ),

    GetPage(
      name: Routes.adultGameListByCollection,
      page: () => const AdultGameListByCollectionPage(),
      binding: AdultGameListByCollectionControllsBindings(),
    ),
    GetPage(
      name: Routes.adultGameDetail,
      page: () => const AdultGameDetailPage(),
      binding: AdultGameDetailControllBinding(),
    ),
    GetPage(
      name: Routes.exchangevippage,
      page: () => const ExchangeVipPage(),
      binding: EditUserInfoPageBindings(),
    ),
    GetPage(
      name: Routes.adultGameSearchResult,
      page: () => const AdultGameSearchResultPage(),
      binding: AdultGameSearchResultControllsBindings(),
    ),
    GetPage(
      name: Routes.audltGameSearchHot,
      page: () => const AdultGameSearchHotPage(),
    ),
    GetPage(
      name: Routes.settingpage,
      page: () => const MineSettingPage(),
      binding: MineSetPageBindings(),
    ),

    GetPage(
      name: Routes.invitecodepage,
      page: () => const InviteCodePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<InviteCodePageController>(() => InviteCodePageController());
      }),
    ),
    GetPage(
      name: Routes.selectionSearch,
      page: () => const SelectionSearchPage(),
      binding: SelectionSearchBinding(),
    ),
    GetPage(
      name: Routes.productDetail,
      page: () => const ProductDetailPage(),
    ),
    GetPage(
      name: Routes.resourceDetail,
      page: () => const ResourceDetailPage(),
    ),
    GetPage(
      name: Routes.nakedChatDetail,
      page: () => const NakedChatDetailPage(),
    ),
    GetPage(
      name: Routes.novel_details,
      page: () => const NovelDetailPage(),
    ),
    GetPage(
      name: Routes.resourceFeedback,
      page: () => const ResourceFeedbackPage(),
      binding: ResourceFeedbackBinding(),
    ),
    GetPage(
      name: Routes.newAddress,
      page: () => const NewAddressPage(),
      binding: NewAddressBinding(),
    ),
    GetPage(
      name: Routes.newContact,
      page: () => const NewContactPage(),
      binding: NewContactBinding(),
    ),
    GetPage(
      name: Routes.comicChapter,
      page: () => const ComicsChapterPage(),
      binding: ComicsChapterBinding(),
    ),
  ];
}
