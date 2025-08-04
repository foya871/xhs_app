/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-01 17:33:46
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 17:34:51
 * @FilePath: /xhs_app/lib/components/fiction_cell/fiction_cell.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/utils/color.dart';

import '../../assets/styles.dart';
import '../../model/fiction/fiction_base_model.dart';
import '../image_view.dart';

class FictionCell extends StatelessWidget {
  final FictionBase model;
  const FictionCell({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ImageView(
              src: "${model.coverImg}",
              width: double.infinity,
              height: 140.h,
              fit: BoxFit.cover,
              borderRadius: Styles.borderRaidus.m,
              axis: CoverImgAxis.horizontal,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          model.fictionTitle ?? "",
          style: TextStyle(fontSize: 13.w, color: COLOR.color_333333),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
