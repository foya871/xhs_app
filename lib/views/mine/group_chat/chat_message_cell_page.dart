import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/message/chat_message_xhs_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';

class ChatMessageCellPage extends StatelessWidget {
  final ChatMessageXhsModel model;

  const ChatMessageCellPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.w),
      child: model.msgType == 1
          ? _itemViewOneText()
          : model.msgType == 2
              ? _itemViewTwoImg()
              : model.msgType == 4
                  ? _itemViewFourText()
                  : _itemViewFiveImg(),
    );
  }

  _itemViewOneText() {
    return Column(
      children: [
        Visibility(
          visible: model.showDate == true,
          child: Center(
            child: Container(
                margin: EdgeInsets.only(bottom: 14.w),
                child: TextView(
                    text: Utils.dateFmt(
                        model.createdAt!, ["yyyy", '-', 'mm', '-', 'dd']),
                    fontSize: 12.w,
                    color: COLOR.color_999999)),
          ),
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            ImageView(
                src: model.sendLogo ?? "",
                width: 50.w,
                height: 50.w,
                borderRadius: BorderRadius.circular(50.w),
                defaultPlace: AppImagePath.icon_avatar)
            .onTap(() => Get.toBloggerDetail(userId: model.sendUserId ?? 0)),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                    text: model.sendNickName ?? "",
                    fontSize: 12.w,
                    color: COLOR.color_999999),
                IntrinsicWidth(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 50.w,
                      minHeight: 36.w,
                      maxWidth: 220.w,
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.w),
                            topRight: Radius.circular(16.w),
                            bottomLeft: Radius.circular(16.w),
                            bottomRight: Radius.circular(16.w)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: TextView(
                            text: model.content ?? "",
                            fontSize: 13.w,
                            color: COLOR.color_333333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _itemViewTwoImg() {
    return Column(
      children: [
        Visibility(
          visible: model.showDate == true,
          child: Center(
            child: Container(
                margin: EdgeInsets.only(bottom: 14.w),
                child: TextView(
                    text: Utils.dateFmt(
                        model.createdAt!, ["yyyy", '-', 'mm', '-', 'dd']),
                    fontSize: 12.w,
                    color: COLOR.color_999999)),
          ),
        ),
        Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
                src: model.sendLogo ?? "",
                width: 50.w,
                height: 50.w,
                borderRadius: BorderRadius.circular(50.w),
                defaultPlace: AppImagePath.icon_avatar)
                .onTap(() => Get.toBloggerDetail(userId: model.sendUserId ?? 0)),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                      text: model.sendNickName ?? "",
                      fontSize: 12.w,
                      color: COLOR.color_999999),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.imgs?.length,
                      padding: EdgeInsets.only(top: 4.w),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10.w),
                          child: ImageView(
                            src: model.imgs?[index] ?? "",
                            width: 160.w,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.w),
                              topRight: Radius.circular(16.w),
                              bottomLeft: Radius.circular(16.w),
                              bottomRight: Radius.circular(16.w),
                            ),
                            defaultPlace: AppImagePath.icon_placeholder_v,
                          ).onTap(() => Get.toImageViewer(model.imgs!)),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _itemViewFourText() {
    return Column(
      children: [
        Visibility(
          visible: model.showDate == true,
          child: Center(
            child: Container(
                margin: EdgeInsets.only(bottom: 14.w),
                child: TextView(
                    text: Utils.dateFmt(
                        model.createdAt!, ["yyyy", '-', 'mm', '-', 'dd']),
                    fontSize: 12.w,
                    color: COLOR.color_999999)),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextView(
                        text: model.sendNickName ?? "",
                        fontSize: 12.w,
                        color: COLOR.color_999999),
                    IntrinsicWidth(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 50.w,
                          minHeight: 36.w,
                          maxWidth: 220.w,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.w),
                                topRight: Radius.circular(4.w),
                                bottomLeft: Radius.circular(16.w),
                                bottomRight: Radius.circular(16.w)),
                            color: COLOR.hexColor("#00a2f9"),
                          ),
                          child: Center(
                            child: TextView(
                                text: model.content ?? "",
                                fontSize: 15.w,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              ImageView(
                  src: model.sendLogo ?? "",
                  width: 50.w,
                  height: 50.w,
                  borderRadius: BorderRadius.circular(50.w),
                  defaultPlace: AppImagePath.icon_avatar),
            ],
          ),
        ),
      ],
    );
  }

  _itemViewFiveImg() {
    return Column(
      children: [
        Visibility(
          visible: model.showDate == true,
          child: Center(
            child: Container(
                margin: EdgeInsets.only(bottom: 14.w),
                child: TextView(
                    text: Utils.dateFmt(
                        model.createdAt!, ["yyyy", '-', 'mm', '-', 'dd']),
                    fontSize: 12.w,
                    color: COLOR.color_999999)),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextView(
                        text: model.sendNickName ?? "",
                        fontSize: 12.w,
                        color: COLOR.color_999999),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.imgs?.length,
                        padding: EdgeInsets.only(top: 4.w),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.w),
                            child: ImageView(
                              src: model.imgs?[index] ?? "",
                              width: 160.w,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.w),
                                topRight: Radius.circular(16.w),
                                bottomLeft: Radius.circular(16.w),
                                bottomRight: Radius.circular(16.w),
                              ),
                              defaultPlace: AppImagePath.icon_placeholder_v,
                            ).onTap(() => Get.toImageViewer(model.imgs!)),
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              ImageView(
                  src: model.sendLogo ?? "",
                  width: 50.w,
                  height: 50.w,
                  borderRadius: BorderRadius.circular(50.w),
                  defaultPlace: AppImagePath.icon_avatar),
            ],
          ),
        ),
      ],
    );
  }
}
