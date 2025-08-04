import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../model/mine/group_chatroom_model.dart';
import 'group_chatroom_page_controller.dart';

class GroupChatDetailPage extends StatelessWidget {
  final GroupChatroomModel model;
  final int userId;
  final GroupChatRoomPageController controller;

  const GroupChatDetailPage(
      {super.key,
      required this.model,
      required this.userId,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 17.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.w), topRight: Radius.circular(12.w)),
        color: COLOR.color_F8F8F8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(AppImagePath.mine_img_group_dialog_close,
                width: 16.w, height: 16.w),
          ).onTap(() => Get.back()),
          Center(
              child: ImageView(
                  src: model.roomLogo ?? "",
                  width: 64.w,
                  height: 64.w,
                  defaultPlace: AppImagePath.icon_avatar,
                  borderRadius: BorderRadius.circular(50.w))),
          SizedBox(height: 11.w),
          Center(
            child: TextView(
                text: "${model.roomName}(${model.roomTotalNum})",
                fontSize: 13.w,
                color: COLOR.color_333333),
          ),
          SizedBox(height: 14.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_EEEEEE,
          ),
          SizedBox(height: 10.w),
          Flex(
            direction: Axis.horizontal,
            children: [
              ImageView(
                  src: model.logo ?? "",
                  width: 30.w,
                  height: 30.w,
                  borderRadius: BorderRadius.circular(50.w),
                  defaultPlace: AppImagePath.icon_avatar),
              SizedBox(width: 10.w),
              Expanded(
                  child: TextView(
                      text: model.nickName ?? "",
                      fontSize: 13.w,
                      color: COLOR.color_333333)),
              Visibility(
                visible: model.userId != userId,
                child: TextView(
                        text: "查看群主主页>",
                        fontSize: 12.w,
                        color: COLOR.color_999999)
                    .onTap(() => Get.toBloggerDetail(userId: userId)),
              ),
            ],
          ),
          SizedBox(height: 10.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_EEEEEE,
          ),
          SizedBox(height: 20.w),
          TextView(text: "群介绍", fontSize: 15.w, color: COLOR.color_333333),
          SizedBox(height: 10.w),
          TextView(
              text: model.info ?? "",
              fontSize: 12.w,
              color: COLOR.color_999999),
          SizedBox(height: 60.w),
          Center(
            child: Container(
              width: 148.w,
              height: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.w),
                color: COLOR.color_FB2D45,
              ),
              child: Center(
                child: TextView(
                        text: model.join == true ? "去聊天" : "立即加入",
                        fontSize: 14.w,
                        color: Colors.white)
                    .onTap(() {
                  Get.back();
                  controller.jumpRoom(model);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
