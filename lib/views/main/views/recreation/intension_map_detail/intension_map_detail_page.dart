import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/components/circle_image.dart';
import 'package:xhs_app/http/api/login.dart';
import 'package:xhs_app/model/video/intension_map_detail_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map_detail/intension_map_detail_logic.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map_detail/widget/comment_list.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map_detail/widget/community_info_cell.dart';
import 'package:xhs_app/views/player/views/comment_list.dart' as comment;

import '../../../../../model/comment/comment_send_model.dart';

// 帖子详情
class IntensionMapDetailPage extends StatelessWidget {
  IntensionMapDetailPage({super.key});

  final controller = Get.put(IntensionMapDetailLogic());

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("帖子详情",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: COLOR.hexColor("#333333"),
            fontSize: 16.w,
            fontWeight: FontWeight.w600,
          )),
    );
  }

  Widget _buildTitle() {
    return Obx(() {
      return Text(
        controller.state.title.value ?? '',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.w,
          fontWeight: FontWeight.w600,
        ),
      ).marginOnly(bottom: 10.w);
    });
  }

  Widget _buildSecondTitle(IntensionMapDetailModelData item) {
    return Obx(() {
      return Text(
        item.text ?? '',
        style: TextStyle(
          color: ColorX.color_999999,
          fontSize: 12.w,
          fontWeight: FontWeight.w600,
        ),
      ).marginOnly(bottom: 10.w);
    });
  }

  Widget _buildContent() {
    return Obx(() {
      Get.log(
          "=================>  ${controller.state.communityInfoList.length}");
      return controller.state.communityInfoList.isEmpty
          ? SliverPadding(padding: EdgeInsets.zero)
          : SliverPadding(
              padding: EdgeInsets.only(bottom: 10.w),
              sliver: SliverList.builder(
                  itemCount: controller.state.communityInfoList.length,
                  itemBuilder: (context, index) {
                    return CommunityInfoCell(
                      data: controller.state.communityInfoList[index],
                      pictures:
                          controller.state.communityInfoList[index].images ??
                              [],
                      // community: controller.state.community.value,
                    );
                  }),
            );
    });
  }

  Widget _buildComment() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '全部评论',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.w,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${controller.state.communityInfoList.length}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    _buildTitle().sliver,
                    _buildContent(),
                    _buildComment().sliver,
                    CommentList(
                      reply: (CommentSendModel v, String nick) {
                        // controller.defaultText.value = '回复@$nick';
                        // controller.params.value = v;
                        // controller.focusNode.requestFocus();
                      },
                      gossipId: controller.state.connotationId.value,
                      type: CommentTypeEnumValue.topic,
                    ),
                  ],
                ).marginOnly(left: 16.w, right: 16.w),
              ),
              // _buildBottom(),
            ],
          ).onOpaqueTap(() {
            // controller.focusNode.unfocus();
          }),
          // Obx(() {
          //   return controller.state.community.value.dynamicId == 0
          //       ? Container(
          //     color: ColorX.white,
          //     child: const BaseLoadingWidget(),
          //   )
          //       : const SizedBox.shrink();
          // }),
        ],
      ),
    );
  }
}
