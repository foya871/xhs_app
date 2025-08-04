import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/divider/default_divider.dart';
import '../../../../components/popup/bottomsheet/abstract_bottom_sheet.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/community/community_base_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../player/views/comment_list.dart';
import '../base/community_text_picture_mode_content.dart';

class CommunityContentAndCommentBottomSheet extends AbstractBottomSheet {
  CommunityBaseModel model;
  CommunityContentAndCommentBottomSheet(this.model)
      : super(isScrolledControlled: true);
  @override
  Widget build() => _Comment(model);
}

class _Comment extends StatelessWidget {
  final CommunityBaseModel model;
  const _Comment(this.model);

  Widget _buildAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Text(
            '正文和评价',
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500),
          ),
          Image.asset(
            AppImagePath.community_discover_close_popup,
            width: 16.w,
            height: 16.w,
          ).onTap(Get.back),
        ],
      );

  Widget _buildComment() => PlayCommentList(
        type: CommentTypeEnumValue.circle,
        dynamicId: model.dynamicId,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: COLOR.white,
        borderRadius: Styles.borderRadius.top(12.w),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 0.8.sh),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            18.verticalSpaceFromWidth.sliver,
            _buildAppBar().sliver,
            CommunityTextPictureModeContent.fromBase(model, showImage: false)
                .sliver,
            DefaultDivider(marginVertical: 10.w).sliver
          ],
          body: _buildComment(),
        ).baseMarginHorizontal,
      ),
    );
  }
}
