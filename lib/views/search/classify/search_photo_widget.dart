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
import '../../../../model/axis_cover.dart';
import '../../../../model/search/search_video_model.dart';
import '../search_logic.dart';

class SearchPhotoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPhotoWidgetState();
}

class SearchPhotoWidgetState extends State<SearchPhotoWidget> {
  var logic = Get.put(SearchLogic());
  var state = Get.find<SearchLogic>().state;

  @override
  void initState() {
    var item = state.tabs[4];
    logic.photoController.searchType = item.classifyId ?? 0;
    logic.photoController.keyword = logic.textController.text;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      logic.photoController,
      refreshOnStart: true,
      child: PagedGridView<int, PictureList>(
        padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
        addAutomaticKeepAlives: true,
        pagingController: logic.photoController.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<PictureList>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => buildPhotoCell(item, () {
            Get.toPortrayPlay(portrayPicId: item.portrayPicId ?? 0);
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

  Widget buildPhotoCell(PictureList item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src: "${logic.photoController.domain}${item.coverImg}",
                width: double.infinity,
                height: 130.h,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRaidus.xs,
                axis: CoverImgAxis.horizontal,
              ),
              Positioned(
                bottom: 5.h,
                right: 5.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorX.color_333333.withOpacity(0.4),
                    borderRadius: Styles.borderRaidus.l,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Text(
                    "${item.imgNum ?? 0}张",
                    style: TextStyle(fontSize: 11.w, color: Colors.white),
                  ),
                ),
              )
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
