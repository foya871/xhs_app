import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data_masonry_grid_view.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/activity/activity_new_model.dart';
import 'package:xhs_app/services/storage_service.dart';

import 'package:xhs_app/utils/ad_jump.dart';

class ActivityChildPage extends StatefulWidget {
  final int stationId;

  const ActivityChildPage({super.key, required this.stationId});

  @override
  State<ActivityChildPage> createState() => _ActivityChildPageState();
}

class _ActivityChildPageState extends State<ActivityChildPage> {
  final EasyRefreshController easyRefreshController = EasyRefreshController();
  final list = <AdInfoModel>[].obs;

  // int pageIndex = 1;
  @override
  void dispose() {
    super.dispose();
    easyRefreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: easyRefreshController,
      refreshOnStart: true,
      onRefresh: () => getHttpDatas(isRefresh: true),
      // onLoad: () => getHttpDatas(),
      onLoad: null,
      child: Obx(() => NoDataMasonryGridView.count(
            crossAxisCount: 4,
            itemCount: list.length,
            itemBuilder: (ctx, i) => _buildItemView(list[i]),
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 6.w,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            noData: list.isEmpty,
          )),
    );
  }

  Widget _buildItemView(AdInfoModel item) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        kAdjump(item);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageView(
            src: item.adImage ?? "",
            width: 80.w,
            height: 80.w,
            fit: BoxFit.fill,
            borderRadius: Styles.borderRaidus.m,
          ),
          5.verticalSpace,
          Text(
            item.name ?? "",
            style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Future<List<AdInfoModel>> _fetchAdList() async {
    final stationId = widget.stationId;
    final ads = Get.find<StorageService>().ads ?? [];
    if (ads.isEmpty) return [];
    final arr = ads
        .where((e) =>
            e.adPlace == AdApiType.NAV_ICON.name &&
            (e.stations != null &&
                e.stations!.any((station) => station.stationId == stationId)))
        .toList();
    return arr;
  }

  getHttpDatas({bool isRefresh = false}) async {
    // if (isRefresh) {
    //   pageIndex = 1;
    // }
    final resp = await _fetchAdList();
    if (resp.isNotEmpty) {
      if (isRefresh) {
        list.clear();
      }
      list.addAll(resp);
      // pageIndex++;
    }
  }
}
