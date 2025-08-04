import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../assets/colorx.dart';
import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/image_view.dart';
import '../../../components/no_more/no_data.dart';
import '../../../model/axis_cover.dart';
import '../../../model/video/product_detail_model.dart';
import 'logic.dart';
import 'state.dart';

class PortraitListPage extends StatelessWidget {
  PortraitListPage({Key? key}) : super(key: key);

  final PortraitListLogic logic = Get.put(PortraitListLogic());
  final PortraitListState state = Get.find<PortraitListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      logic.refreshController,
      child: PagedGridView<int, ProductDetailModel>(
        padding: EdgeInsets.only(top: 10.h, left: 14.w, right: 14.w),
        addAutomaticKeepAlives: true,
        pagingController: logic.refreshController.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<ProductDetailModel>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => buildItemCell(item),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 3.w,
            crossAxisCount: 3,
            childAspectRatio: 109 / 190),
      ),
    );
  }

  Widget buildItemCell(ProductDetailModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageView(
          src: item.coverImg ?? "",
          width: double.infinity,
          height: 144.h,
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
      ],
    );
  }
}
