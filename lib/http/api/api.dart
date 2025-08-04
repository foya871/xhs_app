import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/pay/model/pay_link_model.dart';
import 'package:xhs_app/components/pay/model/recharge_request_model.dart';
import 'package:xhs_app/components/pay/model/vip_gold_type_model.dart';
import 'package:xhs_app/http/service/api_error_code_wrap.dart';
import 'package:xhs_app/model/activity/activity_new_model.dart';
import 'package:xhs_app/model/adult_game_model/adult_game_model.dart';
import 'package:xhs_app/model/blogger/blogger_fans_ticket_model.dart';
import 'package:xhs_app/model/blogger_base_model.dart';
import 'package:xhs_app/model/attention/attenion_models.dart';
import 'package:xhs_app/model/blogger/blogger_fans_group.dart';
import 'package:xhs_app/model/blogger/blogger_fans_model.dart';
import 'package:xhs_app/model/blogger/blogger_video_collection.dart';
import 'package:xhs_app/model/check_in/check_in_model.dart';
import 'package:xhs_app/model/check_in/check_in_tasks_model.dart';
import 'package:xhs_app/model/check_in/redemption_record_model.dart';
import 'package:xhs_app/model/choice/choice_models.dart';
import 'package:xhs_app/model/comics/comic_detail_model.dart';
import 'package:xhs_app/model/comics/comics_base.dart';
import 'package:xhs_app/model/community/blogger_model.dart';
import 'package:xhs_app/model/community/collection_base_model.dart';
import 'package:xhs_app/model/community/community_attention_resp.dart';
import 'package:xhs_app/model/community/community_base_model.dart';
import 'package:xhs_app/model/community/community_classify_model.dart';
import 'package:xhs_app/model/community/community_date_model.dart';
import 'package:xhs_app/model/community/community_not_concerned_model.dart';
import 'package:xhs_app/model/community/community_push_message_model.dart';
import 'package:xhs_app/model/community/community_release_model.dart';
import 'package:xhs_app/model/community/community_video_model.dart';
import 'package:xhs_app/model/community/original_publish_model.dart';
import 'package:xhs_app/model/community/original_purchase_model.dart';
import 'package:xhs_app/model/community/video_label_model.dart';
import 'package:xhs_app/model/download_resource_model.dart';

import 'package:xhs_app/model/message/message_model.dart';
import 'package:xhs_app/model/message/private_chatmessage_list_model.dart';
import 'package:xhs_app/model/message/private_message_detail_model.dart';
import 'package:xhs_app/model/message/private_message_model.dart';
import 'package:xhs_app/model/message/service_message_model.dart';
import 'package:xhs_app/model/mine/fans_club_model.dart';
import 'package:xhs_app/model/mine/group_classification_model.dart';
import 'package:xhs_app/model/mine/message_conter_model.dart';
import 'package:xhs_app/model/mine/system_notice_model.dart';
import 'package:xhs_app/model/user/recommend_user_model.dart';
import 'package:xhs_app/model/user/user_info_model.dart';
import 'package:xhs_app/model/video/comics_other_tag_list_item.dart';
import 'package:xhs_app/model/video/connotation_classify_list_tag.dart';
import 'package:xhs_app/model/video/intension_map_base_model.dart';
import 'package:xhs_app/model/video/intension_map_detail_comment.dart';
import 'package:xhs_app/model/video/intension_map_detail_model.dart';
import 'package:xhs_app/model/video/other_class_list_other_tag_list_item.dart';
import 'package:xhs_app/model/video/popular_skits_base_model.dart';
import 'package:xhs_app/model/video/portray_get_picture_list_item.dart';
import 'package:xhs_app/model/video/short_video_get_short_video_classify_item.dart';
import 'package:xhs_app/model/video/short_videos_resp.dart';
import 'package:xhs_app/model/video/tag_list_other_tag_list_item.dart';
import 'package:xhs_app/services/storage_service.dart';

import 'package:xhs_app/utils/logger.dart';

import '../../components/easy_toast.dart';
import '../../model/ai/ai_models.dart';
import '../../model/classify/classify_models.dart';
import '../../model/comics/comics_chapter.dart';
import '../../model/community/community_model.dart';
import '../../model/community/community_resource_model.dart';
import '../../model/community/community_topic_model.dart';
import '../../model/connotation/connotation_model.dart';
import '../../model/content_model.dart';
import '../../model/fiction/fiction_chapter_info_model.dart';
import '../../model/fiction/fiction_info_model.dart';
import '../../model/merchat/merchat_picture.dart';
import '../../model/message/chat_message_xhs_model.dart';
import '../../model/mine/buy_dynamic.dart';
import '../../model/mine/chat_list_message_model.dart';
import '../../model/mine/group_chatroom_model.dart';
import '../../model/mine/group_members_model.dart';
import '../../model/mine/message_notice_content_model.dart';
import '../../model/mine/profit_dynamic_item_model.dart';
import '../../model/mine/profit_model.dart';
import '../../model/mine/profit_total_model.dart';
import '../../model/mine/publications_posts_model.dart';
import '../../model/mine/record_model.dart';
import '../../model/mine/resource_model.dart';
import '../../model/mine/service_model.dart';
import '../../model/mine/share_link_model.dart';
import '../../model/mine/share_record_model.dart';
import '../../model/mine/spread_user_model.dart';
import '../../model/fiction/fiction_base_model.dart';
import '../../model/picture_cell_model/picture_cell_model.dart';
import '../../model/play/cdn_model.dart';
import '../../model/play/video_detail_model.dart';
import '../../model/portrait/portrait_model.dart';
import '../../model/product/product_classify_model.dart';
import '../../model/product/product_model.dart';
import '../../model/search/dynamic_hot_word_model.dart';
import '../../model/search/hot_word_model.dart';
import '../../model/search/search_video_model.dart';
import '../../model/station_model.dart';
import '../../model/tag/tags_model.dart';
import '../../model/video/adult_game_classify_model.dart';
import '../../model/video/adult_game_resp.dart';
import '../../model/video/community_resource_classify_model.dart';
import '../../model/video/product_detail_model.dart';
import '../../model/video/resouce_info_model.dart';
import '../../model/video/resource_download_model.dart';
import '../../model/video/resource_report.dart';
import '../../model/video/video_classify_model.dart';
import '../../model/video_actress_model.dart';
import '../../model/video_base_model.dart';
import '../../utils/consts.dart';
import '../../utils/enum.dart';
import '../service/api_code.dart';
import '../service/base_repsponse_model.dart';
import '../service/api_service.dart';

part 'api_activity.dart';

part 'api_ai.dart';

part 'api_choice.dart';

part 'api_classify.dart';

part 'api_collection.dart';

part 'api_community.dart';

part 'api_content.dart';

part 'api_info_promotion.dart';

part 'api_message.dart';

part 'api_mine.dart';

part 'api_short_player.dart';

part 'api_sys.dart';

part 'api_user.dart';

part 'api_video.dart';

part 'api_blogger.dart';

part 'api_original.dart';

part 'api_product.dart';

part 'api_check_in.dart';

part 'api_game.dart';

part 'api_portrait.dart';

part 'api_search.dart';

part 'api_fiction.dart';

part 'api_comics.dart';
part 'api_fans.dart';

class _Api {}

// ignore: non_constant_identifier_names
final Api = _Api();
