/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-02 11:04:59
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-02 16:11:17
 * @FilePath: /xhs_app/lib/views/mine/mine_download/mine_download_list_page.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_simple_widget.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_data_masonry_grid_view.dart';
import 'package:xhs_app/components/resource_cell/resource_cell.dart';
import 'package:xhs_app/utils/extension.dart';

import 'mine_download_list_page_controller.dart';

class MineDownloadListPage extends GetView<MineDownloadListPageController> {
  final String classifyTitle;
  final int classifyId;
  const MineDownloadListPage(
      {super.key, required this.classifyTitle, required this.classifyId});

  @override
  Widget build(BuildContext context) {
    String tag = "$classifyId-$classifyTitle";
    final controller = Get.find<MineDownloadListPageController>(tag: tag);

    return Obx(
      () {
        return BaseRefreshSimpleWidget(
          controller,
          child: _buildBody(controller),
        );
      },
    );
  }

  _buildBody(_) {
    final data = _.data;
    final dataInited = _.dataInited;
    return NoDataMasonryGridView.count(
      crossAxisCount: 2,
      itemCount: data.length,
      itemBuilder: (ctx, i) => ResourceCell(item: data[i]),
      noData: dataInited,
      crossAxisSpacing: 8.w,
      mainAxisSpacing: 10.w,
      emptyWidget: const NoData.empty().marginTop(88.w),
    ).marginSymmetric(horizontal: 15.w);
  }
}
