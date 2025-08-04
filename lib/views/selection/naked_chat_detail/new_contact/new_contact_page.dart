import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/colorx.dart';
import '../../../../utils/widget_utils.dart';
import 'new_contact_logic.dart';
import 'new_contact_state.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final NewContactLogic logic = Get.put(NewContactLogic());
  final NewContactState state = Get.find<NewContactLogic>().state;

  @override
  void dispose() {
    Get.delete<NewContactLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "添加联系方式",
          style: TextStyle(
              fontSize: 17.w,
              color: ColorX.color_333333,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "联系方式",
                        style: TextStyle(
                            fontSize: 14.w, color: ColorX.color_333333),
                      ),
                      WidgetUtils.buildTextField(
                          266.w, 107.h, 14.w, ColorX.color_333333, "请输入QQ或者微信",
                          hintColor: ColorX.color_999999,
                          backgroundColor: ColorX.color_FaFaFa,
                          borderRadius: BorderRadius.circular(5.r),
                          inputType: TextInputType.phone,
                          onChanged: (value) => state.contact = value,
                          maxLines: 9,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h)),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
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
}
