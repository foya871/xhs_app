import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/views/selection/selection_search/selection_search_logic.dart';
import 'package:xhs_app/views/selection/selection_search/selection_search_state.dart';

import '../../../../assets/colorx.dart';
import '../../../../assets/styles.dart';
import '../../../../components/base_refresh/base_refresh_widget.dart';
import '../../../../components/image_view.dart';
import '../../../../components/no_more/no_data.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/axis_cover.dart';
import '../../../../model/search/search_video_model.dart';
import '../search_logic.dart';

class SearchPlayletWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPlayletWidgetState();
}

class SearchPlayletWidgetState extends State<SearchPlayletWidget> {
  var logic = Get.put(SearchLogic());
  var state = Get.find<SearchLogic>().state;

  @override
  void initState() {
    var item = state.tabs[6];
    logic.playletController.searchType = item.classifyId ?? 0;
    logic.playletController.keyword = logic.textController.text;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      logic.playletController,
      refreshOnStart: true,
      child: PagedGridView<int, VideoList>(
        padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
        addAutomaticKeepAlives: true,
        pagingController: logic.playletController.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<VideoList>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => buildPlayletCell(item, () {
            Get.toPlayVideo(videoId: item.videoId ?? 0);
          }),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 8.w,
            crossAxisCount: 2,
            childAspectRatio: 173 / 320),
      ),
    );
  }

  Widget buildPlayletCell(VideoList item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src: "${logic.playletController.domain}${item.coverImg}",
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRaidus.xs,
                axis: CoverImgAxis.horizontal,
              ),
              if (item.videoUrl != null)
                Positioned(
                  top: 5.r,
                  right: 5.r,
                  child: Image.asset(
                    AppImagePath.player_player_start,
                    width: 20.r,
                    height: 20.r,
                    fit: BoxFit.fill,
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            item.title ?? "",
            style: TextStyle(
                fontSize: 13.w,
                color: ColorX.color_333333,
                fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '更新至${item.serialVideoNum}集',
            style: TextStyle(fontSize: 10.w, color: ColorX.color_666666),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
