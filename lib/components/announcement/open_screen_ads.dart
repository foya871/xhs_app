/*
 * @Author: wdz
 * @Date: 2025-05-26 14:57:33
 * @LastEditTime: 2025-06-18 11:29:45
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /xhs_app/lib/components/announcement/open_screen_ads.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/utils/extension.dart';
import '../../generate/app_image_path.dart';
import '../../utils/ad_jump.dart';
import '../image_view.dart';

class OpenScreenAds extends StatelessWidget {
  final List<AdInfoModel> models;
  final VoidCallback? dismiss;
  const OpenScreenAds({
    super.key,
    required this.models,
    this.dismiss,
  });

  @override
  Widget build(BuildContext context) {
    final gap = 5.w;
    final itemW = (334.w - 40.w - gap * 3) / 4.0;
    return SizedBox(
        width: 334.w,
        height: 651.w,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.only(top: 125.w, bottom: 12.w),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImagePath.ann_open_ads_bg),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: models.map((v) {
                      return SizedBox(
                        width: itemW,
                        child: Column(
                          children: [
                            ImageView(
                                width: itemW,
                                height: itemW,
                                src: v.adImage ?? '',
                                borderRadius: BorderRadius.circular(5.w)),
                            4.verticalSpaceFromWidth,
                            Text(
                              '${v.adName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13.w),
                            )
                          ],
                        ).onOpaqueTap(() {
                          kAdjump(v);
                        }),
                      );
                    }).toList(),
                  ).paddingHorizontal(20.w),
                ),
              ),
            ),
            Positioned(
              right: 15.w,
              top: 40.w,
              child: Image.asset(
                AppImagePath.ann_cancel,
                width: 29.w,
                height: 29.w,
              ).onTap(() {
                dismiss?.call();
              }),
            )
          ],
        ));
  }
}
