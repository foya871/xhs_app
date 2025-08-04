import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/message/service_message_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/utils.dart';

import 'message_service_page_controller.dart';

///服务消息
class MessageServicePage extends GetView<MessageServicePageController> {
  const MessageServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextView(text: "服务消息")),
      body: _builBodyView(),
    );
  }

  _builBodyView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: BaseRefreshWidget(
        controller,
        child: Obx(() => ListView.builder(
              itemCount: controller.serviceMessageList.length,
              itemBuilder: (BuildContext context, int index) {
                var item = controller.serviceMessageList[index];
                return _buildItemView(item);
              },
            )),
      ),
    );
  }

  _buildItemView(ServiceMessageModel item) {
    return AppBgView(
      width: double.infinity,
      backgroundColor: COLOR.color_181818,
      radius: 6.w,
      margin: EdgeInsets.only(bottom: 20.w),
      padding: EdgeInsets.symmetric(vertical: 12.w),
      onTap: () {
        if (item.type == 1) {
          Get.toVip();
        } else {
          // Get.toTopicDetail(id: item.topicId ?? "");
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///标题、时间
          Row(
            children: [
              ImageView(
                src: item.logo ?? "",
                width: 20.w,
                height: 20.w,
                borderRadius: BorderRadius.circular(10.w),
              ),
              9.horizontalSpace,
              TextView(
                text: item.nickName ?? "",
                color: COLOR.white,
                fontSize: 14.w,
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              TextView(
                text: Utils.formatTime(item.createdAt ?? ""),
                color: COLOR.color_8D9198,
                fontSize: 10.w,
              ),
            ],
          ).paddingSymmetric(horizontal: 14.w),
          15.verticalSpace,
          ImageView(
            src: item.images ?? "",
            width: double.infinity,
            height: 150.w,
            fit: BoxFit.fill,
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: item.title ?? "",
                  color: COLOR.white,
                  fontSize: 12.w,
                  maxLines: 1,
                ),
                8.verticalSpace,
                TextView(
                  text: item.info ?? "",
                  color: COLOR.color_8D9198,
                  fontSize: 11.w,
                ),
                20.verticalSpace,
                Row(
                  children: [
                    TextView(
                      text: item.type == 1 ? "立即抢购" : "查看详情",
                      color: COLOR.color_B940FF,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w700,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.chevron_right_outlined,
                      size: 20.w,
                      color: COLOR.color_B940FF,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
