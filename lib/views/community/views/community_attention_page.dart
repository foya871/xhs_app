import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/ad_banner/classify_ads.dart';

import '../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../components/no_more/no_data_sliver_list.dart';
import '../../../model/community/community_base_model.dart';
import '../../../model/community/community_not_concerned_model.dart';
import '../../../model/user/recommend_user_model.dart';
import '../../../utils/color.dart';
import '../../../utils/extension.dart';
import '../common/base/community_big_vertical_cell.dart';
import '../common/base/community_no_attention_recommend_cell.dart';
import '../common/base/community_recommend_user_cell_block.dart';
import '../controllers/communtiy_attention_page_controller.dart';

// 首页-关注
class CommunityAttentionPage extends GetView<CommuntiyAttentionPageController> {
  const CommunityAttentionPage({super.key});
  Widget _buildAttentionMode(ScrollPhysics physics) => CustomScrollView(
        cacheExtent: 1.5.sh,
        physics: physics,
        slivers: [
          const ClassifyAds().sliver,
          Obx(() {
            final data = controller.data;
            final dataInited = controller.dataInited;
            return NoDataSliverList.separated(
              itemCount: data.length,
              itemBuilder: (ctx, i) {
                final model = data[i];
                if (model is CommunityBaseModel) {
                  return CommunityBigVerticalCell(model);
                } else if (model is List<RecommendUserModel>) {
                  return CommunityRecommendUserCellBlock(model);
                } else {
                  return const SizedBox.shrink();
                }
              },
              separatorBuilder: (ctx, i) => 4.verticalSpaceFromWidth,
              noData: dataInited,
            );
          }),
        ],
      );

  Widget _buildNoAttentionTips() => Obx(
        () {
          final dataInited = controller.dataInited;
          if (dataInited) {
            return Column(
              children: [
                Text(
                  '还没有关注的人呢',
                  style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500),
                ),
                10.verticalSpaceFromWidth,
                Text(
                  '关注后，可以在这里查看对方的最新动态',
                  style: TextStyle(color: COLOR.color_999999, fontSize: 12.w),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Widget _buildNoAttentionRecommend() => EasyRefresh(
        onRefresh: null,
        onLoad: controller.onLoad,
        child: Obx(() {
          final data = controller.data;
          return SizedBox(
            height: 270.w,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (ctx, i) {
                if (data[i] is CommunityNotConcernedModel) {
                  return CommunityNoAttentionRecommendCell(data[i]);
                }
                assert(false, '???');
                return const SizedBox.shrink();
              },
              separatorBuilder: (ctx, i) => 13.horizontalSpace,
            ),
          );
        }),
      );

  Widget _buildNoAttentionMode(ScrollPhysics physics) => CustomScrollView(
        physics: physics,
        slivers: [
          60.verticalSpaceFromWidth.sliver,
          _buildNoAttentionTips().sliver,
          60.verticalSpaceFromWidth.sliver,
          _buildNoAttentionRecommend().baseMarginL.sliver,
        ],
      );

  Widget _buildBody(ScrollPhysics physics) => Obx(
        () => controller.attentionMode.value
            ? _buildAttentionMode(physics)
            : _buildNoAttentionMode(physics),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: COLOR.color_FAFAFA,
        body: BaseRefreshSimpleWidget.builder(
          controller,
          childBuilder: (context, physics) => _buildBody(physics),
        ),
      );
}
