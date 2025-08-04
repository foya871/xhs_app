import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/mine/record_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';

import 'recharge_record_page_controller.dart';

class RechargeRecordPage extends GetView<RechargeRecordPageController> {
  const RechargeRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: _buildAppBar(),
      body: _buildContentView(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: COLOR.white,
      leading: IconButton(
        iconSize: 20.w,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: COLOR.black,
        ),
        onPressed: () => Get.back(),
      ),
      title: TextView(
        text: "充值记录",
        color: COLOR.color_333333,
        fontSize: 16.w,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildContentView() {
    return EasyRefresh(
      controller: controller.refreshController,
      refreshOnStart: true,
      onRefresh: () => controller.onRefresh(),
      onLoad: () => controller.onLoad(),
      child: PagedListView<int, RecordModel>(
        padding: EdgeInsets.only(top: 10, left: 18.w, right: 18.w),
        addAutomaticKeepAlives: true,
        pagingController: controller.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<RecordModel>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) => _buildItemView(item),
        ),
      ),
    );
  }

  _buildItemView(RecordModel model) {
    return Container(
      width: 360.w,
      height: 82.w,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: COLOR.color_EEEEEE))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: "${model.remark}",
                style: kTextStyle(COLOR.color_333333, fontsize: 14.w),
              ),
              TextView(
                text: "${model.createdAt}",
                style: kTextStyle(COLOR.color_999999, fontsize: 12.w),
              ).marginTop(8.w)
            ],
          ),
          TextView(
            text: "-${model.money}${model.currencyType == 1 ? "元" : "金币"}",
            style: kTextStyle(
              COLOR.color_333333,
              fontsize: 16.w,
              weight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
    // return AppBgView(
    //   backgroundColor: COLOR.color_FEFEFE,
    //   width: double.infinity,
    //   margin: EdgeInsets.only(bottom: 10.w),
    //   padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.w),
    //   radius: 6.w,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Row(
    //         children: [
    //           Expanded(
    //             child: TextView(
    //               text: Utils.dateFmt(
    //                   model.createdAt!, ["yyyy", "-", "mm", "-", "dd"]),
    //               color: COLOR.color_AFAFAF,
    //               fontSize: 12.w,
    //             ),
    //           ),
    //           TextView(
    //             text: model.status == 0 ? "交易成功" : "交易失败",
    //             color: COLOR.color_FE0303,
    //             fontSize: 16.w,
    //           ),
    //         ],
    //       ),
    //       15.verticalSpace,
    //       Row(
    //         children: [
    //           Image.asset(
    //             controller.getPayType(model.payType ?? 0),
    //             width: 40.w,
    //             height: 40.w,
    //           ),
    //           8.horizontalSpace,
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 TextView(
    //                   text: "${model.title}",
    //                   color: COLOR.color_333333,
    //                   fontSize: 16.w,
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //                 3.verticalSpace,
    //                 TextView(
    //                   text: '订单编号：${model.tradeNo}',
    //                   color: COLOR.color_AFAFAF,
    //                   fontSize: 11.w,
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           TextView(
    //             text: "¥${model.rechargeMoney ?? 0}",
    //             color: COLOR.color_AEAFB5,
    //             fontSize: 16.w,
    //           ),
    //         ],
    //       ),
    //       10.verticalSpace,
    //       Row(
    //         children: [
    //           const Spacer(),
    //           TextView(
    //             text: "实付款：",
    //             color: COLOR.color_AEAFB5,
    //             fontSize: 14.w,
    //           ),
    //           TextView(
    //             text: "¥${model.amount}",
    //             color: COLOR.color_151515,
    //             fontSize: 20.w,
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
