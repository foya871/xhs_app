import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/logger.dart';
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

class SearchComicWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchComicWidgetState();
}

class SearchComicWidgetState extends State<SearchComicWidget> {
  var logic = Get.put(SearchLogic());
  var state = Get.find<SearchLogic>().state;

  @override
  void initState() {
    var item = state.tabs[2];
    logic.comicsController.searchType = item.classifyId ?? 0;
    logic.comicsController.keyword = logic.textController.text;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      logic.comicsController,
      refreshOnStart: true,
      child: PagedGridView<int, ComicsListRes>(
        padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
        addAutomaticKeepAlives: true,
        pagingController: logic.comicsController.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<ComicsListRes>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => buildComicsCell(item, () {
            Get.toComicsDetail(comicsId: item.comicsId ?? 0);
          }),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 8.w,
            crossAxisCount: 3,
            childAspectRatio: 106 / 175),
      ),
    );
  }

  Widget buildComicsCell(ComicsListRes item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src: "${logic.comicsController.domain}${item.coverImg}",
                width: double.infinity,
                height: 130.h,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRaidus.xs,
                axis: CoverImgAxis.horizontal,
              ),
              Positioned(
                top: 14.h,
                left: 0,
                child: Image.asset(
                  item.isEnd == true
                      ? AppImagePath.search_ic_work_end
                      : AppImagePath.search_ic_work_ing,
                  height: 15.h,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            item.comicsTitle ?? "",
            style: TextStyle(
                fontSize: 13.w,
                color: ColorX.color_333333,
                fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
