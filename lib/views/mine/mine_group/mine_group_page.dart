/*
 * @Author: wangdazhuang
 * @Date: 2025-03-03 13:53:46
 * @LastEditTime: 2025-03-04 17:18:38
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/mine/mine_group/mine_group_page.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/mine/official_community_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../utils/ad_jump.dart';
import 'mine_group_page_controller.dart';

class MineGroupPage extends GetView<MineGroupPageController> {
  const MineGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: AppBarView(titleText: "加群开车"),
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.only(
            left: 48.w,
            right: 48.w,
            top: 65.w,
          ),
          itemCount: controller.ocLists.length,
          itemBuilder: (context, index) {
            OfficialCommunityModel item = controller.ocLists[index];
            return Container(
              width: 264.w,
              height: 57.w,
              alignment: Alignment.center,
              child: ImageView(
                      src: AppImagePath.mine_icon_telegram,
                      width: 264.w,
                      height: 57.w)
                  .onOpaqueTap(
                      () => jumpExternalAddress(item.link ?? "", null)),
            ).marginBottom(25.w);
          },
        ),
      ),
    );
  }
}
