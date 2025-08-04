import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/popup/bottomsheet/abstract_bottom_sheet.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../base/community_collection_tile_list.dart';

class CommunityCollectionTileBottomSheet extends AbstractBottomSheet {
  final String collectionName;
  final int userId;
  CommunityCollectionTileBottomSheet(this.collectionName,
      {required this.userId})
      : super(
          isScrolledControlled: true,
          borderRadius: Styles.borderRadius.all(12.w),
        );

  Widget _buildTitle() => SizedBox(
        height: 63.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Text(
              collectionName,
              style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500),
            ),
            Image.asset(
              AppImagePath.community_discover_close_popup,
              width: 16.w,
              height: 16.w,
            ).onTap(Get.back)
          ],
        ),
      ).baseMarginHorizontal;

  @override
  Widget build() => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: COLOR.color_F8F8F8,
          borderRadius: borderRadius,
        ),
        constraints: BoxConstraints(maxHeight: 0.65.sh),
        child: Column(
          children: [
            _buildTitle(),
            Flexible(
              child: CommunityCollectionTileList(
                collectionName,
                userId: userId,
                cellBackgroundColor: COLOR.white,
                cellPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 4.w,
                ),
                cellOnTap: (model) {
                  Get.back();
                  Get.toCommunityDetail(model);
                },
              ),
            ),
          ],
        ),
      );
}
