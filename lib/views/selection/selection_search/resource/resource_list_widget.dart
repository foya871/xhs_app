import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/views/selection/selection_search/resource/resource_list_controller.dart';

import '../../../../assets/colorx.dart';
import '../../../../assets/styles.dart';
import '../../../../components/base_refresh/base_refresh_widget.dart';
import '../../../../components/image_view.dart';
import '../../../../components/no_more/no_data.dart';
import '../../../../model/axis_cover.dart';
import '../../../../model/product/product_classify_model.dart';
import '../../../../model/video/product_detail_model.dart';
import '../../../../model/video/resource_download_model.dart';
import '../product/product_list_controller.dart';
import '../selection_search_logic.dart';
import '../selection_search_state.dart';

class ResourceListWidget extends StatelessWidget {
  final ResourceListController refreshController;
  final ProductClassifyModel model;

  ResourceListWidget(this.refreshController, this.model);

  final SelectionSearchLogic logic = Get.put(SelectionSearchLogic());
  final SelectionSearchState state = Get.find<SelectionSearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      refreshController,
      refreshOnStart: true,
      child: PagedGridView<int, ResourceInfo>(
        padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
        addAutomaticKeepAlives: true,
        pagingController: refreshController.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<ResourceInfo>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => buildResourceCell(item, () {
            Get.toResourceDetail(id: item.resourcesId ?? 0);
          }),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 8.w,
            crossAxisCount: 2,
            childAspectRatio: 162 / 130),
      ),
    );
  }

  Widget buildProductCell(ProductDetailModel item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageView(
            src: item.coverImg ?? "",
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
            // borderRadius: Styles.borderRaidus.m,
            axis: CoverImgAxis.horizontal,
          ),
          SizedBox(
            height: 3.h,
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
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: "金币 ",
                  style: TextStyle(fontSize: 10.w, color: ColorX.color_fb2d45)),
              TextSpan(
                  text: "${item.price ?? 0}",
                  style: TextStyle(
                      fontSize: 15.w,
                      color: ColorX.color_fb2d45,
                      fontWeight: FontWeight.w500)),
              TextSpan(
                  text: " ${item.buyNum ?? 0}人已买",
                  style: TextStyle(fontSize: 10.w, color: ColorX.color_666666)),
            ]),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget buildResourceCell(ResourceInfo item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageView(
            src: item.coverImg ?? "",
            width: double.infinity,
            height: 90.h,
            fit: BoxFit.cover,
            borderRadius: Styles.borderRaidus.m,
            axis: CoverImgAxis.horizontal,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            item.resourcesTitle ?? "",
            style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
