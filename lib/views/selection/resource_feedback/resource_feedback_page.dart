import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/widget_utils.dart';

import '../../../assets/colorx.dart';
import 'resource_feedback_logic.dart';
import 'resource_feedback_state.dart';

class ResourceFeedbackPage extends StatefulWidget {
  const ResourceFeedbackPage({Key? key}) : super(key: key);

  @override
  State<ResourceFeedbackPage> createState() => _ResourceFeedbackPageState();
}

class _ResourceFeedbackPageState extends State<ResourceFeedbackPage> {
  final ResourceFeedbackLogic logic = Get.put(ResourceFeedbackLogic());
  final ResourceFeedbackState state = Get.find<ResourceFeedbackLogic>().state;

  @override
  void dispose() {
    Get.delete<ResourceFeedbackLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "资源反馈",
          style: TextStyle(
              fontSize: 17.w,
              color: ColorX.color_333333,
              fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: ColorX.color_FaFaFa,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///1-下载链接已失效、2-提取码错误、3-下载后资源不可用 4-其它反馈
            Obx(() {
              return buildRadioTile(1, "下载链接已失效");
            }),
            Divider(
              color: ColorX.color_eeeeee,
              height: 1.h,
              indent: 15.w,
              endIndent: 15.w,
            ),
            Obx(() {
              return buildRadioTile(2, "提取码错误");
            }),
            Divider(
              color: ColorX.color_eeeeee,
              height: 1.h,
              indent: 15.w,
              endIndent: 15.w,
            ),
            Obx(() {
              return buildRadioTile(3, "下载后资源不可用");
            }),
            Divider(
              color: ColorX.color_eeeeee,
              height: 1.h,
              indent: 15.w,
              endIndent: 15.w,
            ),
            ListTile(
              title: Text(
                "其它反馈",
                style: TextStyle(fontSize: 14.w, color: ColorX.color_333333),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Obx(() {
                  return WidgetUtils.buildTextField(
                      null, 160.h, 14.w, ColorX.color_333333, "请输入反馈内容",
                      hintColor: ColorX.color_999999,
                      controller: state.textController,
                      enabled: state.selectItem.value == 4,
                      maxLines: 8,
                      maxLength: 200,
                      backgroundColor: ColorX.color_eeeeee,
                      borderRadius: BorderRadius.circular(5.r),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h));
                }),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            WidgetUtils.buildElevatedButton("提交", 332.w, 35.h,
                backgroundColor: ColorX.color_fb2d45,
                textColor: Colors.white,
                textSize: 14,
                borderRadius: BorderRadius.circular(20.r),
                onPressed: () => logic.submitReport()),
          ],
        ),
      ),
    );
  }

  Widget buildRadioTile(int index, String title) {
    return GestureDetector(
      onTap: () {
        if (state.selectItem.value == index) {
          state.selectItem.value = 4;
        } else {
          state.selectItem.value = index;
        }
        state.textController.text = title;
      },
      child: Container(
        height: 40.h,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14.w, color: ColorX.color_333333),
            ),
            if (state.selectItem.value == index)
              Image.asset(
                AppImagePath.community_complaint_check_y,
                width: 20.r,
                height: 20.r,
              )
            else
              Image.asset(
                AppImagePath.community_complaint_check,
                width: 20.r,
                height: 20.r,
              )
          ],
        ),
      ),
    );
  }
}
