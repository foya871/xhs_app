/*
 * @Author: wangdazhuang
 * @Date: 2025-01-16 14:00:00
 * @LastEditTime: 2025-03-04 18:45:54
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/components/no_more/no_data_candom.dart
 */
import 'package:flutter/widgets.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/utils/color.dart';

class NoDataCandom extends StatelessWidget {
  const NoDataCandom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(AppImagePath.icon_nodata, width: 103.w, height: 85.w),
        12.verticalSpaceFromWidth,
        Text(
          '空空如也~~',
          style: TextStyle(
            color: COLOR.color_999999,
            fontSize: 14.w,
          ),
        ),
      ],
    );
  }
}
