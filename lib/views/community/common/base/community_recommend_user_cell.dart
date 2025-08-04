import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/circle_image.dart';
import '../../../../components/easy_button.dart';
import '../../../../components/safe_state.dart';
import '../../../../http/api/api.dart';
import '../../../../model/user/recommend_user_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/utils.dart';

// 推荐关注，在关注页面有关注时的推荐样式
class CommunityRecommendUserCell extends StatefulWidget {
  final RecommendUserModel model;

  const CommunityRecommendUserCell(this.model, {super.key});
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<CommunityRecommendUserCell> {
  RecommendUserModel get model => widget.model;

  Future<void> _onTapAttention() async {
    final ok = await Api.toggleAttentionUser(
      widget.model.userId,
      attention: model.isAttention,
    );
    if (!ok) return;
    setState(() {
      model.onToggleAttentionSuccess();
    });
  }

  Widget _buildPortrait() => CircleImage.network(
        model.logo,
        size: 60.w,
        onTap: () => Get.toBloggerDetail(userId: model.userId),
      );

  Widget _buildName() => Text(
        model.nickName,
        style: TextStyle(fontSize: 13.w, fontWeight: FontWeight.w500),
      );

  Widget _buildLastDyn() => Text(
        '${Utils.dateAgo(model.lastDynDate)}发布了笔记',
        style: TextStyle(fontSize: 11.w, color: COLOR.color_999999),
      );

  Widget _buildBtn() => EasyButton(
        widget.model.isAttention ? '已关注' : '关注',
        width: 70.w,
        height: 26.w,
        borderRadius: Styles.borderRadius.all(24.w),
        backgroundColor: widget.model.isAttention ? null : COLOR.color_FB2D45,
        borderColor: widget.model.isAttention ? COLOR.color_999999 : null,
        textStyle: TextStyle(
          color: widget.model.isAttention ? COLOR.color_999999 : COLOR.white,
        ),
        onTap: _onTapAttention,
        loadingSize: 14.w,
      );

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: COLOR.white,
          borderRadius: Styles.borderRadius.all(4.w),
        ),
        width: 130.w,
        height: 190.w,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPortrait(),
            10.verticalSpaceFromWidth,
            _buildName(),
            4.verticalSpaceFromWidth,
            _buildLastDyn(),
            13.verticalSpaceFromWidth,
            _buildBtn(),
          ],
        ),
      );
}
