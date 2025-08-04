import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map_detail/intension_map_detail_state.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';

class IntensionMapDetailLogic extends GetxController
    with GetTickerProviderStateMixin {
  final IntensionMapDetailState state = IntensionMapDetailState();

  @override
  void onInit() {
    if (Get.parameters.isNotEmpty) {
      state.connotationId.value =
          int.tryParse(Get.parameters['connotationId'] ?? '') ?? 0;
      getDynamicInfo(state.connotationId.value);
      getCommentListInfo(state.connotationId.value);
    }
    super.onInit();
    state.focusNode.addListener(() {
      if (state.focusNode.hasFocus) {
        state.showComm.value = true;
      } else {
        state.showComm.value = false;
      }
    });
  }

  @override
  void onClose() {
    state.focusNode.dispose();
    super.onClose();
  }

  Future getDynamicInfo(int connotationId) async {
    final result = await Api.getIntensionMapDetailFindList(
      connotationId: state.connotationId.value,
    );
    if (result != null) {
      state.community.value = result;
      state.communityInfoList.value =result.data ?? [];
    }
    Get.log("=================> 2  ${result?.toJson()}");
    Get.log("=================> 3  ${state.communityInfoList.length}");

    update();
  }

  Future handleComment() async {
    // params.value.state.connotationId = state.community.value.state.connotationId;
    // params.value.content = commTextController.text;
    // if (params.value.content!.isEmpty) {
    //   EasyToast.show('评论内容不能为空');
    //   return;
    // }
    // try {
    //   await httpInstance.post(
    //     url: '/state.community/dynamic/saveComment',
    //     body: params.toJson(),
    //   );
    //   params.value = CommentSendModel.fromJson({
    //     'parentId': 0,
    //     'topId': 0,
    //   });
    //   EasyToast.show('评论成功');
    //   // ignore: empty_catches
    // } catch (e) {}
    // commTextController.text = '';
    // state.focusNode.unfocus();
  }






  Future getCommentListInfo(int connotationId) async {
    final result = await Api.getConnotationCommentList(
      connotationId: state.connotationId.value,
    );
    if (result != null) {
      state.intensionMapDetailComments.value = result;
    }
    update([]);
  }
}
