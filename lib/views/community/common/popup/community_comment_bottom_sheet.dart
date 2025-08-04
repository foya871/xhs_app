import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../assets/styles.dart';
import '../../../../components/popup/bottomsheet/abstract_bottom_sheet.dart';
import '../../../../model/community/community_model.dart';
import '../../../../utils/color.dart';
import '../../../player/views/comment_list.dart';

class CommunityCommentBottomSheet extends AbstractBottomSheet {
  int dynamicId;
  int commentNum;
  CommunityCommentBottomSheet.detail(CommunityModel model)
      : dynamicId = model.dynamicId,
        commentNum = model.commentNum,
        super(isScrolledControlled: true);
  @override
  Widget build() => _Comment(dynamicId, commentNum: commentNum);
}

class _Comment extends StatelessWidget {
  final int dynamicId;
  final int commentNum;
  const _Comment(this.dynamicId, {required this.commentNum});

  // Widget _buildAppBar() => Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         const SizedBox.shrink(),
  //         Text(
  //           '正文和评价',
  //           style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500),
  //         ),
  //         Image.asset(
  //           AppImagePath.community_discover_close_popup,
  //           width: 16.w,
  //           height: 16.w,
  //         ).onTap(Get.back),
  //       ],
  //     );

  Widget _buildComment() => PlayCommentList(
        type: CommentTypeEnumValue.circle,
        dynamicId: dynamicId,
        commentCount: commentNum,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: COLOR.white,
        borderRadius: Styles.borderRadius.top(12.w),
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: 0.75.sh),
        padding: EdgeInsets.only(top: 20.w, left: 14.w, right: 14.w),
        child: _buildComment(),
      ),
    );
  }
}
