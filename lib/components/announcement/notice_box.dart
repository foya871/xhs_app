/*
 * @Author: wdz
 * @Date: 2025-06-17 20:50:19
 * @LastEditTime: 2025-06-18 11:24:52
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /xhs_app/lib/components/announcement/notice_box.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../assets/styles.dart';
import '../../model/announcement/announcement.dart';
import '../../utils/color.dart';
import '../../utils/context_link.dart';
import '../easy_button.dart';
import '../text_view.dart';

class NoticeBox extends StatelessWidget {
  final AnnouncementModel model;
  final VoidCallback? dismiss;
  const NoticeBox({
    super.key,
    required this.model,
    this.dismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285.w,
      height: 370.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextView(
            text: "系统公告",
            color: Colors.black,
            fontSize: 18.w,
            fontWeight: FontWeight.bold,
          ),
          15.verticalSpaceFromWidth,
          Expanded(
            child: SingleChildScrollView(
              child: Text.rich(
                  TextSpan(
                    children: contextLink(
                      " ${model.content ?? ''}",
                      TextStyle(color: COLOR.playerThemeColor, fontSize: 14.w),
                    ),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 13.w)),
            ),
          ),
          10.w.verticalSpaceFromWidth,
          SizedBox(
            width: 252.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EasyButton(
                  '知道了',
                  backgroundColor: COLOR.playerThemeColor,
                  width: 252.w,
                  height: 37.w,
                  borderWidth: 1.0,
                  borderRadius: BorderRadius.circular(18.5.w),
                  textStyle: kTextStyle(COLOR.white,
                      fontsize: 15.w, weight: FontWeight.bold),
                  onTap: () => dismiss?.call(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
