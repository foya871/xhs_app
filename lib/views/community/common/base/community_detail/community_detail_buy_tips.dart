import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../assets/styles.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/extension.dart';

class CommunityDetailBuyTips extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const CommunityDetailBuyTips.vip({super.key, this.onTap})
      : text = '开通会员观看完整版';
  const CommunityDetailBuyTips.needFans({super.key, this.onTap})
      : text = '加入粉丝团观看完整版';
  const CommunityDetailBuyTips.vipUp({super.key, this.onTap})
      : text = '升级至尊会员享更多福利';
  CommunityDetailBuyTips.gold(double gold, {super.key, this.onTap})
      : text = '${gold.toStringAsShort()}金币观看完整版';

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: COLOR.white.withOpacity(0.2),
          borderRadius: Styles.borderRadius.all(13.w),
          border: Border.all(color: COLOR.black.withOpacity(0.25)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 3.w),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: COLOR.color_FFBE20,
            fontSize: 12.w,
            fontWeight: FontWeight.w500,
          ),
        ),
      ).onOpaqueTap(onTap);
}
