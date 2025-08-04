/*
 * @Author: wangdazhuang
 * @Date: 2024-09-25 09:22:43
 * @LastEditTime: 2024-12-04 22:26:14
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/views/short_video_player/short_video_list.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/no_more/no_data_masonry_grid_view.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/douyin/short_video_list_cell.dart';
import 'package:xhs_app/views/douyin/short_video_list_controller.dart';

import '../../components/base_refresh/base_refresh_widget.dart';

class ShortVideoListPage extends StatefulWidget {
  final String classifyId;

  const ShortVideoListPage({super.key, required this.classifyId});

  @override
  State<StatefulWidget> createState() {
    return ShortVideoListPageState();
  }
}

class ShortVideoListPageState extends State<ShortVideoListPage> {
  @override
  void initState() {
    final classId = widget.classifyId;
    Get.lazyPut(() => ShortVideoListController(classifyId: classId),
        tag: classId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final classifyId = widget.classifyId;
    final controller = Get.find<ShortVideoListController>(tag: classifyId);
    return BaseRefreshWidget(
      controller,
      enableLoad: true,
      child: GetBuilder<ShortVideoListController>(
        id: classifyId,
        tag: classifyId,
        builder: (_) {
          return NoDataMasonryGridView.count(
            crossAxisCount: 2,
            itemCount: _.videos.length,
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 4.w,
            itemBuilder: (context, index) {
              final v = _.videos[index];
              final h = v.height! == 0 ? 273.w : v.height! / v.width! * 173.w;
              return ShortVideoListCell(
                width: 183.w,
                imageHeight: h,
                model: v,
              ).onTap(
                () => Get.toShortVideoPlay(_.videos, idx: index),
              );
            },
          ).marginHorizontal(14.w).marginTop(9.w);
        },
      ),
    );
  }
}
