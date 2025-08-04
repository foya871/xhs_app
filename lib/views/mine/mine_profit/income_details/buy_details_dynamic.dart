import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/model/mine/buy_dynamic.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../../assets/colorx.dart';
import '../../../../components/base_refresh/base_refresh_widget.dart';
import 'buy_details_dynamic_controller.dart';

class BuyDynamicDetails extends GetView<BuyDetailsDynamicController> {
  const BuyDynamicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.arrow_back_ios,
          size: 22.w,
          color: COLOR.color_666666,
        ).onTap(() => Get.back()),
        title: const Text(
          '购买详情',
          style: TextStyle(color: COLOR.color_333333, fontSize: 17),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.w),
            child: Container(
              height: 1.w,
              color: COLOR.hexColor('#F0F0F0'),
            )),
      ),
      body: _buildContent(),
    );
  }

  _buildContent() {
    return BaseRefreshWidget(controller,
        child: PagedListView(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<BuyDynamic>(
                firstPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                newPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noMoreItemsIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noItemsFoundIndicatorBuilder: (context) => const NoData(),
                itemBuilder: (context, item, index) => _buildItem(item))));
  }

  _buildItem(BuyDynamic item) {
    return Container(
      margin: EdgeInsets.only(top: 10.w, left: 14.w, right: 14.w, bottom: 10.w),
      child: Container(
        width: 368.w,
        height: 66.w,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10.w),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: COLOR.hexColor('#F5F5F5'),
            borderRadius: BorderRadius.circular(6.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item.nickName}',
                  style: TextStyle(
                      color: ColorX.color_333333, fontSize: 14.w),
                ),
                Text(
                  '2021.07.28  24:05:35',
                  style: TextStyle(
                      color: COLOR.hexColor('#A4A4B2'), fontSize: 12.w),
                )
              ],
            ).padding(EdgeInsets.only(left: 12.w)),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Text(
                '+${item.amount}',
                style:
                    TextStyle(color: COLOR.hexColor('#DD001B'), fontSize: 20.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
