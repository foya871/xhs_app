/*
 * @Author: wangdazhuang
 * @Date: 2025-03-10 20:44:31
 * @LastEditTime: 2025-03-15 15:15:59
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/components/ad_banner/insert_ad.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/ad/ad_utils.dart';

import '../../assets/styles.dart';
import '../../model/advertisements/ad_resp_model.dart';
import '../../utils/ad_jump.dart';
import '../../utils/ad_utils.dart';
import '../../utils/color.dart';
import '../../utils/extension.dart';
import '../../utils/initAdvertisementInfo.dart';
import '../image_view.dart';

class InsertAd extends StatelessWidget {
  final AdApiType adress;
  final double? height;
  final double? width;
  final bool showMark;
  final bool showName;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final double? spacing;
  const InsertAd({
    super.key,
    required this.adress,
    double? width,
    double? height,
    this.showName = false,
    this.showMark = true,
    this.margin,
    this.borderRadius,
    this.spacing,
  })  : height = null,
        width = null;

  const InsertAd.fromPlaceholder(
    AdApiType placeholder, {
    super.key,
    this.width = double.infinity,
    this.height,
    this.showMark = true,
    this.showName = true,
    this.margin,
    this.borderRadius,
    this.spacing,
  }) : adress = placeholder;

  Widget _buildCover(AdInfoModel ad) => ImageView(
        src: ad.adImage ?? '',
        fit: BoxFit.fill,
        height: height,
        width: double.infinity,
        borderRadius: borderRadius ?? Styles.borderRadius.top(8.w),
      );

  Widget _buildName(AdInfoModel ad) => Text(
        ad.adName ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 13.w, fontWeight: FontWeight.w500),
      );

  Widget _buildMark() => Container(
        decoration: BoxDecoration(
          color: COLOR.color_FB2D45,
          borderRadius: Styles.borderRaidus.all(3.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
        child: Text(
          '广告',
          style: TextStyle(color: COLOR.white, fontSize: 10.w),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final ad = adHelper.getAdInfo(adress);
    if (ad == null) return const SizedBox.shrink();
    return Container(
      width: width,
      // height: height,
      margin: margin,
      color: COLOR.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: spacing ?? 9.w,
        children: [
          _buildCover(ad),
          if (showName) _buildName(ad).marginHorizontal(8.w),
          if (showMark) _buildMark().marginHorizontal(8.w),
          // 4.verticalSpaceFromWidth,
        ],
      ),
    ).onOpaqueTap(() => kAdjump(ad));
  }
}
