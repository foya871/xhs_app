import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/app_bar/extend_transparent_app_bar.dart';
import '../../../../components/base_page/base_error_widget.dart';
import '../../../../components/no_more/no_data.dart';
import '../../../../components/no_more/no_more.dart';
import '../../../../utils/color.dart';
import '../../../player/views/av_player_loading.dart';
import '../common/short_v_p_cell.dart';
import '../common/short_video_model.dart';
import '../controllers/short_video_player_page_controller.dart';
import 'package:xhs_app/utils/extension.dart';

class ShortVideoPlayerPage extends StatelessWidget {
  final ShortVideoPlayerMode mode;

  const ShortVideoPlayerPage({super.key, required this.mode});

  Widget _buildAd(AdInfoModel ad) {
    // return const SizedBox.expand(child: Text('111'));
    return Stack(
      children: [
        ImageView(
          src: ad.adImage ?? '',
          width: double.infinity,
          height: double.infinity,
        ),
        if (ad.adName?.isNotEmpty == true)
          Positioned(
            left: 10.w,
            bottom: 50.w,
            child: Container(
              decoration: BoxDecoration(
                color: COLOR.black.withOpacity(0.5),
                borderRadius: Styles.borderRadius.all(8.w),
              ),
              constraints: BoxConstraints(
                minHeight: 40.w,
                minWidth: 180.w,
                maxWidth: 300.w,
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(ad.adName!),
            ),
          )
      ],
    ).onOpaqueTap(() => kAdjump(ad));
  }

  Widget _buildMainArea(ShortVideoPlayerPageController controller) {
    final isLocal = mode == ShortVideoPlayerMode.local;
    return Positioned.fill(
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => controller.pagingController.refresh(),
        ),
        notificationPredicate:
            !isLocal ? defaultScrollNotificationPredicate : (_) => false,
        child: PagedPageView<int, ShortVideoOrAdModel>(
          pageController: controller.pageController,
          pagingController: controller.pagingController,
          scrollDirection: Axis.vertical,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) {
              if (item is AdInfoModel) {
                return _buildAd(item);
              } else if (item is ShortVideoModel) {
                return ShortVPCell(
                  item,
                  controller: controller.findCellController(index),
                );
              } else {
                assert(false, "??");
                return const SizedBox.shrink();
              }
            },
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLocal = mode == ShortVideoPlayerMode.local;
    final vcTag = mode.index.toString();
    ShortVideoPlayerPageController controller =
        Get.find<ShortVideoPlayerPageController>(tag: vcTag);
    return GetBuilder<ShortVideoPlayerPageController>(
      init: controller,
      tag: vcTag,
      autoRemove: false,
      builder: (controller) => VisibilityDetector(
        key: Key('short-video-pge-${mode.index}'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 1) {
            controller.onVisibleChange(true);
          } else if (info.visibleFraction == 0) {
            // 可能已经卸载了
            if (Get.isRegistered<ShortVideoPlayerPageController>(tag: vcTag) ||
                Get.isPrepared<ShortVideoPlayerPageController>(tag: vcTag)) {
              controller.onVisibleChange(false);
            }
          }
        },
        child: SafeArea(
          bottom: isLocal,
          top: false,
          child: Scaffold(
            backgroundColor: Colors.black,
            extendBodyBehindAppBar: isLocal,
            appBar: isLocal
                ? ExtendTransparentAppBar(backColor: COLOR.white)
                : null,
            body: Stack(
              children: [
                _buildMainArea(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
