import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/group_chat/chat_message_cell_page.dart';
import 'package:xhs_app/views/mine/group_chat/group_chat_message_page_controller.dart';

import '../../../assets/styles.dart';
import '../../../components/text_view.dart';
import '../../../utils/color.dart';

class GroupChatMessagePage extends GetView<GroupChatMessagePageController> {
  const GroupChatMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.color.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Obx(
          () => Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageView(
                  src: controller.roomLogo.value,
                  width: 30.w,
                  height: 30.w,
                  borderRadius: BorderRadius.circular(50.w),
                  defaultPlace: AppImagePath.icon_avatar),
              SizedBox(width: 8.w),
              Expanded(
                child: TextView(
                  text: controller.roomName.value,
                  fontSize: 16.w,
                  color: COLOR.color_333333,
                ),
              ),
            ],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        shadowColor: COLOR.color_EEEEEE,
        actions: [
          TextView(
              text: controller.isMineRoom.value == true ? "解散" : "退出",
              fontSize: 14.w,
              color: COLOR.color_666666)
              .onTap(() => controller.showTipsDialog()),
          SizedBox(width: 15.w),
        ],
      ),
      body: _bodyViews(),
    );
  }

  _bodyViews() {
    return Column(
      children: [
        Expanded(
          child: GetBuilder<GroupChatMessagePageController>(
            builder: (context) {
              return BaseRefreshWidget(
                controller,
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: controller.messageList.length,
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.w),
                  itemBuilder: (context, index) {
                    return ChatMessageCellPage(
                        model: controller.messageList[index]);
                  },
                ),
              ).onOpaqueTap(() => controller.focusNode.unfocus());
            }
          ),
        ),
        _buildInputTextBottomView(),
      ],
    );
  }

  _buildInputTextBottomView(){
    void showPicker() {
      if (kIsWeb) {
        controller.pickImage(3);
        return;
      }
      controller.pickImage(1);
    }

    return ValueListenableBuilder(
        valueListenable: controller.showInputText,
        builder: (context, value, child){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.w),
            width: double.infinity,
            height: 60.w,
            color: Colors.white,
            child: Column(
              children: [
                Visibility(
                  visible: !value,
                  maintainState: true,
                  child: Container(
                    width: 334.w,
                    height: 42.w,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21.w),
                      color: COLOR.color_EEEEEE,
                    ),
                    child: Flex(
                        direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(text: "聊骚快人一步，请勇于发言", fontSize: 13.w, color: COLOR.color_999999),
                        Image.asset(AppImagePath.mine_img_chatmessage_pic, width: 25.w, height: 23.w),
                      ],
                    ),
                  ).onOpaqueTap((){
                    controller.showInputText.value = true;
                    controller.focusNode.requestFocus();
                  }),
                ),
                Visibility(
                  visible: value,
                    maintainState: true,
                    child: Flex(
                        direction: Axis.horizontal,
                      children: [
                        Expanded(
                            child: Container(
                              width: 280.w,
                              height: 42.w,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(21.w),
                                color: COLOR.color_EEEEEE,
                              ),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ValueListenableBuilder(
                                        valueListenable: controller.defaultText,
                                        builder: (context, value, child){
                                          return TextField(
                                            focusNode: controller.focusNode,
                                            maxLines: 1,
                                            controller: controller.sendTextController,
                                            style: TextStyle(
                                              color: COLOR.color_333333,
                                              fontSize: 13.w,
                                            ),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                EdgeInsets.only(left: 13.w),
                                                hintText: value,
                                                hintStyle: TextStyle(
                                                  color: COLOR.color_999999,
                                                  fontSize: 13.w,
                                                ),
                                                enabledBorder: const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(0, 0, 0, 0))),
                                                focusedBorder: const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(0, 0, 0, 0)))),
                                            onSubmitted: (value){
                                              controller.params.content = value;
                                            },
                                          );
                                        }),
                                  ),
                                  Image.asset(
                                      AppImagePath.mine_img_chatmessage_pic,
                                      width: 25.w,
                                      height: 23.w).onTap(()=> showPicker()),
                                  SizedBox(width: 14.w),
                                ],
                              ),
                            ),
                        ),
                        SizedBox(width: 13.w),
                        TextView(
                            text: "发布",
                            fontSize: 16.w,
                            color: COLOR.color_FB2D45,
                            fontWeight: FontWeight.w600).onTap(() => controller.sendMessage()),
                      ],
                    ),
                ),
              ],
            ),
          );
        });
  }
}
