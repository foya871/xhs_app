import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
import '../../../../utils/utils.dart';
import '../search_logic.dart';

class SearchConnotationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchConnotationWidgetState();
}

class SearchConnotationWidgetState extends State<SearchConnotationWidget> {
  var logic = Get.put(SearchLogic());
  var state = Get.find<SearchLogic>().state;

  @override
  void initState() {
    var item = state.tabs[5];
    logic.connotationController.searchType = item.classifyId ?? 0;
    logic.connotationController.keyword = logic.textController.text;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      logic.connotationController,
      refreshOnStart: true,
      child: PagedListView<int, ConnotationList>(
        pagingController: logic.connotationController.pagingControllers,
        padding: EdgeInsets.only(top: 8.w),
        addAutomaticKeepAlives: true,
        builderDelegate: PagedChildBuilderDelegate<ConnotationList>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const NoMore(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => buildConnotationCell(item, () {
            Get.toNamed(Routes.intensionMapDetailPage, parameters: {
              "connotationId": "${item.connotationId}",
              "title": item.title ?? ""
            });
          }),
        ),
      ),
    );
  }

  Widget buildConnotationCell(ConnotationList item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child: Row(
          children: [
            ImageView(
              src: "${logic.connotationController.domain}${item.coverImg}",
              width: 130.r,
              height: 80.r,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              axis: CoverImgAxis.horizontal,
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title ?? '',
                    style: TextStyle(
                        fontSize: 13.w,
                        color: ColorX.color_333333,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    item.summary ?? '',
                    style: TextStyle(
                      fontSize: 11.w,
                      color: ColorX.color_666666,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    Utils.dateFmt(item.checkAt ?? '', Utils.full),
                    style: TextStyle(
                      fontSize: 10.w,
                      color: ColorX.color_999999,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
