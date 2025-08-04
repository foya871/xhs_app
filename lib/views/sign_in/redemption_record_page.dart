import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/check_in/redemption_record_model.dart';
import 'package:xhs_app/utils/color.dart';

class RedemptionRecordPage extends StatefulWidget {
  const RedemptionRecordPage({super.key});

  @override
  State<RedemptionRecordPage> createState() => _RedemptionRecordPageState();
}

class _RedemptionRecordPageState extends State<RedemptionRecordPage> {
  final PagingController<int, RedemptionRecordModel> pagingControllers =
      PagingController(firstPageKey: 1);
  int pageIndex = 1;

  ///获取积分兑换记录
  void getIntegralPrizes({required bool isRefresh}) {
    Api.getExchangeRecord(page: pageIndex).then((response) {
      if (response.isNotEmpty) {
        if (isRefresh) {
          pagingControllers.refresh();
        }
        pagingControllers.appendPage(response, pageIndex);
        pageIndex = isRefresh ? 1 : pageIndex + 1;
      } else {
        pagingControllers.appendLastPage([]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('兑换记录')),
      body: EasyRefresh(
        onRefresh: () => getIntegralPrizes(isRefresh: true),
        onLoad: () => getIntegralPrizes(isRefresh: false),
        child: PagedGridView<int, RedemptionRecordModel>(
          pagingController: pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<RedemptionRecordModel>(
            firstPageProgressIndicatorBuilder: (context) =>
            const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
            const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, item, index) {
              return _buildWelfareItemTaskView(item);
            },
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
        ),
      ),
    );
  }

  _buildWelfareItemTaskView(RedemptionRecordModel item) {
    return AppBgView(
      radius: 8.w,
      child: Column(
        children: [
          AppBgView(
            height: 70.w,
            imagePath: getCheckInWelfareTypeImagePath(item.type ?? 0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.w),
              topRight: Radius.circular(8.w),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: TextView(
              text: item.desc ?? "",
              color: COLOR.white,
              fontSize: 13.w,
            ),
          ),
          AppBgView(
            height: 36.w,
            backgroundColor: COLOR.color_EEEEEE,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.w),
              bottomRight: Radius.circular(8.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: [
                TextView(
                  text: "花费${item.integral}积分",
                  color: COLOR.color_666666,
                  fontSize: 12.w,
                ),
                const Spacer(),
                AppBgView(
                  height: 22.w,
                  radius: 11.w,
                  backgroundColor: COLOR.color_FB2D45,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  text: "立即兑换",
                  textColor: COLOR.white,
                  textSize: 11.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getCheckInWelfareTypeImagePath(int status) {
    switch (status) {
      case 1: //会员
        return AppImagePath.home_check_in_welfare_vip_bg;
      case 2: //ai 换脸
        return AppImagePath.home_check_in_welfare_ai_change_bg;
      case 3: //金币
        return AppImagePath.home_check_in_welfare_gold_bg;
      case 4: //观影券
        return AppImagePath.home_check_in_welfare_ticket_bg;
      case 5: //ai 去衣
        return AppImagePath.home_check_in_welfare_ai_out_bg;
      case 6: //萝莉会员
        return AppImagePath.home_check_in_welfare_luoli_vip_bg;
      default:
        return AppImagePath.home_check_in_welfare_gold_bg;
    }
  }
}
