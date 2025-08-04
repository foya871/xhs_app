import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/community/collection_base_model.dart';
import 'package:xhs_app/utils/color.dart';

import 'collection_page_controller.dart';

class CollectionPage extends GetView<CollectionPageController> {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_F9F9F9,
      appBar: AppBar(
        backgroundColor: COLOR.white,
        title: const Text("TA的合集"),
      ),
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return Padding(
      padding: EdgeInsets.all(14.w),
      child: EasyRefresh(
        controller: controller.easyRefreshController,
        child: Obx(() => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: controller.collectionList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildGroupItemView(controller.collectionList[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return 8.verticalSpace;
              },
            )),
      ),
    );
  }

  _buildGroupItemView(CollectionBaseModel item) {
    return AppBgView(
      height: 72.w,
      backgroundColor: COLOR.white,
      radius: 8.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          ImageView(
            src: item.collectionCoverImg ?? "",
            width: 48.w,
            height: 48.w,
            borderRadius: BorderRadius.circular(5.w),
            defaultPlace: AppImagePath.icon_avatar,
          ),
          8.horizontalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: item.collectionName ?? "",
                fontSize: 13.w,
                color: COLOR.color_333333,
                fontWeight: FontWeight.w500,
              ),
              3.verticalSpace,
              TextView(
                text: "收录${item.dynamicNum ?? 0}个笔记",
                fontSize: 12.w,
                color: COLOR.color_999999,
              ),
            ],
          ),
          const Spacer(),
          8.horizontalSpace,
          TextView(text: "详情", fontSize: 13.w, color: COLOR.color_999999),
          3.horizontalSpace,
          Icon(Icons.arrow_forward_ios, size: 12.w, color: COLOR.color_999999),
        ],
      ),
    );
  }
}
