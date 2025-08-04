import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../components/no_more/no_data_sliver_list.dart';
import '../common/base/recommend_user_tile.dart';
import '../controllers/recommend_attention_page_controller.dart';

class RecommendAttentionPage extends GetView<RecommendAttentionPageController> {
  const RecommendAttentionPage({super.key});
  AppBar _buildAppBar() => AppBar(title: const Text('推荐'));

  Widget _buildBody() => CustomScrollView(
        slivers: [
          Obx(
            () {
              final data = controller.data;
              final dataInited = controller.dataInited;
              return NoDataSliverList.separated(
                itemCount: data.length,
                itemBuilder: (ctx, i) => RecommendUserTile(data[i]),
                separatorBuilder: (ctx, i) => 16.verticalSpaceFromWidth,
                noData: dataInited,
              );
            },
          )
        ],
      ).baseMarginLtr;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: BaseRefreshSimpleWidget(controller, child: _buildBody()),
      );
}
