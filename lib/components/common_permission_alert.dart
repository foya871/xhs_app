/*
 * @Author: wangdazhuang
 * @Date: 2024-08-20 20:40:14
 * @LastEditTime: 2024-10-17 09:51:37
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/components/common_permission_alert.dart
 */
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes/routes.dart';

/// context 上下文
/// title 标题
/// desc 描述
/// okAction 点击确定按钮的事件回掉
///
// ignore: non_constant_identifier_names
void permission_alert(BuildContext context,
    {String? title,
    String? desc,
    String? oktitle,
    String? info,
    Function()? okAction}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: 300.w,
          height: 212.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 55.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: COLOR.hexColor('#F0F0F0')))),
                child: Text(
                  title ?? "温馨提示",
                  style: TextStyle(
                      color: COLOR.hexColor("#333"),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.w),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.w)),
              Text(
                desc ?? "本视频需要开通浅网会员",
                style: TextStyle(
                    color: COLOR.hexColor("#828282"),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.w),
              ),
              Padding(padding: EdgeInsets.only(top: 10.w)),
              Text(
                info ?? "升级至尊会员享受全站无限观影特权",
                style: TextStyle(color: COLOR.hexColor("#828282"), fontSize: 13.w),
              ),
              Padding(
                padding: EdgeInsets.only(left: 28.w, right: 28.w, top: 30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 108.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.hexColor("#f8f8f8"),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "稍后再说",
                          style: TextStyle(
                              color: COLOR.hexColor("#666"),
                              fontSize: 14.w,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        //自定义事件
                        if (okAction != null) {
                          okAction();
                        } else {
                          Get.toVip();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 108.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.hexColor('#fb2d45'),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          oktitle ?? "充值会员",
                          style: TextStyle(
                              color: COLOR.hexColor("#fff"),
                              fontSize: 14.w,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
