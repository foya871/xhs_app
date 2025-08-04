import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/text_field_view.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/group_chat/create_groupchat_page_controller.dart';

import '../../../assets/styles.dart';
import '../../../components/text_view.dart';
import '../../../model/mine/group_classification_model.dart';
import '../../../utils/color.dart';

class CreateGroupChatPage extends StatefulWidget{
  const CreateGroupChatPage({super.key});

  @override
  State<CreateGroupChatPage> createState() => _CreateGroupChatPageState();

}

class _CreateGroupChatPageState extends State<CreateGroupChatPage> {
  final controller = Get.find<CreateGroupChatPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.color.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextView(
          text: "创建群聊",
          textAlign: TextAlign.center,
          fontSize: 16.w,
          color: COLOR.color_333333,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        shadowColor: COLOR.color_EEEEEE,
      ),
      body: _bodyViews(),
    );
  }

  _bodyViews() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(text: "群名称", fontSize: 15.w, color: COLOR.color_333333),
            SizedBox(height: 10.w),
            Container(
              width: double.infinity,
              height: 44.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.w),
                color: COLOR.color_EEEEEE,
              ),
              child: TextFieldView(
                controller: controller.groupNameController,
                hintText: "请输入群名称(限制12字以内)",
                hintTextStyle: TextStyle(
                  fontSize: 13.w,
                  color: COLOR.color_999999,
                ),
                textColor: COLOR.color_333333,
                fontSize: 13.w,
                maxLength: 12,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 13.w),
                counterText: "",
              ),
            ),
            SizedBox(height: 20.w),
            TextView(text: "群简介", fontSize: 15.w, color: COLOR.color_333333),
            SizedBox(height: 10.w),
            Container(
              width: double.infinity,
              height: 160.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.w),
                color: COLOR.color_EEEEEE,
              ),
              child: TextFieldView(
                controller: controller.groupIntroductionController,
                hintText: "用一段介绍你的群(限制100字以内)",
                hintTextStyle: TextStyle(
                  fontSize: 13.w,
                  color: COLOR.color_999999,
                ),
                textColor: COLOR.color_333333,
                fontSize: 13.w,
                maxLength: 100,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.w),
                counterText: "",
              ),
            ),
            SizedBox(height: 20.w),
            TextView(text: "群聊类型", fontSize: 15.w, color: COLOR.color_333333),
            SizedBox(height: 10.w),
            Obx(
              () => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 8,
                    childAspectRatio: 106 / 38,
                  ),
                  itemCount: controller.groupClass.length,
                  itemBuilder: (context, index) {
                    return itemGroupClass(controller.groupClass[index], index);
                  }),
            ),
            SizedBox(height: 120.w),
            Container(
              width: double.infinity,
              height: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.w),
                color: COLOR.color_FB2D45,
              ),
              child: Center(
                child: TextView(text: "50金币创建", fontSize: 14.w, color: Colors.white),
              ),
            ).onTap(() => controller.createGroup()),
          ],
        ),
      ),
    );
  }

  itemGroupClass(GroupClassificationModel model, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.w),
        color: model.check == true ? COLOR.hexColor("#1afb2d45") : COLOR.color_EEEEEE,
      ),
      child: Center(
        child: TextView(
            text: model.name ?? "",
            fontSize: 13,
            color:
                model.check == true ? COLOR.color_FB2D45 : COLOR.color_666666),
      ),
    ).onTap((){
      controller.changeCheck(index);
      setState(() {});
    });
  }
}
