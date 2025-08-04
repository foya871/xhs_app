import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/components/image_upload/image_upload.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../generate/app_image_path.dart';
import '../../../utils/color.dart';
import 'mine_release_collection_controller.dart';

class MineCreateCollectionPage
    extends GetView<MineReleaseCollectionController> {
  const MineCreateCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: AppBarView(
        titleText: "作品中心",
      ),
      body: Stack(
        children: [
          _bodyView(),
          Positioned(
              bottom: 14.w + ScreenUtil().bottomBarHeight,
              left: 14.w,
              right: 14.w,
              child: Container(
                width: 332.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(AppImagePath.mine_big_button)),
                    borderRadius: BorderRadius.circular(10.w)),
                child: TextView(
                  text: "确定",
                  fontSize: 14.w,
                  color: COLOR.white,
                ),
              ).onTap(() async {
                if (controller.collectionName.value.isEmpty) {
                  EasyToast.show("请输入合集名称");
                  return;
                }
                if (controller.collectionCoverImg.value.isEmpty) {
                  EasyToast.show("请选择合集封面");
                  return;
                }
                var r = await controller.addBloggerCollection();
                if (r == true) {
                  Get.back();
                }
              }))
        ],
      ),
    );
  }

  _bodyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextView(
              text: "合集名称",
              style: kTextStyle(COLOR.color_333333,
                  fontsize: 16.w, weight: FontWeight.w500),
            ),
            TextView(
              text: "（标题要与上传的合集视频内容相符）",
              style: kTextStyle(
                COLOR.color_B0B0B0,
                fontsize: 11.w,
              ),
            )
          ],
        ),
        Container(
          width: 332.w,
          height: 44.w,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.w),
              color: COLOR.color_EEEEEE),
          child: TextFormField(
            controller: controller.collectionNameController,
            inputFormatters: [LengthLimitingTextInputFormatter(12)],
            onChanged: (value) {
              controller.collectionName.value = value;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "请输入合集名称",
              hintStyle: TextStyle(color: COLOR.color_999999, fontSize: 13.w),
              contentPadding: EdgeInsets.symmetric(horizontal: 14),
            ),
          ),
        ),
        TextView(
          text: "合集名称",
          style: kTextStyle(COLOR.color_333333,
              fontsize: 16.w, weight: FontWeight.w500),
        ).marginOnly(top: 20.w, bottom: 10.w),
        ImageUpload(
          limit: 1,
          success: (images) {
            if (images != null && images.length > 0) {
              controller.collectionCoverImg.value = images.first;
            }
          },
        )
      ],
    ).marginOnly(top: 12.w, left: 14.w, right: 14.w);
  }
}
