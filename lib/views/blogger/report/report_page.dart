import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import 'report_page_controller.dart';

class ReportPage extends GetView<ReportPageController> {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_F9F9F9,
      appBar: AppBar(
        backgroundColor: COLOR.white,
        title: const Text('举报用户'),
      ),
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return Column(
      children: [
        Expanded(child: _buildReportContentView()),
        _buildSubmitButtonView(),
        20.verticalSpace,
      ],
    ).paddingHorizontal(14.w);
  }

  _buildReportContentView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.reportList.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return _buildReportListItemView(index);
            },
          ),
          20.verticalSpace,
          AppBgView(
            backgroundColor: COLOR.color_EEEEEE,
            padding: EdgeInsets.all(12.w),
            child: TextField(
              maxLines: 6,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: '请填写举报理由，200字以内',
                hintStyle: TextStyle(
                  fontSize: 14.w,
                  color: COLOR.color_999999,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          20.verticalSpace,
          Row(
            children: [
              TextView(
                text: "上传图片",
                fontSize: 14.w,
                color: COLOR.color_333333,
                fontWeight: FontWeight.w500,
              ),
              TextView(
                text: "（最多可上传3张）",
                fontSize: 12.w,
                color: COLOR.color_999999,
              ),
            ],
          ),
          18.verticalSpace,

          ///
          Obx(() {
            final width = 104.w;
            final height = 104.w;
            final List<Widget> children = [];
            children.addAll(
              controller.pickedImages.map(
                (e) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: Styles.borderRadius.all(4.w),
                      child: Image.memory(
                        e.item1,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: -7.w,
                      right: -7.w,
                      child: Image.asset(
                        AppImagePath.community_complaint_remove_pick_image,
                        width: 20.w,
                        height: 20.w,
                      ).onOpaqueTap(() {
                        controller.pickedImages.remove(e);
                      }),
                    )
                  ],
                ),
              ),
            );
            if (children.length < controller.maxImage) {
              children.add(_buildImagePicker());
            }
            return Row(children: children.joinWidth(10.w));
          }),
          30.verticalSpace,
        ],
      ),
    );
  }

  _buildReportListItemView(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 60.w,
          child: Obx(
            () => Row(
              children: [
                TextView(
                  text: controller.reportList[index].item1,
                  color: COLOR.color_333333,
                  fontSize: 14.w,
                ),
                const Spacer(),
                Icon(
                  controller.checkedIndex.value == index
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_off_outlined,
                  color: controller.checkedIndex.value == index
                      ? COLOR.color_FB2D45
                      : COLOR.color_999999.withOpacity(0.5),
                  size: 20.w,
                ),
              ],
            ),
          ).onOpaqueTap(() {
            controller.checkedIndex.value = index;
          }),
        ),
        Divider(
          height: 1.w,
          color: COLOR.color_999999,
          thickness: 0,
        )
      ],
    );
  }

  Widget _buildImagePicker() => Container(
        decoration: BoxDecoration(
          color: COLOR.color_EEEEEE,
          borderRadius: Styles.borderRadius.all(4.w),
        ),
        width: 104.w,
        height: 104.w,
        alignment: Alignment.center,
        child: Image.asset(
          AppImagePath.community_complaint_plus,
          width: 24.w,
          height: 24.w,
        ),
      ).onOpaqueTap(controller.onTapPickImage);

  _buildSubmitButtonView() {
    return AppBgView(
      height: 40.w,
      radius: 20.w,
      backgroundColor: COLOR.color_FB2D45,
      text: '提交',
      textColor: COLOR.white,
      textSize: 14.w,
      onTap: controller.onSubmit,
    );
  }
}
