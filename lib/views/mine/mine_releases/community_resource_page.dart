/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-28 12:53:33
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-03 21:21:17
 * @FilePath: /xhs_app/lib/views/mine/mine_releases/community_resource_page.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/image_upload/image_upload.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../components/text_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../utils/color.dart';
import 'community_classify_list_page.dart';
import 'community_release_page_controller.dart';
import 'community_resource_page_controller.dart';

class CommunityResourcePage extends StatefulWidget {
  const CommunityResourcePage({
    super.key,
  });

  @override
  State createState() => _CommunityReleasePageState();
}

class _CommunityReleasePageState extends State<CommunityResourcePage> {
  final controller = Get.put(CommunityResourcePageController());
  var names = <String>[].obs;

  @override
  void dispose() {
    Get.delete<CommunityReleasePageController>();
    super.dispose();
  }

  void success(List<String> images) {
    controller.addImages(images);
  }

  @override
  void initState() {
    onPageLoad();
    super.initState();
  }

  onPageLoad() {
    controller.getResourcesClassifyList();
  }

  _buildAppBar() {
    return AppBarView(
      titleText: "发布资源",
    );
  }

  ///分类
  Widget _buildClassify() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Text(
                  '#选择分类',
                  style: TextStyle(
                    color: COLOR.color_333333,
                    fontSize: 15.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '（必填）',
                  style: TextStyle(
                    color: COLOR.color_999999,
                    fontSize: 13.w,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  '更多',
                  style: TextStyle(
                    color: COLOR.color_999999,
                    fontSize: 12.w,
                  ),
                ).marginOnly(right: 5.w),
              ],
            ).onOpaqueTap(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CommunityClassifyListPage(
                        selectedTopicModels: [controller.currentClassify.value],
                        chooseType: 2)),
              ).then((value) {
                if (value != null && value.isNotEmpty) {
                  controller.communityRelease.value.classifyTitle =
                      value[0].classifyTitle;
                } else {
                  controller.communityRelease.value.classifyTitle = "";
                }
                setState(() {});
              });
            })
          ],
        ),
        SizedBox(
            height: 30.w,
            width: 332.w,
            child: Obx(() => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.classifyItems.length,
                itemBuilder: (context, index) {
                  var value = controller.classifyItems[index];
                  return Container(
                    height: 30.w,
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller
                                        .communityRelease.value.classifyTitle ==
                                    value.classifyTitle
                                ? COLOR.hexColor("#f52d45")
                                : COLOR.hexColor("#eee"),
                            width: 1),
                        borderRadius: BorderRadius.circular(16.w)),
                    child: Text(
                      value.classifyTitle,
                      style: TextStyle(
                        color:
                            controller.communityRelease.value.classifyTitle ==
                                    value.classifyTitle
                                ? COLOR.hexColor("#f52d45")
                                : COLOR.hexColor("#666666"),
                        fontSize: 13.w,
                      ),
                    ),
                  ).onOpaqueTap(() {
                    controller.communityRelease.value.classifyTitle =
                        value.classifyTitle;
                    setState(() {});
                  });
                }))).marginOnly(top: 12.w),
      ],
    ).marginTop(12.w);
  }

  Widget _buildPrice() {
    return Container(
      width: 332.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: COLOR.color_EEEEEE,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: TextField(
        focusNode: controller.priceFocusNode,
        controller: controller.priceEditingController,
        maxLines: 1,
        maxLength: 1,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          controller.moneyInputFormatter,
          LengthLimitingTextInputFormatter(2),
        ],
        style: TextStyle(
          color: COLOR.color_B940FF,
          fontSize: 12.w,
        ),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.w, horizontal: 12.w),
          hintText: '请设置视频价格0-20金币，不设置则免费',
          counterText: '',
          hintStyle: TextStyle(
            color: COLOR.color_999999,
            fontSize: 13.w,
          ),
          border: InputBorder.none,
          prefixText: '¥',
        ),
        onChanged: (text) {
          if (text.isNotEmpty) {
            controller.communityRelease.value.price =
                double.tryParse(text) ?? 0.0;
          }
        },
      ),
    ).marginOnly(top: 10.w);
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 332.w,
          height: 74.w,
          decoration: BoxDecoration(
            color: COLOR.color_EEEEEE,
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: TextField(
            focusNode: controller.focusNode,
            controller: controller.titleEditingController,
            maxLines: null,
            maxLength: controller.maxLength,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              color: COLOR.color_333333,
              fontSize: 13.w,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
              hintText: '请填写标题（必填）',
              counterText: '',
              hintStyle: TextStyle(
                color: COLOR.color_999999,
                fontSize: 13.w,
              ),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              controller.communityRelease.value.resourcesTitle = text;
              setState(() {});
            },
          ),
        ),
        Container(
          width: 332.w,
          height: 260.w,
          decoration: BoxDecoration(
            color: COLOR.color_EEEEEE,
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: TextField(
            focusNode: controller.infoNode,
            controller: controller.infoEditingController,
            maxLines: null,
            maxLength: controller.maxLength,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              color: COLOR.color_333333,
              fontSize: 13.w,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
              hintText: '请输入内容（选填）',
              counterText: '',
              hintStyle: TextStyle(
                color: COLOR.color_999999,
                fontSize: 13.w,
              ),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              controller.communityRelease.value.info = text;
              setState(() {});
            },
          ),
        ).marginOnly(top: 10.w),
      ],
    ).marginOnly(top: 20.w);
  }

  Widget _buildResource() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              '填写资源链接',
              style: TextStyle(
                color: COLOR.color_333333,
                fontSize: 15.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Container(
          width: 332.w,
          height: 74.w,
          decoration: BoxDecoration(
            color: COLOR.color_EEEEEE,
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: TextField(
            focusNode: controller.websiteNode,
            controller: controller.websiteController,
            maxLines: null,
            maxLength: controller.maxLength,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              color: COLOR.color_333333,
              fontSize: 13.w,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
              hintText: '请输入资源下载链接',
              counterText: '',
              hintStyle: TextStyle(
                color: COLOR.color_999999,
                fontSize: 13.w,
              ),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              controller.communityRelease.value.website = text;
              setState(() {});
            },
          ),
        ).marginOnly(top: 10.w),
        Row(
          children: [
            Text(
              '填写提取码',
              style: TextStyle(
                color: COLOR.color_333333,
                fontSize: 15.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ).marginOnly(top: 20.w, bottom: 10.w),
        Container(
          width: 332.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: COLOR.color_EEEEEE,
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: TextField(
            focusNode: controller.passwordNode,
            controller: controller.passwordController,
            maxLines: null,
            maxLength: controller.maxLength,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: COLOR.color_333333,
              fontSize: 13.w,
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
              hintText: '请输入资源提取码',
              counterText: '',
              hintStyle: TextStyle(
                color: COLOR.color_999999,
                fontSize: 13.w,
              ),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              controller.communityRelease.value.decompressPassword = text;
              setState(() {});
            },
          ),
        ),
      ],
    ).marginOnly(top: 20.w);
  }

  Widget _buildReleaseImageView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '上传图片',
              style: TextStyle(
                color: COLOR.color_333333,
                fontSize: 15.w,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '（最多上传9张，每张最大1M，默认第一张为封面）',
              style: TextStyle(
                color: COLOR.color_999999,
                fontSize: 11.w,
              ),
            ).marginOnly(left: 7.w),
          ],
        ),
        ImageUpload(
          success: (v) {
            success(v);
          },
        ).marginOnly(top: 10.w),
      ],
    ).marginOnly(top: 20.w);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityResourcePageController>(
        assignId: true,
        builder: (_) {
          return Scaffold(
            appBar: _buildAppBar(),
            backgroundColor: COLOR.color_FAFAFA,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        _buildTitle().sliver,
                        if (controller.us.user.blogger == true)
                          _buildPrice().sliver,
                        _buildClassify().sliver,
                        _buildResource().sliver,
                        _buildReleaseImageView().sliver,
                      ],
                    ).marginOnly(left: 14.w, right: 14.w),
                  ),
                  Container(
                    width: 332.w,
                    height: 40.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImagePath.mine_big_button),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: TextView(
                      text: "提交",
                      color: COLOR.white,
                      fontSize: 14.w,
                    ),
                  ).onOpaqueTap(
                    () async {
                      await controller.release();
                    },
                  ),
                ],
              ),
            ).onOpaqueTap(() {
              FocusManager.instance.primaryFocus?.unfocus();
            }),
          );
        });
  }
}
