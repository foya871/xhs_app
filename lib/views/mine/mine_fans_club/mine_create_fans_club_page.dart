import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/components/image_upload/image_upload.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import 'mine_fans_club_page_controller.dart';

class MineCreateFansClubPage extends StatefulWidget {
  const MineCreateFansClubPage({super.key});

  @override
  State<MineCreateFansClubPage> createState() => _MineCreateFansClubPageState();
}

class _MineCreateFansClubPageState extends State<MineCreateFansClubPage> {
  final controller = Get.find<MineFansClubPageController>();

  int? id;
  @override
  void initState() {
    super.initState();
    if (controller.blogger.value.groupId != null &&
        controller.blogger.value.groupId != 0) {
      controller.groupAnnoController.text =
          controller.blogger.value.groupAnno ?? "";
      controller.nameController.text = controller.blogger.value.groupName ?? "";
      controller.coverImg.value = controller.blogger.value.coverImg ?? "";
      controller.monthPriceController.text =
          controller.blogger.value.monthTicketPrice?.toString() ?? "";
      controller.seasonPriceController.text =
          controller.blogger.value.seasonTicketPrice?.toString() ?? "";
      controller.yearPriceController.text =
          controller.blogger.value.yearTicketPrice?.toString() ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineFansClubPageController>(builder: (_) {
      return Stack(children: [
        Scaffold(
          backgroundColor: COLOR.color_FAFAFA,
          appBar: AppBarView(
            titleText: controller.blogger.value.groupId == null ||
                    controller.blogger.value.groupId == 0
                ? "创建私人团"
                : "编辑私人团",
          ),
          body: _buildBody(),
        ),
        Positioned(
            bottom: 0,
            left: 14.w,
            right: 14.w,
            child: Container(
              padding: EdgeInsets.only(top: 16.w),
              color: COLOR.color_FAFAFA,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: "什么是粉丝团",
                        fontSize: 11.w,
                        fontWeight: FontWeight.w400,
                        color: COLOR.hexColor("#b0b0b0"),
                      ),
                      TextView(
                        text: "《创建规则》",
                        fontSize: 11.w,
                        fontWeight: FontWeight.w400,
                        color: COLOR.hexColor("#fb2d45"),
                      ).onOpaqueTap(() {
                        Get.toNamed(Routes.minefansclubrule);
                      }),
                    ],
                  ),
                  Container(
                    width: 332.w,
                    height: 40.w,
                    margin: EdgeInsets.only(
                        bottom: 16.w + ScreenUtil().bottomBarHeight, top: 10.w),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImagePath.mine_icon_big_button),
                      ),
                    ),
                    child: Obx(() => TextView(
                          text: controller.blogger.value.groupId == null ||
                                  controller.blogger.value.groupId == 0
                              ? "${controller.monthPrice.value}金币创建"
                              : "确定",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                          color: COLOR.white,
                        )),
                  ).onOpaqueTap(() async {
                    if (controller.nameController.text.isEmpty) {
                      EasyToast.show('请输入私人团名称');
                      return;
                    }
                    if (controller.groupAnnoController.text.isEmpty) {
                      EasyToast.show('请输入私人团公告');
                      return;
                    }
                    if (controller.coverImg.isEmpty) {
                      EasyToast.show('请上传私人团背景');
                      return;
                    }
                    if (controller.monthPriceController.text.isEmpty) {
                      EasyToast.show('请输入私人团月票价格');
                      return;
                    }
                    if (controller.seasonPriceController.text.isEmpty) {
                      EasyToast.show('请输入私人团季票价格');
                      return;
                    }
                    if (controller.yearPriceController.text.isEmpty) {
                      EasyToast.show('请输入私人团年票价格');
                      return;
                    }
                    if (controller.blogger.value.groupId == null ||
                        controller.blogger.value.groupId == 0) {
                      var r = await controller.createGroup();
                      if (r == true) {
                        Get.back();
                      }
                    } else {
                      var r = await controller.updateGroup();
                      if (r == true) {
                        Get.back();
                      }
                    }
                  })
                ],
              ),
            ))
      ]);
    });
  }

  _buildBody() {
    return GetBuilder<MineFansClubPageController>(
      builder: (_) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.w),
                child: TextView(
                  text: "私人团名称",
                  fontSize: 15.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.hexColor("#333333"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.w),
                width: 332.w,
                height: 44.w,
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                decoration: BoxDecoration(
                  color: COLOR.color_EEEEEE,
                  borderRadius: BorderRadius.circular(6.w),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: controller.nameController,
                      maxLines: 1,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      focusNode: controller.nameNode,
                      onChanged: (value) {
                        controller.nameController.text = value;
                        setState(() {});
                      },
                      style: TextStyle(
                        fontSize: 13.w,
                        fontWeight: FontWeight.w400,
                        color: COLOR.hexColor("#333333"),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "请输入私人团名称",
                        hintStyle: TextStyle(
                          fontSize: 13.w,
                          fontWeight: FontWeight.w400,
                          color: COLOR.hexColor("#999999"),
                        ),
                      ),
                    )),
                    TextView(
                      text: "${controller.nameController.text.length}/12",
                      fontSize: 13.w,
                      fontWeight: FontWeight.w400,
                      color: COLOR.hexColor("#999999"),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.w),
                child: TextView(
                  text: "私人团公告",
                  fontSize: 15.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.hexColor("#333333"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.w),
                width: 332.w,
                height: 160.w,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                decoration: BoxDecoration(
                  color: COLOR.color_EEEEEE,
                  borderRadius: BorderRadius.circular(6.w),
                ),
                child: TextFormField(
                  controller: controller.groupAnnoController,
                  focusNode: controller.groupAnnoNode,
                  style: TextStyle(
                    fontSize: 13.w,
                    fontWeight: FontWeight.w400,
                    color: COLOR.hexColor("#333333"),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入私人团公告",
                    hintStyle: TextStyle(
                      fontSize: 13.w,
                      fontWeight: FontWeight.w400,
                      color: COLOR.hexColor("#999999"),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.w, bottom: 10.w),
                child: TextView(
                  text: "私人团背景",
                  fontSize: 15.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.hexColor("#333333"),
                ),
              ),
              ImageUpload(
                limit: 1,
                success: (value) {
                  if (value != null) {
                    controller.coverImg.value = value[0];
                    setState(() {});
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 20.w),
                child: TextView(
                  text: "设置票价",
                  fontSize: 15.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.hexColor("#333333"),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      ImageView(
                        src: AppImagePath.mine_icon_month_card,
                        width: 50.w,
                        height: 50.w,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      TextView(
                        text: "粉丝团月票",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: COLOR.hexColor("#333333"),
                      ).marginOnly(left: 10.w, right: 40.w),
                      Container(
                        width: 160.w,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          color: COLOR.color_EEEEEE,
                        ),
                        child: TextFormField(
                          controller: controller.monthPriceController,
                          focusNode: controller.monthPriceNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                          style: TextStyle(
                            fontSize: 13.w,
                            fontWeight: FontWeight.w400,
                            color: COLOR.hexColor("#333333"),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 4),
                            hintText: "设置大于30金币",
                            hintStyle: TextStyle(
                              fontSize: 13.w,
                              fontWeight: FontWeight.w400,
                              color: COLOR.hexColor("#999999"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ).marginOnly(top: 20.w, bottom: 20.w),
                  Row(
                    children: [
                      ImageView(
                        src: AppImagePath.mine_icon_ji_card,
                        width: 50.w,
                        height: 50.w,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      TextView(
                        text: "粉丝团季票",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: COLOR.hexColor("#333333"),
                      ).marginOnly(left: 10.w, right: 40.w),
                      Container(
                        width: 160.w,
                        height: 40.w,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          color: COLOR.color_EEEEEE,
                        ),
                        child: TextFormField(
                          controller: controller.seasonPriceController,
                          focusNode: controller.seasonPriceNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                          style: TextStyle(
                            fontSize: 13.w,
                            fontWeight: FontWeight.w400,
                            color: COLOR.hexColor("#333333"),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 4),
                            hintText: "设置大于60金币",
                            hintStyle: TextStyle(
                              fontSize: 13.w,
                              fontWeight: FontWeight.w400,
                              color: COLOR.hexColor("#999999"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ).marginOnly(bottom: 20.w),
                  Row(
                    children: [
                      ImageView(
                        src: AppImagePath.mine_icon_year_card,
                        width: 50.w,
                        height: 50.w,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      TextView(
                        text: "粉丝团年票",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: COLOR.hexColor("#333333"),
                      ).marginOnly(left: 10.w, right: 40.w),
                      Container(
                        width: 160.w,
                        height: 40.w,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          color: COLOR.color_EEEEEE,
                        ),
                        child: TextFormField(
                          controller: controller.yearPriceController,
                          focusNode: controller.yearPriceNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                          style: TextStyle(
                            fontSize: 13.w,
                            fontWeight: FontWeight.w400,
                            color: COLOR.hexColor("#333333"),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 4),
                            hintText: "设置大于110金币",
                            hintStyle: TextStyle(
                              fontSize: 13.w,
                              fontWeight: FontWeight.w400,
                              color: COLOR.hexColor("#999999"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ).marginOnly(bottom: 20.w)
                ],
              ),
              Container(
                height: 100.w,
              ),
            ],
          ).marginOnly(left: 14.w, right: 14.w),
        );
      },
    );
  }
}
