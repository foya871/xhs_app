import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../components/image_view.dart';
import '../../../model/mine/chat_list_message_model.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';
import 'message_information_page_controller.dart';

class MessageInformationPage extends StatefulWidget {
  const MessageInformationPage({super.key});

  @override
  State<MessageInformationPage> createState() => _MessageInformationPageState();
}

class _MessageInformationPageState extends State<MessageInformationPage>
    with WidgetsBindingObserver {
  final controller = Get.find<MessageInformationPageController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    if (controller.isOverlayVisible) {
      controller.overlayEntry?.remove();
      controller.isOverlayVisible = false;
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      if (controller.isOverlayVisible) {
        controller.overlayEntry?.remove();
        controller.isOverlayVisible = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.color.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextView(
          text: "消息",
          textAlign: TextAlign.center,
          fontSize: 16.w,
          color: COLOR.color_333333,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Image.asset(
                AppImagePath.mine_img_message_group_tips,
                width: 20.w,
                height: 20.w,
              ),
              TextView(
                text: "发现群聊",
                fontSize: 13.w,
                color: COLOR.color_333333,
              ),
              SizedBox(width: 14.w),
            ],
          ).onTap(() => showOverlay(context)),
        ],
        elevation: 1,
        shadowColor: COLOR.color_EEEEEE,
      ),
      body: VisibilityDetector(
          key: const Key("message_page"),
          onVisibilityChanged: (visibilityInfo) {
            var visibleFraction = visibilityInfo.visibleFraction;
            if (visibleFraction == 0) {
              controller.overlayEntry?.remove();
              controller.overlayEntry = null;
              controller.isOverlayVisible = false;
            }
          },
          child: _bodyViews()),
    );
  }

  _bodyViews() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.w),
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10.w),
              Column(
                children: [
                  Image.asset(AppImagePath.mine_img_message_zancollection,
                      width: 52.w, height: 52.w),
                  TextView(
                      text: "赞和收藏", fontSize: 13.w, color: COLOR.color_333333),
                ],
              ).onTap(() => controller.onClick("赞和收藏")),
              Column(
                children: [
                  Image.asset(AppImagePath.mine_img_message_guanzhu,
                      width: 52.w, height: 52.w),
                  TextView(
                      text: "新增关注", fontSize: 13.w, color: COLOR.color_333333),
                ],
              ).onTap(() => controller.onClick("新增关注")),
              Column(
                children: [
                  Image.asset(AppImagePath.mine_img_message_pingjia,
                      width: 52.w, height: 52.w),
                  TextView(
                      text: "新增评价", fontSize: 13.w, color: COLOR.color_333333),
                ],
              ).onTap(() => controller.onClick("收到的评论")),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 30.w),
          Flex(
            direction: Axis.horizontal,
            children: [
              SizedBox(width: 14.w),
              Image.asset(AppImagePath.mine_img_message_notice,
                  width: 48.w, height: 48.w),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                        text: "消息通知",
                        color: COLOR.color_333333,
                        fontSize: 13.w),
                    TextView(
                        text: "消息公告",
                        color: COLOR.color_999999,
                        fontSize: 12.w),
                  ],
                ),
              ),
              SizedBox(width: 14.w),
            ],
          ).onTap(() {
            controller.overlayEntry?.remove();
            controller.overlayEntry = null;
            controller.isOverlayVisible = false;
            controller.onClick("消息通知");
          }),
          Expanded(
            child: BaseRefreshWidget(controller,
                child: Obx(() => ListView.builder(
                      itemCount: controller.chatList.length,
                      itemBuilder: (context, index) {
                        return _buildDelItem(controller.chatList[index], index);
                      },
                    ))),
          ),
        ],
      ),
    );
  }

  _buildDelItem(ChatListMessageModel model, int index) {
    return Slidable(
      key: ValueKey("$index"),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          backgroundColor: COLOR.color_FB2D45,
          foregroundColor: Colors.white,
          label: '删除',
          onPressed: (BuildContext context) {
            controller.overlayEntry?.remove();
            controller.overlayEntry = null;
            controller.isOverlayVisible = false;
            controller.chatList?.remove(model);
            controller.deleteItem(model.userId!);
          },
        ),
      ]),
      child: _chatItemView(model, index),
    );
  }

  _chatItemView(ChatListMessageModel model, int index) {
    return InkWell(
      onTap: () => controller.jumpChat(
          model.userId ?? 0, model.nickName ?? "", model.logo ?? ""),
      child: Container(
        margin: EdgeInsets.only(top: 18.w, left: 14.w, right: 14.w),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            ImageView(
                src: model.logo ?? "",
                width: 48.w,
                height: 48.w,
                borderRadius: BorderRadius.circular(50.w)),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                      text: model.nickName ?? "",
                      fontSize: 16.w,
                      color: COLOR.color_333333),
                  TextView(
                      text: model.newMessage ?? "",
                      fontSize: 12.w,
                      color: COLOR.color_999999,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Column(
              children: [
                TextView(
                    text: Utils.dateAgo(model.newMessageDate ?? ""),
                    fontSize: 12.w,
                    color: COLOR.color_999999),
                Visibility(
                  visible: model.noReadNum! > 0,
                  child: IntrinsicWidth(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 16.w,
                      ),
                      child: Container(
                        height: 16.w,
                        margin: EdgeInsets.only(top: 5.w),
                        color: COLOR.color_FB2D45,
                        child: Center(
                          child: TextView(
                              text: "${model.noReadNum}",
                              color: Colors.white,
                              fontSize: 11.w),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showOverlay(BuildContext context) {
    if (controller.isOverlayVisible) {
      controller.overlayEntry!.remove();
      controller.isOverlayVisible = false;
      controller.overlayEntry = null;
      return;
    }

    final overlay = Overlay.of(context);
    controller.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 10.w,
        top: 80.w,
        width: 118.w,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 118.w,
            height: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 43.w,
                  alignment: Alignment.center,
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImagePath.mine_img_message_group_one,
                          width: 20.w, height: 20.w),
                      SizedBox(width: 6.w),
                      TextView(
                          text: "创建群聊",
                          color: COLOR.color_333333,
                          fontSize: 13.w),
                    ],
                  ),
                ).onTap(() {
                  controller.overlayEntry?.remove();
                  controller.overlayEntry = null;
                  controller.isOverlayVisible = false;
                  controller.onClick("创建群聊");
                }),
                Container(
                  width: double.infinity,
                  height: 1.w,
                  color: COLOR.color_EEEEEE,
                ),
                Container(
                  height: 43.w,
                  alignment: Alignment.center,
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImagePath.mine_img_message_group_two,
                          width: 20.w, height: 20.w),
                      SizedBox(width: 6.w),
                      TextView(
                          text: "群聊广场",
                          color: COLOR.color_333333,
                          fontSize: 13.w),
                    ],
                  ),
                ).onTap(() {
                  controller.overlayEntry?.remove();
                  controller.overlayEntry = null;
                  controller.isOverlayVisible = false;
                  controller.onClick("群聊广场");
                }),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(controller.overlayEntry!);
    controller.isOverlayVisible = true;
  }
}
