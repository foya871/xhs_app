import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/image_view.dart';
import '../../../../components/short_widget/video_official_recommend_cell.dart';
import '../../../../components/short_widget/video_rank_cell.dart';
import '../../../../model/video_base_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../../utils/utils.dart';

class ItemVideoLongView extends StatelessWidget {
  static double imageHeight = 104.w;
  final VideoBaseModel model;
  final int? rank;

  const ItemVideoLongView(this.model, {super.key, this.rank});

  Widget _buildLeft() => Stack(
        children: [
          ImageView(
            src: model.hCover,
            width: 182.w,
            height: imageHeight,
            borderRadius: Styles.borderRadius.all(8.w),
          ),
          if (rank != null)
            Positioned(top: 0, left: 0, child: VideoRankCell(rank!)),
          if (model.officialRecommend == true)
            const Positioned(
              top: 0,
              right: 0,
              child: VideoOfficialRecommendCell(),
            )
        ],
      );

  Widget _buildRight() => Container(
        margin: EdgeInsets.only(top: 15.w, bottom: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title ?? '',
              style: TextStyle(color: COLOR.primaryText, fontSize: 13.w),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${Utils.numFmtCh(model.fakeWatchNum ?? 0)}次播放  ${Utils.dateFmt(model.createdAt ?? "")} 发布',
              style: TextStyle(color: COLOR.color_A4A4B2, fontSize: 9.w),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => SizedBox(
        height: imageHeight,
        child: Row(
          children: [
            _buildLeft(),
            10.horizontalSpace,
            Expanded(child: _buildRight()),
          ],
        ),
      ).onOpaqueTap(() => Get.toPlayVideo(videoId: model.videoId ?? 0));
}
