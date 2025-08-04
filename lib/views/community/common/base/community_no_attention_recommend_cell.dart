import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/circle_image.dart';
import '../../../../components/easy_button.dart';
import '../../../../components/image_view.dart';
import '../../../../components/safe_state.dart';
import '../../../../http/api/api.dart';
import '../../../../model/community/community_not_concerned_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../../utils/utils.dart';

// 推荐关注，在关注页面没有关注时的推荐样式
class CommunityNoAttentionRecommendCell extends StatefulWidget {
  final CommunityNotConcernedModel model;
  const CommunityNoAttentionRecommendCell(this.model, {super.key});
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<CommunityNoAttentionRecommendCell> {
  CommunityNotConcernedModel get model => widget.model;

  Future<void> _onTapAttention() async {
    final ok = await Api.toggleAttentionUser(
      model.userId,
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

  // xx发布了笔记
  Widget _buildLastDate() => Text(
        '${Utils.dateAgo(model.lastDynDate)}发布了笔记',
        style: TextStyle(
          fontSize: 11.w,
          fontWeight: FontWeight.w500,
          color: COLOR.color_999999,
        ),
      );

  Widget _buildOneDyn(CommunityNotConcernedDynamicInfo dyn) => ImageView(
        src: dyn.coverImg,
        width: 58.w,
        height: 58.w,
        borderRadius: Styles.borderRadius.all(4.w),
      ).onTap(
        () => Get.toCommunityDetailById(
          dyn.dynamicId,
          dynamicType: dyn.dynamicType,
        ),
      );

  Widget _buildDyn() => model.dynList.isEmpty
      ? Container(width: 3 * 58.w + 4.w)
      : Row(
          children:
              model.dynList.map((e) => _buildOneDyn(e)).toList().joinWidth(2.w),
        );

  Widget _buildBtn() => EasyButton(
        model.isAttention ? '已关注' : '关注',
        width: 70.w,
        height: 26.w,
        borderRadius: Styles.borderRadius.all(24.w),
        backgroundColor: model.isAttention ? null : COLOR.color_FB2D45,
        borderColor: model.isAttention ? COLOR.color_999999 : null,
        textStyle: TextStyle(
          color: model.isAttention ? COLOR.color_999999 : COLOR.white,
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
        child: Column(
          children: [
            32.verticalSpaceFromWidth,
            _buildPortrait(),
            10.verticalSpaceFromWidth,
            _buildName(),
            4.verticalSpaceFromWidth,
            _buildLastDate(),
            10.verticalSpaceFromWidth,
            _buildDyn().marginHorizontal(3.w),
            20.verticalSpaceFromWidth,
            _buildBtn(),
          ],
        ),
      );
}
