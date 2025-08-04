import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/message_information/message_follow_page_controller.dart';

import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/image_view.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../components/text_view.dart';
import '../../../http/api/api.dart';
import '../../../model/mine/message_notice_content_model.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';

class MessageFollowPage extends StatefulWidget {
  const MessageFollowPage({super.key});

  @override
  State<MessageFollowPage> createState() => _MessageFollowPageState();
}

class _MessageFollowPageState extends State<MessageFollowPage> {
  final controller = Get.find<MessageFollowPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Styles.color.bgColor,
        title: TextView(
          text: "新增关注",
          textAlign: TextAlign.center,
          fontSize: 16.w,
          color: COLOR.color_333333,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        shadowColor: COLOR.color_EEEEEE,
      ),
      body: _bodyViews(),
    );
  }

  _bodyViews() {
    return BaseRefreshWidget(
      controller,
      child: PagedListView<int, MessageNoticeContentModel>(
        addAutomaticKeepAlives: true,
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<MessageNoticeContentModel>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const NoMore(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => _itemView(item),
        ),
      ),
    );
  }

  _itemView(MessageNoticeContentModel model) {
    Future messageFollow(
        int toUserId, bool isAttention, MessageNoticeContentModel model) async {
      SmartDialog.showLoading(msg: "操作中..");
      final resp = await Api.messageFollowAttention(
          toUserId: toUserId, isAttention: isAttention);
      if (resp) {
        setState(() {
          model.isAttention = !isAttention;
        });
      }
      SmartDialog.dismiss();
    }

    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w),
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              ImageView(
                src: model.producerLogo ?? "",
                width: 44.w,
                height: 44.w,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(50.w),
                defaultPlace: AppImagePath.icon_avatar,
              ).onTap(()=> controller.jumpBlogger(model.producerUserId ?? 0)),
              SizedBox(width: 8.w),
              Expanded(
                child: SizedBox(
                  height: 44.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: model.producerName ?? "",
                        color: Colors.black,
                        fontSize: 13.w,
                        fontWeight: FontWeight.w500,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          TextView(
                            text: "TA关注了你 期待你回关",
                            color: COLOR.color_999999,
                            fontSize: 11.w,
                          ),
                          SizedBox(width: 5.w),
                          TextView(
                            text: Utils.dateAgo(model.createdAt ?? ""),
                            color: COLOR.color_999999,
                            fontSize: 11.w,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ).onTap(()=> controller.jumpBlogger(model.producerUserId ?? 0)),
              ),
              Container(
                width: 62.w,
                height: 28.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: model.isAttention == true
                          ? COLOR.color_EEEEEE
                          : COLOR.color_FB2D45),
                  borderRadius: BorderRadius.circular(16.w),
                ),
                child: TextView(
                  text: model.isAttention == true ? "已关注" : "回关",
                  fontSize: 13.w,
                  color: model.isAttention == true
                      ? COLOR.color_999999
                      : COLOR.color_FB2D45,
                ),
              ).onTap(
                () {
                  messageFollow(
                      model.producerUserId!, model.isAttention!, model);
                },
              ),
            ],
          ),
          SizedBox(height: 14.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_EEEEEE,
          )
        ],
      ),
    );
  }
}
