import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/circle_image.dart';
import 'package:xhs_app/components/easy_button.dart';
import 'package:xhs_app/components/safe_state.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/user/recommend_user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

class RecommendUserTile extends StatefulWidget {
  final RecommendUserModel model;
  const RecommendUserTile(this.model, {super.key});

  @override
  State<RecommendUserTile> createState() => _RecommendUserTileState();
}

class _RecommendUserTileState extends SafeState<RecommendUserTile> {
  RecommendUserModel get model => widget.model;

  Future<void> _onToggleAttention() async {
    final ok = await Api.toggleAttentionUser(
      model.userId,
      attention: model.isAttention,
    );
    if (!ok) return;
    setState(() {
      model.onToggleAttentionSuccess();
    });
  }

  Widget _buildLeft() => Row(
        children: [
          CircleImage.network(model.logo, size: 56.w),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.nickName,
                style: TextStyle(
                  color: COLOR.color_666666,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                ),
              ),
              3.verticalSpaceFromWidth,
              Text(
                '${model.workNum}作品  ${model.bu}粉丝',
                style: TextStyle(
                  color: COLOR.color_999999,
                  fontSize: 12.w,
                ),
              )
            ],
          )
        ],
      );

  Widget _buildRight() => EasyButton(
        model.isAttention ? '已关注' : '关注',
        textStyle: model.isAttention
            ? TextStyle(color: COLOR.color_999999, fontSize: 13.w)
            : TextStyle(color: COLOR.color_FB2D45, fontSize: 13.w),
        borderColor:
            model.isAttention ? COLOR.color_999999 : COLOR.color_FB2D45,
        borderRadius: Styles.borderRadius.all(8.w),
        onTap: _onToggleAttention,
      );

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildLeft()),
          _buildRight(),
        ],
      ).onOpaqueTap(() => Get.toBloggerDetail(userId: model.userId));
}
