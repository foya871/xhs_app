import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_upload/image_upload.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/extension.dart';
import '../../../assets/colorx.dart';
import '../../../utils/color.dart';
import '../frontpage/controller/edit_userinfo_controller.dart';
import 'edit_user_head_page.dart';

///编辑资料
class EditUserInfoPage extends GetView<EditUserInfoController> {
  const EditUserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: COLOR.color_FAFAFA,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text("修改资料",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorX.color_333333,
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                )),
            centerTitle: true,
            // actions: [
            //   Container(
            //     padding: EdgeInsets.only(right: 16.w),
            //     child: Text("确认",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           color: Colors.white70,
            //           fontSize: 14.w,
            //           fontWeight: FontWeight.w600,
            //         )).onTap(() => controller.onClick("确认")),
            //   ),
            // ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.w),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EditUserHeadPage(),
                  SizedBox(height: 20.w),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 14.w, right: 14),
                    child: Row(
                      children: [
                        Text(
                          "昵称",
                          style: TextStyle(
                            fontSize: 14.w,
                            color: ColorX.color_333333,
                          ),
                        ).marginOnly(right: 16.w),
                        Expanded(
                          child: TextField(
                            controller: controller.nameController,
                            focusNode: controller.nameNode,
                            style: TextStyle(
                              fontSize: 13.w,
                              color: ColorX.color_333333,
                            ),
                            decoration: InputDecoration(
                              hintText: "用户名最多8个字",
                              hintStyle: TextStyle(
                                fontSize: 13.w,
                                color: COLOR.hexColor('#666666'),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: COLOR.hexColor('#d3d4dc'),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: COLOR.hexColor('#d3d4dc'),
                                ),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: COLOR.hexColor('#d3d4dc'),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 29.w),
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(left: 14.w, right: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "签名",
                          style: TextStyle(
                            fontSize: 14.w,
                            color: ColorX.color_333333,
                          ),
                        ).marginOnly(right: 16.w),
                        Expanded(
                          child: Container(
                            width: 290.w,
                            height: 120.w,
                            padding: EdgeInsets.only(left: 14.w, top: 14.w),
                            decoration: BoxDecoration(
                              color: COLOR.hexColor('#EEEEEE'),
                              borderRadius: BorderRadius.circular(6.w),
                            ),
                            child: TextField(
                              controller: controller.signController,
                              focusNode: controller.signNode,
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 13.w,
                                color: ColorX.color_333333,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: "填写个性签名",
                                hintStyle: TextStyle(
                                  fontSize: 13.w,
                                  color: COLOR.hexColor('#666666'),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.w),
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(left: 14.w, right: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "背景图",
                          style: TextStyle(
                            fontSize: 14.w,
                            color: ColorX.color_333333,
                          ),
                        ).marginOnly(right: 16.w),
                        ImageUpload(
                          limit: 1,
                          success: (images) {
                            if (images != null && images.length > 0) {
                              controller.bgCoverImage.value = images.first;
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: 332.w,
            height: 40.w,
            margin: EdgeInsets.only(
                bottom: 16.w + ScreenUtil().bottomBarHeight,
                left: 14.w,
                right: 14.w),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImagePath.mine_icon_big_button),
              ),
            ),
            child: TextView(
              text: "保存",
              fontSize: 14.w,
              fontWeight: FontWeight.w500,
              color: COLOR.white,
            ),
          ).onOpaqueTap(() {
            controller.onClick("确认");
          }),
        )
      ],
    );
  }
}
