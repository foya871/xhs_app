import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../assets/styles.dart';
import '../../../../../components/circle_image.dart';
import '../../../../../components/easy_button.dart';
import '../../../../../components/safe_state.dart';
import '../../../../../generate/app_image_path.dart';
import '../../../../../http/api/api.dart';
import '../../../../../model/community/community_model.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/extension.dart';
import '../../../../player/views/comment_list.dart';
import '../community_text_picture_mode_content.dart';
import 'community_detail_operation_row.dart';
import 'community_detail_text_picture_mode_locked_content.dart';

// 图片、文字
class CommunityDetailTextPictureModeCell extends StatefulWidget {
  final CommunityModel model;
  final VoidCallback? onBuySuccess;
  const CommunityDetailTextPictureModeCell(this.model,
      {super.key, this.onBuySuccess});

  @override
  State<CommunityDetailTextPictureModeCell> createState() =>
      _CommunityDetailTextPictureModeCellState();
}

class _CommunityDetailTextPictureModeCellState
    extends SafeState<CommunityDetailTextPictureModeCell> {
  CommunityModel get model => widget.model;
  final scrollController = ScrollController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onTapAttention() async {
    final ok = await Api.toggleAttentionUser(model.userId,
        attention: model.isAttention);
    if (!ok) return;
    setState(() {
      model.onToggleAttentionSuccess();
    });
  }

  Widget _buildSilverAppBar() => SliverAppBar(
        pinned: true,
        leadingWidth: 40.w,
        title: Row(
          children: [
            CircleImage.network(
              model.logo,
              size: 30.w,
              onTap: () => Get.toBloggerDetail(userId: model.userId),
            ),
            9.horizontalSpace,
            Expanded(
              child: Text(
                model.nickName,
                style: TextStyle(fontSize: 13.w),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        actions: [
          EasyButton(
            model.isAttention ? '已关注' : '关注',
            width: 56.w,
            height: 26.w,
            textStyle: TextStyle(
              color:
                  model.isAttention ? COLOR.color_999999 : COLOR.color_FB2D45,
              fontSize: 13.w,
            ),
            borderColor:
                model.isAttention ? COLOR.color_999999 : COLOR.color_FB2D45,
            borderRadius: Styles.borderRadius.all(23.w),
            onTap: _onTapAttention,
          ),
          13.horizontalSpace,
          Image.asset(
            AppImagePath.community_attention_share_black,
            width: 22.w,
            height: 22.w,
          ).onTap(() => Get.toShare()),
          14.horizontalSpace,
        ],
      );

  Widget _buildBody(bool keyboardVisible) => Stack(
        children: [
          NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, _) => [
              _buildSilverAppBar(),
              model.canWatch
                  ? CommunityTextPictureModeContent.fromDetail(
                      model,
                      showImage: true,
                    ).sliver
                  : CommunityDetailTextPictureModeLockedContent(
                      model,
                      onBuySuccess: widget.onBuySuccess,
                    ).sliver,
              10.verticalSpaceFromWidth.sliver,
            ],
            body: PlayCommentList(
              type: CommentTypeEnumValue.circle,
              dynamicId: model.dynamicId,
              showInput: keyboardVisible,
              focusNode: focusNode,
            ),
          ),
          if (!keyboardVisible)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CommunityDetailOperationRow.white(
                  model,
                  onTapInput: () {
                    focusNode.unfocus();
                    setState(() {
                      focusNode.requestFocus();
                    });
                  },
                  onTapComment: () =>
                      scrollController.jumpToBottomIfNecessary(),
                ),
              ),
            )
        ],
      );

  @override
  Widget build(BuildContext context) => KeyboardVisibilityBuilder(
        builder: (context, visible) => _buildBody(visible),
      );
}
