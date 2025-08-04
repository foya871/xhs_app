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
import '../../../components/image_picker/easy_image_picker.dart';
import '../../../http/api/api.dart';
import '../../../http/service/api_service.dart';
import '../../../model/image_upload_resp_model.dart';
import '../../../services/user_service.dart';
import '../../../utils/loading_dialog.dart';
import '../../../utils/utils.dart';

class PrivateChatMessagePageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final userService = Get.find<UserService>();
  int lastId = 0;
  int toUserId = 0;
  List<ChatMessageXhsModel> messageList = List<ChatMessageXhsModel>.of([]);

  final userLogo = "".obs;
  final userName = "".obs;
  final isMineRoom = false.obs;
  final attention = false.obs;

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
    userLogo.value = Get.arguments['logo'] ?? "";
    userName.value = Get.arguments['name'] ?? "";
    toUserId = Get.arguments['userid'] ?? 0;
    if (toUserId == userService.user.userId) isMineRoom.value = true;
  }

  @override
  void onClose() {
    refreshController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  sendMessage() async {
    params.content = sendTextController.text.toString();
    params.toUserId = toUserId;
    if (params.content!.isEmpty) {
      EasyToast.show("内容不能为空");
      return;
    }
    SmartDialog.showLoading(msg: "发送中..");
    try {
      await Api.sendPrivateChatMessage(
          content: params.content, toUserId: toUserId);
      onRefresh();
    } catch (_) {}
    SmartDialog.dismiss();
    sendTextController.clear();
    focusNode.unfocus();
  }

  followUser() async {
    try {
      final resp = await Api.messageFollowAttention(
          toUserId: toUserId, isAttention: attention.value);
      if (resp) attention.value = !attention.value;
    } catch (_) {}
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
          await Api.sendPrivateChatMessage(imgs: imgs, toUserId: toUserId);
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
    final resp =
        await Api.getPrivateChatMessage(lastId: lastId, toUserId: toUserId);

    if (resp == null || resp?.data == null) {
      return IndicatorResult.fail;
    }
    attention.value = resp.attention!;
    initList(resp!.data!);
    _setList(resp!.data!);
    return IndicatorResult.success;
  }

  @override
  Future<IndicatorResult> onLoad() async {
    final resp =
        await Api.getPrivateChatMessage(lastId: lastId, toUserId: toUserId);
    if (resp == null) {
      return IndicatorResult.fail;
    }
    if (resp.data == null) {
      return IndicatorResult.noMore;
    }
    initList(resp!.data!);
    _addList(resp!.data!);
    if (resp.data!.length < 20) {
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
