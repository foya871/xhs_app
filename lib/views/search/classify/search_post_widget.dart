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
import '../../../../model/search/dynamic_hot_word_model.dart';
import '../../../../model/search/search_video_model.dart';
import '../search_logic.dart';
import 'search_dynamic_controller.dart';

class SearchPostWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPostWidgetState();
}

class SearchPostWidgetState extends State<SearchPostWidget> {
  var logic = Get.put(SearchLogic());
  var state = Get.find<SearchLogic>().state;

  @override
  void initState() {
    var item = state.tabs[0];
    logic.dynamicController.searchType = item.classifyId ?? 0;
    logic.dynamicController.keyword = logic.textController.text;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      logic.dynamicController,
      refreshOnStart: true,
      child: PagedGridView<int, DynamicList>(
        padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
        addAutomaticKeepAlives: true,
        pagingController: logic.dynamicController.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<DynamicList>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => buildPostCell(item, () {
            Get.toCommunityDetailById(item.dynamicId ?? 0);
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

  Widget buildPostCell(DynamicList item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src:
                    "${logic.dynamicController.domain}${item.images?.firstOrNull}",
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRaidus.xs,
                axis: CoverImgAxis.horizontal,
              ),
              if (item.video != null)
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
          Row(
            children: [
              ImageView(
                src: "${logic.dynamicController.domain}${item.logo}",
                width: 16.r,
                height: 16.r,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRaidus.m,
                axis: CoverImgAxis.horizontal,
              ),
              SizedBox(
                width: 2.w,
              ),
              Expanded(
                child: Text(
                  item.nickName ?? '',
                  style: TextStyle(fontSize: 10.w, color: ColorX.color_666666),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Image.asset(
                item.isLike == true
                    ? AppImagePath.player_like_y
                    : AppImagePath.player_like,
                width: 15.r,
                height: 12.r,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                "${item.fakeLikes ?? 0}",
                style: TextStyle(fontSize: 10.w, color: ColorX.color_666666),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
