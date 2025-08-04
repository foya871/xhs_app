import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/routes/routes.dart';

import '../../components/ad_banner/classify_ads.dart';
import '../../model/axis_cover.dart';
import '../../model/video/short_videos_resp.dart';

class SmallWordChildPage extends StatefulWidget {
  final int classifyId;
  final int videoMark;

  const SmallWordChildPage(
      {super.key, required this.classifyId, required this.videoMark});

  @override
  State<SmallWordChildPage> createState() => _SmallWordChildPageState();
}

class _SmallWordChildPageState extends State<SmallWordChildPage> {
  final EasyRefreshController easyRefreshController = EasyRefreshController();
  RxList<ShortVideoModel> list = <ShortVideoModel>[].obs;
  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
      controller: easyRefreshController,
      refreshOnStart: true,
      onRefresh: () => getHttpDatas(isRefresh: true),
      onLoad: () => getHttpDatas(),
      childBuilder: (context, physics) {
        return SingleChildScrollView(
          physics: physics,
          child: Column(
            children: [
              const ClassifyAds(),
              10.verticalSpace,
              Obx(() => list.isEmpty
                  ? const NoData()
                  : MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.w,
                      crossAxisSpacing: 8.w,
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // 禁用内部滚动
                      itemBuilder: (context, index) =>
                          buildShortVideoCell(list[index]),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 0.h),
                    )),
            ],
          ),
        );
      },
    );
  }

  Widget buildShortVideoCell(ShortVideoModel item) {
    return GestureDetector(
      onTap: () {
        Get.toPlayVideo(videoId: item.videoId ?? 0);
      },
      child: Column(
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
            item.title ?? "",
            style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  getHttpDatas({bool isRefresh = false}) {
    if (isRefresh) {
      pageIndex = 1;
    }
    Api.getShortVideoLists(
      classifyId: '${widget.classifyId}',
      videoMark: 1,
      page: pageIndex,
      pageSize: 20,
    ).then((value) {
      if (value.isNotEmpty) {
        if (isRefresh) {
          list.clear();
        }
        list.addAll(value);
        pageIndex++;
      }
    });
  }
}
