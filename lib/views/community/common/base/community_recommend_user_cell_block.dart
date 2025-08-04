import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generate/app_image_path.dart';
import '../../../../model/user/recommend_user_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import 'community_recommend_user_cell.dart';

class CommunityRecommendUserCellBlock extends StatelessWidget {
  final List<RecommendUserModel> models;

  const CommunityRecommendUserCellBlock(this.models, {super.key});

  Widget _buildTitleRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '你可能敢兴趣的人',
            style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                '查看更多',
                style: TextStyle(fontSize: 12.w, color: COLOR.color_999999),
              ),
              Image.asset(
                AppImagePath.icons_right_arrow,
                width: 5.w,
                height: 8.7.w,
              )
            ],
          )
        ],
      ).onOpaqueTap(() => Get.toNamed(Routes.recommendAttention));

  Widget _buildUserList() => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 190.w),
        child: ListView.separated(
          itemCount: models.length,
          itemBuilder: (ctx, i) => CommunityRecommendUserCell(models[i]),
          separatorBuilder: (ctx, i) => 10.horizontalSpace,
          scrollDirection: Axis.horizontal,
        ),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Column(
          children: [
            _buildTitleRow().baseMarginHorizontal,
            10.verticalSpaceFromWidth,
            _buildUserList().baseMarginL,
          ],
        ),
      );
}
