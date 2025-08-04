import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../../../assets/styles.dart';
import '../../../../../components/easy_button.dart';
import '../../../../../model/community/community_model.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/enum.dart';
import '../../../../../utils/extension.dart';
import '../community_carouse_silder.dart';
import '../community_utils.dart';

// 图文、文字在未解锁的情况下，顶部模糊
class CommunityDetailTextPictureModeLockedContent extends StatelessWidget {
  final CommunityModel model;
  final VoidCallback? onBuySuccess;

  const CommunityDetailTextPictureModeLockedContent(
    this.model, {
    super.key,
    this.onBuySuccess,
  });

  Tuple4<String, String, String, VoidCallback> _reasonDesc() =>
      switch (model.reasonType) {
        CommunityReasonTypeEnum.needBuy => Tuple4(
            '金币',
            '${model.price.toStringAsShort()}金币购买',
            '${model.price.toStringAsShort()}金币',
            () => CommunityUtils.tryGoldBuy(
              model.dynamicId,
              price: model.price,
              onBuySuccess: onBuySuccess,
            ),
          ),
        CommunityReasonTypeEnum.needVip => Tuple4(
            '会员',
            '开通会员',
            '前往开通',
            () => Get.toVip(),
          ),
        CommunityReasonTypeEnum.needFans => Tuple4(
            '粉丝团专属',
            '加入粉丝团',
            '前往加入',
            () => Get.toBloggerPrivateGroup(userId: model.userId),
          ),
        _ => Tuple4('-', '-', '-', () {}),
      };

  Widget _buildUnlockTips() {
    final desc = _reasonDesc();
    final style = TextStyle(color: COLOR.white, fontSize: 15.w);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('该笔记为${desc.item1}笔记', style: style),
        5.verticalSpaceFromWidth,
        Text('${desc.item2}观看完整版', style: style),
        18.verticalSpaceFromWidth,
        EasyButton(
          desc.item3,
          height: 36.w,
          minWidth: 104.w,
          textStyle: TextStyle(
            color: COLOR.color_BB602A,
            fontSize: 14.w,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: COLOR.color_FFBE20,
          borderRadius: Styles.borderRadius.all(19.w),
          onTap: desc.item4,
        )
      ],
    );
  }

  Widget _buildBody() => Blur(
        blur: 15,
        blurColor: COLOR.black.withOpacity(0.5),
        overlay: _buildUnlockTips(),
        child: Container(
          constraints: BoxConstraints(maxHeight: 460.w),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 5.w),
          alignment: Alignment.center,
          child: model.images.isNotEmpty
              ? CommunityCarouseSlider(model.images)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommunityUtils.buildTitle(model.title),
                    10.verticalSpaceFromWidth,
                    CommunityUtils.buildContentText(model.contentText),
                  ],
                ),
        ),
      );

  @override
  Widget build(BuildContext context) => _buildBody();
}
