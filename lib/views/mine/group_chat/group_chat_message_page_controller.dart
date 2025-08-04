import 'dart:typed_data';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/model/message/chat_message_xhs_model.dart';
import 'package:xhs_app/model/mine/send_chatmessage_model.dart';
import 'package:xhs_app/utils/utils.dart';
import '../../../components/common_permission_alert.dart';
import '../../../components/image_picker/easy_image_picker.dart';
import '../../../http/api/api.dart';
import '../../../http/service/api_service.dart';
import '../../../model/image_upload_resp_model.dart';
import '../../../services/user_service.dart';
import '../../../utils/loading_dialog.dart';

class GroupChatMessagePageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final userService = Get.find<UserService>();
  int lastId = 0;
  int roomId = 0;
  List<ChatMessageXhsModel> messageList = List<ChatMessageXhsModel>.of([]);

  final roomLogo = "".obs;
  final roomName = "".obs;
  int roomUserId = 0;
  final isMineRoom = false.obs;

  TextEditingController sendTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ValueNotifier<bool> showInputText = ValueNotifier(false);
  ValueNotifier<String> defaultText = ValueNotifier('聊骚快人一步，请勇于发言');
  var params = SendChatmessageModel();
  Uint8List? _imgFile;

  @override
  void onInit() {
    initData();
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showInputText.value = true;
      } else {
        showInputText.value = false;
      }
    });
  }

  void initData() {
    roomLogo.value = Get.arguments['logo'] ?? "";
    roomName.value = Get.arguments['name'] ?? "";
    roomUserId = Get.arguments['userid'] ?? 0;
    roomId = Get.arguments['roomId'] ?? 0;
    if (roomUserId == userService.user.userId) isMineRoom.value = true;
  }

  @override
  void onClose() {
    refreshController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  showTipsDialog() {
    permission_alert(Get.context!,
        desc: "确定要${isMineRoom.value == true ? '解散' : '退出'}该群聊？",
        oktitle: "确认",
        info: "", okAction: () {
      exitRoom();
    });
  }

  exitRoom() async {
    SmartDialog.showLoading(
        msg: "${isMineRoom.value == true ? '解散' : '退出'}中...");
    if (isMineRoom.value == true) {
      await Api.disbandGroupChatRoom(roomId);
    } else {
      await Api.exitGroupChatRoom(roomId);
    }
    SmartDialog.dismiss();
    Get.back(result: true);
  }

  sendMessage() async {
    params.content = sendTextController.text.toString();
    params.roomId = roomId;
    if (params.content!.isEmpty) {
      EasyToast.show("内容不能为空");
      return;
    }
    SmartDialog.showLoading(msg: "发送中..");
    try {
      await Api.sendGroupChatMessage(content: params.content, roomId: roomId);
      onRefresh();
    } catch (_) {}
    SmartDialog.dismiss();
    sendTextController.clear();
    focusNode.unfocus();
  }

  Future<void> pickImage(int index) async {
    final imageFile = index == 2
        ? await EasyImagePicker.pickSingleImageGrantCamera()
        : await EasyImagePicker.pickSingleImageGrant();
    final bytes = await imageFile?.bytes;
    if (bytes != null) {
      _imgFile = bytes;
      postUploadImg(_imgFile!);
    }
  }

  Future postUploadImg(Uint8List bytes) async {
    showCustomDialog(Get.context!, "正在发送中,请稍候..");
    try {
      ImageUploadRspModel? resp =
          await httpInstance.uploadImage(bytes, (int count, int total) {});
      if (resp != null) {
        final result = resp!.fileName;
        List<String> imgs = [];
        imgs.add(result!);
        try {
          await Api.sendGroupChatMessage(imgs: imgs, roomId: roomId);
          onRefresh();
        } catch (e) {
          if (e is Map) {}
        }
      }
    } catch (_) {
      EasyToast.show('发送失败');
    }
    closeDialog(Get.context!);
  }

  @override
  Future<IndicatorResult> onRefresh() async {
    lastId = 0;
    final resp = await Api.getGroupChatMessage(lastId: lastId, roomId: roomId);

    if (resp == null) {
      return IndicatorResult.fail;
    }
    initList(resp);
    _setList(resp);
    return IndicatorResult.success;
  }

  @override
  Future<IndicatorResult> onLoad() async {
    List<ChatMessageXhsModel>? resp =
        await Api.getGroupChatMessage(lastId: lastId, roomId: roomId);
    if (resp == null) {
      return IndicatorResult.fail;
    }
    initList(resp);
    _addList(resp);
    if (resp.length < 20) {
      return IndicatorResult.noMore;
    }

    return IndicatorResult.success;
  }

  void _setList(List<ChatMessageXhsModel> list) {
    messageList.clear();
    _addList(list);
  }

  void _addList(List<ChatMessageXhsModel> list) async {
    if (null != list && list.isNotEmpty) {
      messageList.addAll(list);
      lastId = messageList.last.msgId ?? 0;
      update();
    }
  }

  initList(List<ChatMessageXhsModel> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].sendUserId == userService.user.userId) {
        list[i].msgType = list[i].msgType == 1 ? 4 : 5;
      }
      if (i + 1 < list.length) {
        String dateOne =
            Utils.dateFmt(list[i].createdAt!, ["yyyy", '-', 'mm', '-', 'dd']);
        String dateTwo = Utils.dateFmt(
            list[i + 1].createdAt!, ["yyyy", '-', 'mm', '-', 'dd']);
        if (dateOne != dateTwo) {
          list[i].showDate = true;
        } else {
          list[i].showDate = false;
        }
      }
    }
  }
}
