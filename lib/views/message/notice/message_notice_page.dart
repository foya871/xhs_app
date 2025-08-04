import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/model/mine/system_notice_model.dart';
import 'package:xhs_app/utils/utils.dart';
import 'package:xhs_app/views/message/notice/message_notice_page_controller.dart';

import '../../../assets/styles.dart';
import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../components/text_view.dart';
import '../../../utils/color.dart';

class MessageNoticePage extends GetView<MessageNoticePageController> {
  const MessageNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.color.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextView(
          text: "消息通知",
          textAlign: TextAlign.center,
          fontSize: 18.w,
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
      child: PagedListView<int, SystemNoticeModel>(
        addAutomaticKeepAlives: true,
        pagingController: controller.pagingController,
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 14.w),
        builderDelegate: PagedChildBuilderDelegate<SystemNoticeModel>(
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

  _itemView(SystemNoticeModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      child: Column(
        children: [
          Center(
            child: TextView(
                text: Utils.dateFmt(
                    model.createdAt ?? "", ["yyyy", '-', 'mm', '-', 'dd']), fontSize: 11.w, color: COLOR.color_999999),
          ),
          SizedBox(height: 10.w),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                    text: model.title ?? "",
                    fontSize: 13.w,
                    color: COLOR.color_333333),
                TextView(
                    text: model.content ?? "",
                    fontSize: 12.w,
                    color: COLOR.color_666666),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
