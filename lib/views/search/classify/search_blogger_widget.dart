import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:screenshot/screenshot.dart';
import 'package:xhs_app/views/selection/selection_search/selection_search_logic.dart';
import 'package:xhs_app/views/selection/selection_search/selection_search_state.dart';

import '../../../../assets/colorx.dart';
import '../../../../assets/styles.dart';
import '../../../../components/base_refresh/base_refresh_widget.dart';
import '../../../../components/image_view.dart';
import '../../../../components/no_more/no_data.dart';
import '../../../../components/no_more/no_more.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/axis_cover.dart';
import '../../../../model/search/search_video_model.dart';
import '../../../../routes/routes.dart';
import '../search_logic.dart';

class SearchBloggerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchBloggerWidgetState();
}

class SearchBloggerWidgetState extends State<SearchBloggerWidget> {
  var logic = Get.put(SearchLogic());
  var state = Get.find<SearchLogic>().state;

  @override
  void initState() {
    var item = state.tabs[1];
    logic.bloggerController.searchType = item.classifyId ?? 0;
    logic.bloggerController.keyword = logic.textController.text;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      logic.bloggerController,
      refreshOnStart: true,
      child: PagedListView<int, BloggerList>(
        pagingController: logic.bloggerController.pagingControllers,
        padding: EdgeInsets.only(top: 8.w),
        addAutomaticKeepAlives: true,
        builderDelegate: PagedChildBuilderDelegate<BloggerList>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const NoMore(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => buildBloggerCell(item, () {
            Get.toBloggerDetail(userId: item.userId ?? 0);
          }),
        ),
      ),
    );
  }

  Widget buildBloggerCell(BloggerList item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child: Row(
          children: [
            ImageView(
              src: "${logic.bloggerController.domain}${item.logo}",
              width: 56.r,
              height: 56.r,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.all(Radius.circular(28.r)),
              axis: CoverImgAxis.horizontal,
            ),
            SizedBox(
              width: 9.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nickName ?? '',
                    style:
                        TextStyle(fontSize: 14.w, color: ColorX.color_666666),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "${item.workNum ?? 0}作品 ${item.bu ?? 0}粉丝",
                    style:
                        TextStyle(fontSize: 12.w, color: ColorX.color_999999),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => logic.userAttention(item),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: Styles.borderRaidus.xl,
                  border: Border.all(
                      color: item.attention == true
                          ? ColorX.color_eeeeee
                          : ColorX.color_fb2d45,
                      width: 1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 2.h),
                child: Text(
                  item.attention == true ? "已关注" : "关注",
                  style: TextStyle(
                      fontSize: 14.w,
                      color: item.attention == true
                          ? ColorX.color_999999
                          : ColorX.color_fb2d45),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
          ],
        ),
      ),
    );
  }
}
