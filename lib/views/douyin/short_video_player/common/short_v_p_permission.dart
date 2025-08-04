/*
 * @Author: wangdazhuang
 * @Date: 2025-01-17 13:48:20
 * @LastEditTime: 2025-01-17 21:03:42
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/douyin/short_video_player/common/short_v_p_permission.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../assets/styles.dart';
import '../../../../components/easy_button.dart';
import '../../../../model/play/video_detail_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/enum.dart';

class ShortVPPermission extends StatelessWidget {
  final VideoDetail detail;
  final VoidCallback onTapCancel;
  final VoidCallback onTapBuy;

  const ShortVPPermission(
    this.detail, {
    super.key,
    required this.onTapCancel,
    required this.onTapBuy,
  });

  Widget _buildTitle() {
    return Text(
      "试看已结束",
      textAlign: TextAlign.center,
      style: kTextStyle(
        Colors.white,
        fontsize: 16.w,
      ),
    );
  }

  Widget _buildDescText() {
    final needPay = detail.reasonType == VideoReasonTypeValueEnum.NeedPay;
    final txt = needPay ? "该视频为用户上传的金币视频，购买后永久观看" : "开通会员观看完整版，邀请好友得会员";
    return Text(
      txt,
      style: kTextStyle(
        Colors.white,
        fontsize: 16.w,
      ),
    );
  }

  Widget _buildBtns() {
    final isPay = detail.reasonType == VideoReasonTypeValueEnum.NeedPay;
    final t1 = isPay ? '上传视频' : '邀请好友';
    final t2 = isPay ? '${detail.price}金币购买' : '开通会员';
    return SizedBox(
      width: 244.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EasyButton(t1,
              backgroundColor: COLOR.hexColor("#FEF100"),
              height: 36.w,
              borderRadius: BorderRadius.circular(18.w),
              width: 112.w,
              textStyle: kTextStyle(COLOR.hexColor("#0C0935"), fontsize: 16),
              onTap: onTapCancel),
          EasyButton(
            t2,
            backgroundColor: COLOR.hexColor("#B93FFF"),
            height: 36.w,
            borderRadius: BorderRadius.circular(18.w),
            width: 112.w,
            textStyle: kTextStyle(Colors.white, fontsize: 16),
            onTap: onTapBuy,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: const Color.fromRGBO(0, 0, 0, 0.8),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),
            SizedBox(height: 10.w),
            _buildDescText(),
            SizedBox(height: 25.w),
            _buildBtns(),
          ],
        ),
      ),
    );
  }
}
