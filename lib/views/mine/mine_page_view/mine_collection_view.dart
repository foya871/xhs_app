import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/comics_cell/comics_cell.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/model/comics/comics_base.dart';
import 'package:xhs_app/routes/routes.dart';

import '../../../assets/colorx.dart';
import '../../../components/image_view.dart';
import '../../../model/axis_cover.dart';
import '../../../model/community/community_base_model.dart';
import '../../../model/video/product_detail_model.dart';
import '../../../utils/color.dart';
import '../../community/common/base/community_base_cell.dart';
import 'mine_collection_comics_logic.dart';
import 'mine_collection_commuty_logic.dart';
import 'mine_collection_product_logic.dart';

class MineCollectionView extends StatefulWidget {
  final String title;
  const MineCollectionView({super.key, required this.title});

  @override
  State<MineCollectionView> createState() => _MineCollectionViewState();
}

class _MineCollectionViewState extends State<MineCollectionView> {
  final controller = Get.put(CollecttionComicsyLogic());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.pagingControllers.refresh();
      },
      child: PagedGridView<int, ComicsBaseModel>(
        padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
        addAutomaticKeepAlives: true,
        showNoMoreItemsIndicatorAsGridChild: false,
        showNewPageProgressIndicatorAsGridChild: false,
        showNewPageErrorIndicatorAsGridChild: false,
        pagingController: controller.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<ComicsBaseModel>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) {
              return Container(
                  alignment: Alignment.topCenter,
                  width: 340.w,
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: Text(
                    '没有更多了',
                    style: TextStyle(color: COLOR.easyRefresh, fontSize: 14.w),
                  ));
            },
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, item, index) => ComicsCell(model: item)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 8.w,
            crossAxisCount: 3,
            childAspectRatio: 130 / 220),
      ),
    );
  }
}

// ===================== 商品=================

class MineCollectProductView extends StatefulWidget {
  const MineCollectProductView({super.key});

  @override
  State<MineCollectProductView> createState() => _MineCollectProductViewState();
}

class _MineCollectProductViewState extends State<MineCollectProductView> {
  final controller = Get.put(CollecttionProductLogic());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.pagingControllers.refresh();
      },
      child: PagedGridView<int, ProductDetailModel>(
        padding: EdgeInsets.only(top: 10.h, left: 14.w, right: 14.w),
        addAutomaticKeepAlives: true,
        showNoMoreItemsIndicatorAsGridChild: false,
        showNewPageProgressIndicatorAsGridChild: false,
        showNewPageErrorIndicatorAsGridChild: false,
        pagingController: controller.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<ProductDetailModel>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) {
            return Container(
                alignment: Alignment.center,
                width: 340.w,
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Text(
                  '没有更多了',
                  style: TextStyle(color: COLOR.easyRefresh, fontSize: 14.w),
                ));
            ;
          },
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => buildProductCell(item, () {
            Get.toProductDetail(id: item.productId ?? 0);
          }),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5.h,
            crossAxisSpacing: 8.w,
            crossAxisCount: 2,
            childAspectRatio: 173 / 310),
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
}

// ===================== 笔记=================

class MineCollectCommuntyView extends StatefulWidget {
  const MineCollectCommuntyView({super.key});

  @override
  State<MineCollectCommuntyView> createState() => _MineCollectCommuntyView();
}

class _MineCollectCommuntyView extends State<MineCollectCommuntyView> {
  final controller = Get.put(CollecttionCommuntyLogic());

  @override
  void initState() {
    super.initState();
    // controller.onRefresh();
    // controller.pagingControllers.addListener(() {});
  }

  // @override
  // Widget abuild(BuildContext context) {
  //   return BaseRefreshWidget(
  //     controller,
  //     enableLoad: true,
  //     child: NoDataMasonryGridView.count(
  //       crossAxisCount: 2,
  //       itemBuilder: (ctx, i) =>
  //           CommunityBaseCell(controller.pagingControllers.itemList![i]),
  //       itemCount: controller.pagingControllers.itemList?.length ?? 0,
  //       crossAxisSpacing: 4.w,
  //       mainAxisSpacing: 4.w,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.pagingControllers.refresh();
      },
      child: PagedMasonryGridView.count(
        padding: EdgeInsets.only(top: 10.h, left: 14.w, right: 14.w),
        pagingController: controller.pagingControllers,
        showNoMoreItemsIndicatorAsGridChild: false,
        showNewPageProgressIndicatorAsGridChild: false,
        showNewPageErrorIndicatorAsGridChild: false,
        builderDelegate: PagedChildBuilderDelegate<CommunityBaseModel>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) {
            return Container(
                alignment: Alignment.center,
                width: 340.w,
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Text(
                  '没有更多了',
                  style: TextStyle(color: COLOR.easyRefresh, fontSize: 14.w),
                ));
          },
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => CommunityBaseCell(item),
        ),
        crossAxisCount: 2,
        mainAxisSpacing: 4.h,
        crossAxisSpacing: 4.w,
      ),
    );
  }
}
