import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/routes/routes.dart';

import '../../../http/api/api.dart';
import '../../../model/mine/chat_list_message_model.dart';

class MessageInformationPageController extends BaseRefreshController with BaseRefreshPageCounter{
  RxList<ChatListMessageModel> chatList = <ChatListMessageModel>[].obs;
  bool isOverlayVisible = false;
  OverlayEntry? overlayEntry;

  Future deleteItem(int toUserId) async{
    try{
      await Api.deleteItem(toUserId);
    }catch(_){}
  }

  @override
  Future<IndicatorResult> onRefresh() async{
    resetPage();
    return await getChats(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getChats();
  }

  Future<IndicatorResult> getChats({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        chatList.clear();
      }
      final response = await Api.getChatList(page: page);
      if (response.isNotEmpty) {
        chatList.addAll(response);
        return IndicatorResult.success;
      } else {
        if (isRefresh) {
          chatList.addAll([]);
          return IndicatorResult.success;
        } else {
          chatList.addAll([]);
          return IndicatorResult.noMore;
        }
      }
    } catch (e) {
      return IndicatorResult.fail;
    }
  }

  onClick(String title){
    switch(title){
      case "赞和收藏":
        Get.toNamed(Routes.minesmessagelike);
        break;
      case "新增关注":
        Get.toNamed(Routes.minesmessagefollow);
        break;
      case "收到的评论":
        Get.toNamed(Routes.minesmessagecomment);
        break;
      case "创建群聊":
        Get.toNamed(Routes.minesmessagecreategroup);
        break;
      case "群聊广场":
        Get.toNamed(Routes.minesmessagegroupchatplaza);
        break;
      case "消息通知":
        Get.toNamed(Routes.minesmessagesystemnotice);
        break;
    }
  }

  jumpChat(int userId, String nickName, String logo) async{
    await Get.toPrivateChatMessage(
        logo: logo ?? "",
        name: nickName,
        userid: userId);
    onRefresh();
  }
}