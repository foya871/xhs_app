import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';
import 'package:xhs_app/routes/routes.dart';

import '../../../assets/colorx.dart';
import '../../../assets/styles.dart';
import '../../../components/ad_banner/classify_ads.dart';
import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/image_view.dart';
import '../../../components/no_more/no_data.dart';
import '../../../model/axis_cover.dart';
import '../../../model/video/product_detail_model.dart';
import '../../../model/video/short_videos_resp.dart';
import 'original_underwear_logic.dart';
import 'original_underwear_state.dart';

class OriginalUnderwearPage extends StatefulWidget {
  const OriginalUnderwearPage({Key? key}) : super(key: key);

  @override
  State<OriginalUnderwearPage> createState() => _OriginalUnderwearPageState();
}

class _OriginalUnderwearPageState extends State<OriginalUnderwearPage> {
  final OriginalUnderwearLogic logic = Get.put(OriginalUnderwearLogic());
  final OriginalUnderwearState state = Get.find<OriginalUnderwearLogic>().state;

  @override
  void dispose() {
    Get.delete<OriginalUnderwearLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshWidget(
      logic.refreshController,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ClassifyAds(),
            PagedGridView<int, ProductDetailModel>(
              padding: EdgeInsets.only(top: 10.h, left: 14.w, right: 14.w),
              addAutomaticKeepAlives: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              pagingController: logic.refreshController.pagingControllers,
              builderDelegate: PagedChildBuilderDelegate<ProductDetailModel>(
                firstPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                newPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noMoreItemsIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noItemsFoundIndicatorBuilder: (context) => const NoData(),
                itemBuilder: (context, item, index) =>
                    buildProductCell(item, () {
                  Get.toProductDetail(id: item.productId ?? 0);
                }),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5.h,
                  crossAxisSpacing: 8.w,
                  crossAxisCount: 2,
                  childAspectRatio: 173 / 310),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCell(ProductDetailModel item, Function()? onTap) {
    if (item.isAd) {
      return InsertAd(
        adress: item.ad!,
        height: 200.w,
        showMark: false,
        showName: true,
        borderRadius: BorderRadius.zero,
      );
    }
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
}
