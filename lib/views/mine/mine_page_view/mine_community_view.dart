import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/mine_community_cell/mine_community_cell.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/model/community/community_model.dart';
import 'package:xhs_app/views/mine/mine_page_view/mine_community_controller.dart';


class MineCommunityView extends StatefulWidget {
  const MineCommunityView({super.key});

  @override
  State<MineCommunityView> createState() => _MineCommunityViewState();
}

class _MineCommunityViewState extends State<MineCommunityView> {
  final controller = Get.put(MineCommunityController());

  @override
  void initState() {
    super.initState();
    controller.onRefresh();
    // controller.pagingControllers.addListener(() {
   
    //   setState(() {});
    // });
  }


  @override
  Widget build(BuildContext context) {
    
      return BaseRefreshWidget(
        controller,
        child: PagedGridView<int, CommunityModel>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<CommunityModel>(
              firstPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              newPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
              noItemsFoundIndicatorBuilder: (context) => const NoData(),
              itemBuilder: (context, item, index) =>
                  MineCommunityCell(item: item)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 173 / 296),
        ),
      );
  }
}
