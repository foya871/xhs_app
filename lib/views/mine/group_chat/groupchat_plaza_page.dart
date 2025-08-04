import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/model/mine/group_chatroom_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/group_chat/group_chatroom_page_controller.dart';

import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../generate/app_image_path.dart';

class GroupChatPlazaPage extends StatefulWidget {
  String classifyName;

  GroupChatPlazaPage({super.key, required this.classifyName});

  @override
  State<GroupChatPlazaPage> createState() => _GroupChatPlazaState();
}

class _GroupChatPlazaState extends State<GroupChatPlazaPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GroupChatRoomPageController>();
    controller.classifyName = widget.classifyName;
    return Column(
      children: [
        Expanded(
          child: BaseRefreshWidget(
            controller,
            child: PagedListView<int, GroupChatroomModel>(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              addAutomaticKeepAlives: true,
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<GroupChatroomModel>(
                firstPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                newPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noMoreItemsIndicatorBuilder: (context) => const NoMore(),
                noItemsFoundIndicatorBuilder: (context) => const NoData(),
                itemBuilder: (context, item, index) =>
                    _itemView(item, controller),
              ),
            ),
          ),
        ),
        Center(
          child: Image.asset(AppImagePath.mine_img_create_group,
                  width: 148.w, height: 40.w)
              .onTap(() => controller.jumpCreateRoom()),
        ),
        SizedBox(height: 12.w),
      ],
    );
  }

  _itemView(GroupChatroomModel model, GroupChatRoomPageController controller) {
    return Container(
      width: double.infinity,
      height: 72.w,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: Colors.white,
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          SizedBox(width: 8.w),
          ImageView(
                  src: model.roomLogo ?? "",
                  width: 48.w,
                  height: 48.w,
                  defaultPlace: AppImagePath.icon_avatar,
                  borderRadius: BorderRadius.circular(50.w),
                  fit: BoxFit.cover)
              .onTap(() => controller.openDialog(model)),
          SizedBox(width: 8.w),
          Expanded(
            child: Container(
              height: 48.w,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      TextView(
                        text: model.roomName ?? "",
                        fontSize: 13.w,
                        color: COLOR.color_333333,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextView(
                          text: "(${model.roomTotalNum})",
                          fontSize: 13.w,
                          color: COLOR.color_333333),
                    ],
                  ),
                  TextView(
                    text: model.info ?? "",
                    fontSize: 12.w,
                    color: COLOR.color_999999,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ).onTap(() => controller.openDialog(model)),
          ),
          Container(
            width: 54.w,
            height: 28.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              border: Border.all(color: COLOR.color_FB2D45),
            ),
            child: TextView(
                text: model.join == true ? "去聊天" : "加入",
                fontSize: 13.w,
                color: COLOR.color_FB2D45),
          ).onTap(() {
            controller.jumpRoom(model);
            setState(() {});
          }),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
