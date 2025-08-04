import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/utils.dart';

import '../../../../assets/styles.dart';

class ItemVideoShortView extends StatelessWidget {
  final double height;
  final VideoBaseModel model;

  ItemVideoShortView({
    required this.height,
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var imagePath = "";
    var imagePaths = model.verticalImg;
    if (imagePaths != null && imagePaths.isNotEmpty) {
      imagePath = imagePaths.first;
    } else {
      imagePath = model.hCover;
      // if (imagePaths != null && imagePaths.isNotEmpty) {
      //   imagePath = imagePaths.first;
      // }
    }

    return Container(
      child: Column(
        children: [
          Container(
            height: height,
            child: Stack(
              children: [
                ImageView(
                  src: imagePath,
                  width: double.infinity,
                  height: height,
                  fit: BoxFit.cover,
                  borderRadius: Styles.borderRadius.m,
                ),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(left: 5.w, bottom: 5.h),
                            child: TextView(
                              text: "${model.fakeWatchNum}",
                              fontSize: 10.w,
                              color: COLOR.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.only(right: 5.w, bottom: 5.h),
                            child: TextView(
                              text:
                                  "${Utils.convertSeconds(model.playTime ?? 0)}",
                              fontSize: 10.w,
                              color: COLOR.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            alignment: Alignment.centerLeft,
            child: TextView(
              text: "${model.title}",
              fontSize: 12.w,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: COLOR.color_333333,
            ),
          ),
        ],
      ),
    );
  }
}
