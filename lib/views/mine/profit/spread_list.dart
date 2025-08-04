/*
 * @Author: wangdazhuang
 * @Date: 2024-10-17 19:19:33
 * @LastEditTime: 2024-10-18 09:36:58
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/views/mine/profit/spread_list.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/grid_view/heighted_grid_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';
import 'package:xhs_app/views/mine/profit/spread_list_controller.dart';

import '../../../assets/styles.dart';
import '../../../utils/color.dart';

class SpreadList extends StatelessWidget {
  const SpreadList({super.key});

  _buildTxt(String txt, {bool isRight = false}) {
    return Text(
      txt,
      textAlign: isRight ? TextAlign.right : TextAlign.left,
      style: kTextStyle(COLOR.color_666666, fontsize: 12.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<SpreadListController>();
    return GetBuilder<SpreadListController>(
      builder: (_) {
        return HeightedGridView.sliver(
          rowSepratorBuilder: (context, index) {
            return Container(
              height: 1.w,
              width: double.infinity,
              color: COLOR.hexColor("#F0F0F0"),
            ).marginHorizontal(16.w);
          },
          crossAxisCount: 1,
          itemCount: _.list.length,
          itemBuilder: (context, index) {
            final item = _.list[index];
            return SizedBox(
              height: 40.w,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTxt(item.name ?? ''),
                  _buildTxt("${item.gold ?? 0}"),
                  _buildTxt("${item.returnGold ?? 0}"),
                  _buildTxt(
                      Utils.dateFmt(item.createdAt ?? '',
                          const ['yyyy', '-', 'mm', '-', 'dd']),
                      isRight: true),
                ],
              ),
            ).marginHorizontal(16.w);
          },
        );
      },
    );
  }
}
