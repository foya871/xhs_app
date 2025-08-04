import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/grid_view/heighted_grid_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';

import 'share_record_page_controller.dart';

class ShareRecordPage extends GetView<ShareRecordPageController> {
  const ShareRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: _buildAppBar(),
      body: _buildBodyView(),
    );
  }

  _buildAppBar() {
    return AppBarView(
      titleText: "我的推广",
    );
  }

  Widget _buildBodyView() {
    return BaseRefreshWidget(controller,
        child: CustomScrollView(
          slivers: [
            Container(
              width: 360.w,
              height: 54.w,
              margin: EdgeInsets.only(bottom: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
         color: COLOR.color_EEEEEE,
              child: Row(
                children: [
       
                  TextView(
                    text: "我的推广人数：",
                    style: kTextStyle(COLOR.color_333333,
                        fontsize: 14.w, weight: FontWeight.w600),
                  ),
                  Obx(() => TextView(
                        text: "${controller.total.value}",
                        style: kTextStyle(COLOR.color_faa06a,
                            fontsize: 16.w, weight: FontWeight.w600),
                      ))
                ],
              ),
            ).sliverBox,
            HeightedGridView.sliver(
              rowSepratorBuilder: (context, index) {
                return Container(
                  height: 1.w,
                  width: double.infinity,
                  color: COLOR.hexColor("#F0F0F0"),
                ).marginHorizontal(10.w);
              },
              crossAxisCount: 1,
              itemCount: controller.list.length,
              itemBuilder: (context, index) {
                final item = controller.list[index];
                return Container(
                  // margin: EdgeInsets.only(bottom: 20.w),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                                 ImageView(src: item.logo??"",width: 50.w,height: 50.w,borderRadius: BorderRadius.circular(25.w),),
                      TextView(text: "${item.nickName}",fontSize: 14.w,color: COLOR.color_333333,fontWeight: FontWeight.w600,),
                      TextView(
                        text: Utils.dateFmt(item.createdAt ?? '',
                            const ['yyyy', '-', 'mm', '-', 'dd']),
                            fontSize: 14.w,color: COLOR.color_999999,fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ).marginHorizontal(16.w);
              },
            )
          ],
        ));
  }
}
