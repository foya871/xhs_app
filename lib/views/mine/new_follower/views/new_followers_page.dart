import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/no_more/no_data_scroll_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/mine/message_conter_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../controllers/new_followers_page_controller.dart';

class NewFollowersPage extends StatefulWidget {
  const NewFollowersPage({super.key});

  @override
  _NewFollowersPageState createState() => _NewFollowersPageState();
}

class _NewFollowersPageState extends State<NewFollowersPage> {
  final controller = Get.find<NewFollowersPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_F5F5F5,
      appBar: AppBarView(
        titleText: '收到的赞和收藏',
      ),
      body: _bodyViews(),
    );
  }

  Widget _bodyViews() {
    return BaseRefreshWidget(
      controller,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Obx(() => controller.messageItems.isNotEmpty
            ? ListView.builder(
                itemCount: controller.messageItems.length,
                itemBuilder: (context, index) =>
                    _itemView(controller.messageItems[index]),
              )
            : NoDataScrollView()),
      ),
    );
  }

  Widget _itemView(MessageConterModel model) {
    final isAttention = model.attentionHe ?? false;
    return Container(
      height: 72.w,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: COLOR.color_EEEEEE),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              ImageView(
                src: model.producerLogo ?? "",
                width: 44.w,
                height: 44.w,
                borderRadius: BorderRadius.circular(44.w),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: model.producerName ?? "",
                    fontSize: 13.w,
                    color: COLOR.color_333333,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    children: [
                      TextView(
                        text: model.msgActionDesc ?? "",
                        fontSize: 11.w,
                        color: COLOR.color_999999,
                      ),
                      TextView(
                        text: model.updatedAt ?? "",
                        fontSize: 11.w,
                        color: COLOR.color_999999,
                      ),
                    ],
                  )
                ],
              ).marginLeft(6.w)
            ],
          ),
          ImageView(
            src: model.quoteMsg?.quoteSubImg ?? "",
            width: 44.w,
            height: 44.w,
            borderRadius: BorderRadius.circular(4.w),
          ),
          // Expanded(
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 10.w),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         TextView(
          //           text: "${model.producerName}",
          //           fontSize: 14.w,
          //           color: COLOR.color_333333,
          //           fontWeight: FontWeight.w600,
          //         ),
          //         TextView(
          //           text: model.msgActionDesc ?? "",
          //           fontSize: 10.w,
          //           color: COLOR.color_999999,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () async {
          //     SmartDialog.showLoading(msg: '操作中...');
          //     if (isAttention) {
          //       await controller.follwersCancel(
          //           toUserId: model.producerUserId ?? 0);
          //     } else {
          //       await controller.follwers(toUserId: model.producerUserId ?? 0);
          //     }
          //     model.attentionHe = !isAttention;
          //     SmartDialog.dismiss();
          //     setState(() {});
          //   },
          //   child: Container(
          //     width: 70.w,
          //     height: 25.h,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: isAttention ? Colors.white : COLOR.color_FF4340,
          //       border: Border.all(color: COLOR.color_FFB5B5, width: 1),
          //       borderRadius: BorderRadius.circular(19.w),
          //     ),
          //     child: TextView(
          //       text: isAttention ? "相互关注" : "回关",
          //       fontSize: 12.w,
          //       color: isAttention ? COLOR.color_FF4340 : COLOR.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
