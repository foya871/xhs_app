import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/utils/widget_utils.dart';

import '../../../../assets/colorx.dart';
import 'new_address_logic.dart';
import 'new_address_state.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({Key? key}) : super(key: key);

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  final NewAddressLogic logic = Get.put(NewAddressLogic());
  final NewAddressState state = Get.find<NewAddressLogic>().state;

  @override
  void dispose() {
    Get.delete<NewAddressLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "添加地址",
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
                    children: [
                      Text(
                        "收货人",
                        style: TextStyle(
                            fontSize: 14.w, color: ColorX.color_333333),
                      ),
                      WidgetUtils.buildTextField(
                          266.w, 40.h, 14.w, ColorX.color_333333, "请输入收货人姓名",
                          hintColor: ColorX.color_999999,
                          backgroundColor: ColorX.color_FaFaFa,
                          borderRadius: BorderRadius.circular(5.r),
                          inputType: TextInputType.name,
                          onChanged: (value) => state.username = value),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "手机号码",
                        style: TextStyle(
                            fontSize: 14.w, color: ColorX.color_333333),
                      ),
                      WidgetUtils.buildTextField(
                          266.w, 40.h, 14.w, ColorX.color_333333, "请输入手机号码",
                          hintColor: ColorX.color_999999,
                          backgroundColor: ColorX.color_FaFaFa,
                          borderRadius: BorderRadius.circular(5.r),
                          inputType: TextInputType.phone,
                          onChanged: (value) => state.phone = value),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "填写地区",
                        style: TextStyle(
                            fontSize: 14.w, color: ColorX.color_333333),
                      ),
                      WidgetUtils.buildTextField(
                          266.w, 40.h, 14.w, ColorX.color_333333, "请输入地区省/市/区",
                          hintColor: ColorX.color_999999,
                          backgroundColor: ColorX.color_FaFaFa,
                          borderRadius: BorderRadius.circular(5.r),
                          inputType: TextInputType.streetAddress,
                          onChanged: (value) => state.city = value),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "详细地址",
                        style: TextStyle(
                            fontSize: 14.w, color: ColorX.color_333333),
                      ),
                      WidgetUtils.buildTextField(266.w, 107.h, 14.w,
                          ColorX.color_333333, "请输入详细地址 列:XX街/XX路/XX号",
                          hintColor: ColorX.color_999999,
                          backgroundColor: ColorX.color_FaFaFa,
                          borderRadius: BorderRadius.circular(5.r),
                          inputType: TextInputType.streetAddress,
                          onChanged: (value) => state.area = value,
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
