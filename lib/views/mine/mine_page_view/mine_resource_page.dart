import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_simple_widget.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/mine_community_cell/mine_community_cell.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_data_masonry_grid_view.dart';
import 'package:xhs_app/components/resource_cell/resource_cell.dart';
import 'package:xhs_app/model/community/community_model.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/mine_page_view/mine_resource_controller.dart';

class MineResourcePage extends StatefulWidget {
  const MineResourcePage({super.key});

  @override
  State<MineResourcePage> createState() => _MineResourcePageState();
}

class _MineResourcePageState extends State<MineResourcePage> {
  final controller = Get.find<MineResourceController>();

  @override
  void initState() {
    super.initState();
    controller.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return BaseRefreshSimpleWidget(
          controller,
          child: _buildBody(controller),
        );
      },
    );
    // return BaseRefreshWidget(
    //   controller,
    //   child: PagedGridView<int, CommunityModel>(
    //     padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
    //     addAutomaticKeepAlives: true,
    //     pagingController: controller.pagingControllers,
    //     builderDelegate: PagedChildBuilderDelegate<CommunityModel>(
    //         firstPageProgressIndicatorBuilder: (context) =>
    //             const SizedBox.shrink(),
    //         newPageProgressIndicatorBuilder: (context) =>
    //             const SizedBox.shrink(),
    //         noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
    //         noItemsFoundIndicatorBuilder: (context) => const NoData(),
    //         itemBuilder: (context, item, index) =>
    //             MineCommunityCell(item: item)),
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         mainAxisSpacing: 10.w,
    //         crossAxisSpacing: 8.w,
    //         crossAxisCount: 2,
    //         childAspectRatio: 173 / 296),
    //   ),
    // );
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
      emptyWidget: const NoData.empty().marginTop(44.w),
    ).marginSymmetric(horizontal: 15.w);
  }
}
