import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/views/mine/frontpage/controller/retrieve_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../assets/styles.dart';
import '../../../routes/routes.dart';
import '../../../utils/color.dart';

class MineRetrieveAccount extends StatelessWidget {
  const MineRetrieveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = COLOR.color_FAFAFA;

    Future<void> onRetrieveClick(RetrieveAccountController controller) async {
      var data = await Get.toNamed(Routes.scannercode);
      if (data != null) {
        controller.identifyTheQRCode(data);
      }
    }

    void onClick(int index) {
      switch (index) {
        case 1:
          Navigator.pop(context);
          break;
        case 3:
          kOnLineService();
          break;
      }
    }

    return Scaffold(
        backgroundColor: COLOR.color_FAFAFA,
        appBar: AppBar(
          leading: IconButton(
            iconSize: 20.w,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: COLOR.color_333333,
            ),
            onPressed: () => onClick(1),
          ),
          title: Text("找回账号",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: COLOR.color_333333,
                fontSize: 17.w,
                fontWeight: FontWeight.w500,
              )),
          centerTitle: true,
        ),
        body: GetBuilder<RetrieveAccountController>(
            init: RetrieveAccountController(),
            builder: (controller) {
              return Container(
                padding: EdgeInsets.only(top: 32.w, left: 14.w, right: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      highlightColor: bgColor,
                      splashColor: bgColor,
                      onTap: () => onRetrieveClick(controller),
                      child: _buildContent('账号凭证找回'),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 23)),
                    InkWell(
                      highlightColor: bgColor,
                      splashColor: bgColor,
                      onTap: () => onClick(3),
                      child: _buildContent('联系客服找回'),
                    ),
                  ],
                ),
              );
            }));
  }

  Widget _buildContent(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.w,
                  color: COLOR.color_333333,
                ),
              ),
            ),
            ImageView(
              src: AppImagePath.icons_icon_right,
              width: 6.w,
              height: 10.w,
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 16.w)),
        Container(
          width: double.maxFinite,
          height: 1,
          color: COLOR.hexColor('#f0f0f0'),
        ),
      ],
    );
  }
}
