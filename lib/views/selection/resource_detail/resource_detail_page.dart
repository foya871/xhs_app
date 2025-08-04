import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_more.dart';
import 'package:xhs_app/utils/dialog_utils.dart';

import '../../../assets/styles.dart';
import '../../../components/image_view.dart';
import '../../../model/axis_cover.dart';
import '../../../model/video/resource_report.dart';
import '../../../routes/routes.dart';
import '../../../utils/utils.dart';
import '../../community/common/base/community_utils.dart';
import 'resource_detail_logic.dart';
import 'resource_detail_state.dart';

class ResourceDetailPage extends StatefulWidget {
  const ResourceDetailPage({Key? key}) : super(key: key);

  @override
  State<ResourceDetailPage> createState() => _ResourceDetailPageState();
}

class _ResourceDetailPageState extends State<ResourceDetailPage> {
  final ResourceDetailLogic logic =
      Get.put(ResourceDetailLogic(), tag: "${Get.arguments}");
  final ResourceDetailState state =
      Get.find<ResourceDetailLogic>(tag: "${Get.arguments}").state;

  @override
  void dispose() {
    Get.delete<ResourceDetailLogic>(tag: "${Get.arguments}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "资源详情",
          style: TextStyle(
              fontSize: 17.w,
              color: ColorX.color_333333,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: ColorX.color_FaFaFa,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Obx(() {
                        return Text(
                          state.resourceDetail.value.data?.resourcesTitle ?? "",
                          style: TextStyle(
                              fontSize: 16.w,
                              color: ColorX.color_333333,
                              fontWeight: FontWeight.w500),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Obx(() {
                        return Row(
                          children: [
                            ImageView(
                              src: state.resourceDetail.value.data?.logo ?? '',
                              width: 27.r,
                              height: 27.r,
                              fit: BoxFit.cover,
                              borderRadius: Styles.borderRaidus.xl,
                              axis: CoverImgAxis.horizontal,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: Text(
                                state.resourceDetail.value.data?.nickName ?? '',
                                style: TextStyle(
                                    fontSize: 12.w, color: ColorX.color_666666),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "${Utils.dateFmt(state.resourceDetail.value.data?.checkAt ?? '', Utils.full)}发布",
                              style: TextStyle(
                                  fontSize: 11.w, color: ColorX.color_999999),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Obx(() {
                        return Text(
                          state.resourceDetail.value.data?.info ?? "",
                          style: TextStyle(
                            fontSize: 14.w,
                            color: ColorX.color_666666,
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Obx(() {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var item =
                                state.resourceDetail.value.data?.images![index];
                            return ImageView(
                              src:
                                  "${state.resourceDetail.value.domain}${item}",
                              // width: 27.r,
                              // height: 27.r,
                              fit: BoxFit.cover,
                              // borderRadius: Styles.borderRaidus.xl,
                              axis: CoverImgAxis.horizontal,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 3.h,
                            );
                          },
                          itemCount:
                              state.resourceDetail.value.data?.images?.length ??
                                  0,
                        );
                      }),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        "全部反馈",
                        style: TextStyle(
                            fontSize: 15.w,
                            color: ColorX.color_333333,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Obx(() {
                        if (state.reports.isEmpty) return NoData();
                        return Column(
                          children: state.reports
                              .map((item) => buildReportCell(item))
                              .toList(),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50.h,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            child: Obx(() {
              return state.resourceDetail.value.data?.unlock != true
                  ? unlockBtn()
                  : lockBtn();
            }),
          )
        ],
      ),
    );
  }

  Widget buildReportCell(ResourceReport item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageView(
          src: item.logo ?? '',
          width: 32.r,
          height: 32.r,
          fit: BoxFit.cover,
          borderRadius: Styles.borderRaidus.xl,
          axis: CoverImgAxis.horizontal,
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.nickName ?? '',
                style: TextStyle(fontSize: 13.w, color: ColorX.color_999999),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 6.h,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: item.remark ?? "",
                  style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
                ),
                WidgetSpan(
                    child: SizedBox(
                  width: 3.w,
                )),
                TextSpan(
                  text: Utils.dateFmt(item.createdAt ?? '', ['mm', '-', 'dd']),
                  style: TextStyle(fontSize: 11.w, color: ColorX.color_999999),
                ),
              ])),
              SizedBox(
                height: 6.h,
              ),
              Divider(
                height: 1.h,
                color: ColorX.color_eeeeee,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget unlockBtn() {
    return GestureDetector(
      onTap: () {
        CommunityUtils.tryGoldBuyResource(
          state.resourceDetail.value.data?.resourcesId ?? 0,
          price: (state.resourceDetail.value.data?.price ?? 0).toDouble(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorX.color_fb2d45,
          borderRadius: BorderRadius.circular(20.r),
        ),
        alignment: Alignment.center,
        child: Text(
          "${state.resourceDetail.value.data?.price ?? 0}金币解锁资源",
          style: TextStyle(
              fontSize: 14.w, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget lockBtn() {
    var data = state.resourceDetail.value.data;
    return Row(
      children: [
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          flex: 10,
          child: GestureDetector(
            onTap: () => Get.toNamed(Routes.resourceFeedback,
                arguments: data?.resourcesId),
            child: Container(
              decoration: BoxDecoration(
                color: ColorX.color_fb2d45,
                borderRadius: BorderRadius.circular(20.r),
              ),
              height: 35.h,
              alignment: Alignment.center,
              child: Text(
                "资源反馈",
                style: TextStyle(
                    fontSize: 14.w,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          flex: 10,
          child: GestureDetector(
            onTap: () => DialogUtils.showDownloadLink(context, "资源下载链接",
                data?.website, data?.extractionCode, data?.decompressPassword),
            child: Container(
              decoration: BoxDecoration(
                color: ColorX.color_fb2d45,
                borderRadius: BorderRadius.circular(20.r),
              ),
              height: 35.h,
              alignment: Alignment.center,
              child: Text(
                "获取链接",
                style: TextStyle(
                    fontSize: 14.w,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
      ],
    );
  }
}
