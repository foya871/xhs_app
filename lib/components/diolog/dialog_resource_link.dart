import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/utils/app_utils.dart';
import 'package:xhs_app/utils/widget_utils.dart';

class DialogResourceLink extends StatelessWidget {
  final String? title;
  final String? url;
  final String? password;
  final String? zipPassword;

  DialogResourceLink(this.title, this.url, this.password, this.zipPassword);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? '',
            style: TextStyle(fontSize: 16.w, color: ColorX.color_333333),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            url ?? "",
            style: TextStyle(fontSize: 13.w, color: ColorX.color_666666),
            textAlign: TextAlign.center,
          ),
          if (GetUtils.isNullOrBlank(password) != true)
            SizedBox(
              height: 10.h,
            ),
          if (GetUtils.isNullOrBlank(password) != true)
            Text(
              "提取码: ${password ?? ""}",
              style: TextStyle(fontSize: 13.w, color: ColorX.color_666666),
            ),
          if (GetUtils.isNullOrBlank(zipPassword) != true)
            SizedBox(
              height: 10.h,
            ),
          if (GetUtils.isNullOrBlank(zipPassword) != true)
            Text(
              "解压密码: ${zipPassword ?? ""}",
              style: TextStyle(fontSize: 13.w, color: ColorX.color_666666),
            ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WidgetUtils.buildElevatedButton("取消", 108.w, 35.h,
                  backgroundColor: ColorX.color_eeeeee,
                  textColor: ColorX.color_666666,
                  textSize: 14,
                  borderRadius: BorderRadius.circular(20.r),
                  onPressed: () => Get.back(result: false)),
              WidgetUtils.buildElevatedButton("复制链接", 108.w, 35.h,
                  backgroundColor: ColorX.color_fb2d45,
                  textColor: Colors.white,
                  textSize: 14,
                  borderRadius: BorderRadius.circular(20.r), onPressed: () {
                AppUtils.copyToClipboard(url ?? "");
                Get.back(result: true);
              }),
            ],
          ),
        ],
      ),
    );
  }
}
