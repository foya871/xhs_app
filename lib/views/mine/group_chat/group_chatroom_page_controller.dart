import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/model/mine/group_chatroom_model.dart';
import 'package:xhs_app/routes/routes.dart';

import '../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../http/api/api.dart';
import '../../../services/user_service.dart';
import 'group_chat_detail_Page.dart';

class GroupChatRoomPageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, GroupChatroomModel> pagingController =
      PagingController(firstPageKey: 1);
  String classifyName = "";
  final userService = Get.find<UserService>();

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getGroupCharRoom(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getGroupCharRoom();
  }

  //获取群聊天室列表
  Future<IndicatorResult> getGroupCharRoom({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingController.refresh();
      }
      final response =
          await Api.getGroupChatRooms(classifyName: classifyName, page: page);
      if (response.isNotEmpty) {
        pagingController.appendPage(response, page);
        return IndicatorResult.success;
      } else {
        if (isRefresh) {
          pagingController.appendLastPage([]);
          return IndicatorResult.success;
        } else {
          pagingController.appendLastPage([]);
          return IndicatorResult.noMore;
        }
      }
    } catch (e) {
      return IndicatorResult.fail;
    }
  }

  openDialog(GroupChatroomModel model) {
    Get.bottomSheet(
        GroupChatDetailPage(model: model, userId: userService.user.userId!, controller: this,));
  }

  jumpRoom(GroupChatroomModel model) async {
    if (model.join == false) {
      SmartDialog.showLoading(msg: "加入中...");
      final resp = await Api.joinGroupChatRoom(model.roomId!);
      SmartDialog.dismiss();
      if (resp) {
        model.join = true;
        bool result = await Get.toGroupChatMessage(
            logo: model.roomLogo ?? "",
            name: '${model.roomName}(${model.roomTotalNum})',
            userid: model.userId!,
            roomid: model.roomId!);
        if(result) onRefresh();
      }
      return;
    }
    bool result = await Get.toGroupChatMessage(
        logo: model.roomLogo ?? "",
        name: '${model.roomName}(${model.roomTotalNum})',
        userid: model.userId!,
        roomid: model.roomId!);
    if(result) onRefresh();
  }

  jumpCreateRoom() {
    Get.toNamed(Routes.minesmessagecreategroup);
  }
}
