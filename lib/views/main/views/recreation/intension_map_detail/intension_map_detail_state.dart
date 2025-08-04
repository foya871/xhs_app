import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:xhs_app/model/comment/comment_send_model.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';
import 'package:xhs_app/model/video/intension_map_detail_comment.dart';
import 'package:xhs_app/model/video/intension_map_detail_model.dart';
import 'package:xhs_app/services/user_service.dart';
class IntensionMapDetailState {
  var connotationId = 0.obs;
  var title="".obs;
  IntensionMapDetailState() {

    if (Get.parameters.isNotEmpty && Get.parameters['connotationId'] != null) {
      connotationId.value = int.parse(Get.parameters['connotationId'] ?? '0');
    }
    if (Get.parameters.isNotEmpty && Get.parameters['title'] != null) {
      title.value = Get.parameters['title']??"";
    }

  }

  var community = IntensionMapDetailModel.fromJson({}).obs;


  var communityInfoList = <IntensionMapDetailModelData>[].obs;

  var intensionMapDetailComments = <IntensionMapDetailComment>[].obs;


  var pictures = <String>[].obs;
  TextEditingController commTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ValueNotifier<bool> showComm = ValueNotifier(false);
  ValueNotifier<String> defaultText = ValueNotifier('请输入…');
  var params = CommentSendModel.fromJson({
    'parentId': 0,
    'topId': 0,
  }).obs;
  final us = Get.find<UserService>().user;
  var shouldShowDialog = 0.obs;

  List<String> list1= ["全部", "娱乐八卦", "人在囧图"];
  int index1=0;
}
