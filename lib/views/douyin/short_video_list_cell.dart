/*
 * @Author: wangdazhuang
 * @Date: 2024-09-25 22:25:49
 * @LastEditTime: 2025-01-25 14:32:35
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/douyin/short_video_list_cell.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:hive/hive.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/keyword_color/keyword_color.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:xhs_app/utils/color.dart';

class ShortVideoListCell extends StatelessWidget {
  // ignore: unused_field
  final VideoBaseModel _model;
  final double width;
  final double? imageHeight; //默认 238.w
  final VoidCallback? tap;
  final Color? titleColor;
  final String? keyWord;
  final bool? check; //是否审核
  final int? checkStatus; //1-待审核 2-已发布 3-未通过
  const ShortVideoListCell({
    super.key,
    required VideoBaseModel model,
    required this.width,
    this.tap,
    this.imageHeight,
    this.titleColor,
    this.check,
    this.checkStatus = 0,
    this.keyWord,
  }) : _model = model;

  _buildCover() {
    return Positioned.fill(
        child: ImageView(
      src: _model.vCover,
      width: width,
      height: imageHeight ?? 273.w,
      fit: BoxFit.cover,
      vertical: true,
      borderRadius: Styles.borderRadius.xs,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: imageHeight ?? 238.w,
          width: width,
          child: Stack(
            children: [
              _buildCover(),
              if (checkStatus! == 1 || checkStatus! == 3) _buidCheckView(),
            ],
          ),
        ),
        SizedBox(height: 8.w),
        KeywordColor(
          title: _model.title ?? '',
          keyWord: keyWord,
          style: TextStyle(
            fontSize: 14.w,
            color: Colors.white,
          ),
          kstyle: TextStyle(
            color: COLOR.hexColor('#B940FF'),
            fontSize: 14.w,
          ),
        ),
      ],
    );
  }

  //审核时的view
  _buidCheckView() {
    return Positioned.fill(
      child: Container(
        width: width,
        height: imageHeight ?? 273.w,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(4),
        ),
        child: checkStatus == 1 ? _checkViewTwo() : _checkViewThree(),
      ),
    );
  }

  //审核中
  _checkViewTwo() {
    return Stack(
      children: [
        Positioned(
            right: 5.w,
            bottom: 1.w,
            child: Column(
              children: [
                Image.asset(AppImagePath.mine_img_mine_check_bg,
                    width: 17.w, height: 22.w),
                TextView(text: '审核中', fontSize: 12.w, color: Colors.white),
              ],
            )),
      ],
    );
  }

  //未通过
  _checkViewThree() {
    return Stack(
      children: [
        Positioned(
            width: width,
            bottom: 5.w,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                SizedBox(width: 5.w),
                Expanded(
                    child: TextView(
                        text: _model.notPass ?? '',
                        fontSize: 10.w,
                        color: Colors.white)),
                Image.asset(AppImagePath.mine_img_mine_check_delete,
                    width: 14.w, height: 14.w),
                SizedBox(width: 5.w),
              ],
            )),
      ],
    );
  }
}
