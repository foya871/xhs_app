import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/image_view.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../components/text_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/mine/message_notice_content_model.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';
import 'message_comment_page_controller.dart';

class MessageCommentPage extends StatefulWidget {
  const MessageCommentPage({super.key});

  @override
  State<MessageCommentPage> createState() => _MessageCommentPage();
}

class _MessageCommentPage extends State<MessageCommentPage> {
  final controller = Get.find<MessageCommentPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Styles.color.bgColor,
        title: TextView(
          text: "收到的评论",
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
    Future commentLike(
        int commentId, bool isLike, MessageNoticeContentModel model) async {
      final resp = await Api.toogleDynamicCommentLike(commentId, like: isLike);
      if (resp != null) {
        setState(() {
          model.isLike = !isLike;
        });
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w),
      child: Column(
        children: [
          Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.horizontal,
            children: [
              ImageView(
                src: model.producerLogo ?? "",
                width: 44.w,
                height: 44.w,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(50.w),
                defaultPlace: AppImagePath.icon_avatar,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: model.producerName ?? "",
                      color: Colors.black,
                      fontSize: 16.w,
                      fontWeight: FontWeight.bold,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        TextView(
                          text: "回复了你的",
                          color: COLOR.color_999999,
                          fontSize: 11.w,
                        ),
                        TextView(
                          text: model.quoteMsg?.quoteSubType == 1
                              ? "视频"
                              : model.quoteMsg?.quoteSubType == 2
                                  ? "帖子"
                                  : model.quoteMsg?.quoteSubType == 3
                                      ? "求片"
                                      : model.quoteMsg?.quoteSubType == 4
                                          ? "推片"
                                          : model.quoteMsg?.quoteSubType == 5
                                              ? "评论"
                                              : "资源",
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
                    SizedBox(height: 7.w),
                    TextView(
                      text: model.content ?? "",
                      color: COLOR.color_333333,
                      fontSize: 13.w,
                    ),
                    SizedBox(height: 7.w),
                    TextView(
                      text: "${model.quoteMsg?.quoteSubContent}",
                      color: COLOR.color_999999,
                      fontSize: 11.w,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.w),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Image.asset(
                                model.isLike == true
                                    ? AppImagePath.mine_img_message_comment_like
                                    : AppImagePath
                                        .mine_img_message_comment_like_no,
                                width: 61.w,
                                height: 26.w)
                            .onTap(() => commentLike(
                                model.quoteMsg!.quoteSubId!,
                                model.isLike!,
                                model)),
                        SizedBox(width: 8.w),
                        Image.asset(AppImagePath.mine_img_message_comment_reply,
                                width: 61.w, height: 26.w)
                            .onTap(() => Get.toCommunityDetailById(
                                model.quoteMsg!.quoteSubId!)),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  ImageView(
                    src: model.quoteMsg?.quoteSubImg ?? "",
                    width: 48.w,
                    height: 48.w,
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  Visibility(
                    visible: model.quoteMsg?.quoteSubImgType == 1,
                    child: Image.asset(AppImagePath.player_player_start,
                        width: 14.w, height: 14.w),
                  ),
                ],
              ).onTap(() => Get.toCommunityDetailById(
                  model.quoteMsg!.quoteSubId!)),
            ],
          ),
          SizedBox(height: 14.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_EEEEEE,
          ),
        ],
      ),
    );
  }
}
