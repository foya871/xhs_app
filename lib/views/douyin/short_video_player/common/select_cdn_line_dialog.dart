/*
 * @Author: wangdazhuang
 * @Date: 2025-01-17 13:48:20
 * @LastEditTime: 2025-02-21 20:41:46
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/douyin/short_video_player/common/select_cdn_line_dialog.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/popup/dialog/abstract_dialog.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/play/cdn_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';

class SelectCdnLineDialog extends AbstractDialog {
  final List<CdnRsp> cdnLines;
  final String currentId;
  final ValueCallback<CdnRsp> onTap;
  SelectCdnLineDialog(
    this.cdnLines, {
    required this.currentId,
    required this.onTap,
  }) : super(borderRadius: BorderRadius.circular(12.w));
  @override
  Widget build() {
    return Container(
      decoration: BoxDecoration(
        color: COLOR.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.w),
          Text(
            '选择线路',
            style: kTextStyle(
              COLOR.color_333333,
              fontsize: 16.w,
              weight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.w),
          Container(
              height: 1.w,
              width: double.infinity,
              color: COLOR.hexColor("#F0F0F0")),
          SizedBox(height: 14.w),
          SizedBox(
            width: 244.w,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 14.w,
              spacing: 20.w,
              runAlignment: WrapAlignment.start,
              children: cdnLines.map((e) {
                final isme = e.id! == currentId;
                return Container(
                  width: 112.w,
                  height: 35.w,
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.w),
                      color:
                          isme ? Colors.transparent : COLOR.hexColor("#E5E5E5"),
                      image: isme
                          ? const DecorationImage(
                              image:
                                  AssetImage(AppImagePath.short_short_line_bg),
                              repeat: ImageRepeat.noRepeat)
                          : null),
                  child: Text(
                    e.line ?? '',
                    style: kTextStyle(isme ? COLOR.white : COLOR.color_333333,
                        fontsize: 12.w),
                  ),
                ).onTap(() {
                  onTap(e);
                  Get.back();
                });
              }).toList(),
            ).marginBottom(20.w),
          )
        ],
      ),
    );
  }
}
