import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../components/base_page/base_error_widget.dart';
import '../../../components/base_page/base_loading_widget.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/no_more/no_more.dart';
import '../../../utils/color.dart';
import '../../player/views/av_player_loading.dart';
import '../common/base/community_detail/community_detail_brush_cell.dart';
import '../common/base/community_detail/community_detail_cell.dart';
import '../controllers/community_detail_page_controller.dart';

class CommunityDetailPage extends GetWidget<CommunityDetailPageController> {
  const CommunityDetailPage({super.key});

  Widget _buildBodyBrushMode() => VisibilityDetector(
        key: const Key('community-brush-page'),
        // key: UniqueKey(),
        onVisibilityChanged: (info) {
          bool? visible;
          if (info.visibleFraction == 1) {
            visible = true;
          } else if (info.visibleFraction == 0) {
            visible = false;
          }
          if (visible != null) {
            try {
              controller.onVisibleChanged(visible);
            } catch (e) {
              // ignore
            }
          }
        },
        child: PagedPageView<int, CommunityBrushModel>(
          pagingController: controller.pagingController,
          scrollDirection: Axis.vertical,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => CommunityBrushDetailCell(
              controller: controller.findBrushCellController(index, item),
            ),
            firstPageProgressIndicatorBuilder: (context) =>
                const AvPlayerLoading(),
            newPageProgressIndicatorBuilder: (context) =>
                const AvPlayerLoading(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            noMoreItemsIndicatorBuilder: (context) => const NoMore(),
            firstPageErrorIndicatorBuilder: (context) => BaseErrorWidget(
              onTap: controller.pagingController.refresh,
            ),
            newPageErrorIndicatorBuilder: (context) => BaseErrorWidget(
              onTap: controller.pagingController.retryLastFailedRequest,
            ),
          ),
          onPageChanged: controller.onPageIndexChanged,
        ),
      );

  Widget _buildBody() => controller.isBrushMode
      ? _buildBodyBrushMode()
      : CommunityDetailCell(
          controller.detail!,
          onBuySuccess: () => controller.fetchInitDynamic(force: true),
        );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: COLOR.black,
        body: controller.obx(
          (_) => _buildBody(),
          onLoading: const BaseLoadingWidget(),
          onError: (_) => BaseErrorWidget(
            onTap: () => controller.fetchInitDynamic(),
          ),
        ),
      );
}
