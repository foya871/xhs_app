import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/mine/group_chatroom_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';

import 'group_chat_page_controller.dart';

class GroupChatPage extends GetView<GroupChatPageController> {
  const GroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_F9F9F9,
      appBar: AppBar(
        backgroundColor: COLOR.white,
        title: Obx(() => Text("${controller.nickName}的群聊")),
      ),
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return SingleChildScrollView(
      child: EasyRefresh(
        controller: controller.easyRefreshController,
        refreshOnStart: false,
        onRefresh: () => controller.getHttpDatas(),
        onLoad: null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserGroupView(),
            20.verticalSpace,
            TextView(
              text: "你可能感兴趣",
              fontSize: 15.w,
              color: COLOR.color_333333,
              fontWeight: FontWeight.w500,
            ),
            10.verticalSpace,
            _buildInterestedGroupView(),
          ],
        ),
      ),
    ).paddingAll(14.w);
  }

  _buildUserGroupView() {
    return Obx(() => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: controller.bloggerGroupChatList.length,
          itemBuilder: (BuildContext context, int index) {
            final item = controller.bloggerGroupChatList[index];
            return _buildGroupItemView(item, onTap: () async {
              if (item.join == true) {
                bool res = await Get.toGroupChatMessage(
                    logo: item.roomLogo ?? "",
                    name: '${item.roomName}(${item.roomTotalNum})',
                    userid: item.userId!,
                    roomid: item.roomId!);
                if (res) {
                  controller.getHttpDatas();
                }
              } else {
                controller.joinChatRoom(item.roomId ?? 0, 1);
              }
            });
          },
          separatorBuilder: (BuildContext context, int index) {
            return 8.verticalSpace;
          },
        ));
  }

  _buildInterestedGroupView() {
    return Obx(() => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: controller.hotGroupChatList.length,
          itemBuilder: (BuildContext context, int index) {
            final item = controller.hotGroupChatList[index];
            return _buildGroupItemView(item, onTap: () async {
              if (item.join == true) {
                bool res = await Get.toGroupChatMessage(
                    logo: item.roomLogo ?? "",
                    name: '${item.roomName}(${item.roomTotalNum})',
                    userid: item.userId!,
                    roomid: item.roomId!);
                if (res) {
                  controller.getHttpDatas();
                }
              } else {
                controller.joinChatRoom(item.roomId ?? 0, 2);
              }
            });
          },
          separatorBuilder: (BuildContext context, int index) {
            return 8.verticalSpace;
          },
        ));
  }

  _buildGroupItemView(GroupChatroomModel item, {Function()? onTap}) {
    return AppBgView(
      height: 72.w,
      backgroundColor: COLOR.white,
      radius: 8.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          ImageView(
            src: item.roomLogo ?? "",
            width: 48.w,
            height: 48.w,
            defaultPlace: AppImagePath.icon_avatar,
            borderRadius: BorderRadius.circular(24.w),
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: '${item.roomName ?? ""}(${item.roomTotalNum})',
                  fontSize: 13.w,
                  color: COLOR.color_333333,
                  fontWeight: FontWeight.w500,
                ),
                3.verticalSpace,
                TextView(
                  text: item.info ?? "",
                  fontSize: 12.w,
                  color: COLOR.color_999999,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          8.horizontalSpace,
          AppBgView(
            width: 60.w,
            height: 30.w,
            radius: 15.w,
            border: Border.all(color: COLOR.color_FB2D45, width: 0.7),
            text: item.join == true ? "去聊天" : "加入",
            textColor: COLOR.color_FB2D45,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
