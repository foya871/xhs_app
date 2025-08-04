import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/no_more/no_data_scroll_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/mine/fans_follower_model.dart';
import 'package:xhs_app/model/mine/official_community_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import '../controllers/fans_followers_page_controller.dart';

class FansFollowersPage extends StatefulWidget {
  const FansFollowersPage({super.key});

  @override
  _FansFollowersPageState createState() => _FansFollowersPageState();
}

class _FansFollowersPageState extends State<FansFollowersPage> {
  final controller = Get.find<FansFollowersPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: AppBarView(
        title: Obx(() => TextView(
              text: controller.title.value,
              color: COLOR.color_333333,
              fontSize: 16.w,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: _bodyViews(),
    );
  }

  Widget _bodyViews() {
    return BaseRefreshWidget(
      controller,
      refreshOnStart: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Obx(
          () {
            bool isHaveData = false;
            if (controller.title.value == "加群聊骚") {
              isHaveData = controller.ocLists.isNotEmpty;
            } else {
              isHaveData = controller.list.isNotEmpty;
            }
            return isHaveData
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 10.w),
                    itemCount: controller.title.value == "加群聊骚"
                        ? controller.ocLists.length
                        : controller.list.length,
                    itemBuilder: (context, index) {
                      return controller.title.value == "加群聊骚"
                          ? _itemOCView(controller.ocLists[index])
                          : _itemFansFollowerView(controller.list[index], index,
                              controller.title.value);
                    },
                  )
                : const NoDataScrollView();
          },
        ),
      ),
    );
  }

  Widget _itemFansFollowerView(
      FansFollowerModel model, int index, String title) {
    return Container(
      height: 56.w,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageView(
            src: model.logo ?? "",
            width: 56.w,
            height: 56.w,
            fit: BoxFit.cover,
            defaultPlace: AppImagePath.icon_avatar,
            borderRadius: BorderRadius.circular(28.w),
          ).onTap(() {
            Get.toBloggerDetail(userId: model.userId ?? 0);
          }),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "${model.nickName}",
                  fontSize: 14.w,
                  color: COLOR.color_666666,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextView(
                      text: "${model.workNum}作品",
                      fontSize: 14.w,
                      color: COLOR.color_999999,
                    ),
                    TextView(
                      text: "${model.bu}粉丝",
                      fontSize: 12.w,
                      color: COLOR.color_999999,
                    ).marginLeft(10.w)
                  ],
                )
              ],
            ).marginLeft(10.w),
          ),
          _followButton(model, index, title),
        ],
      ),
    );
  }

  Widget _itemOCView(OfficialCommunityModel model) {
    return Container(
      height: 44.h,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImagePath.icon_placeholder,
            width: 44.w,
            height: 44.w,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextView(
                text: "${model.name}",
                fontSize: 14.w,
                color: COLOR.color_333333,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              SmartDialog.showLoading(msg: '操作中...');
              jumpExternalAddress(model.link ?? "", null);
              SmartDialog.dismiss();
            },
            child: Container(
              width: 70.w,
              height: 25.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: COLOR.color_B93FFF,
                borderRadius: BorderRadius.circular(19.w),
              ),
              child: TextView(
                text: "加入",
                fontSize: 12.w,
                color: COLOR.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _followButton(FansFollowerModel model, int index, String title) {
    final isAttention = model.attention ?? false;
    return GestureDetector(
      onTap: () async {
        SmartDialog.showLoading(msg: '操作中...');
        if (isAttention) {
          await controller.follwersCancel(toUserId: model.userId ?? 0);
        } else {
          await controller.follwers(toUserId: model.userId ?? 0);
        }
        controller.list.value[index].attention = !isAttention;
        SmartDialog.dismiss();
        setState(() {});
      },
      child: Container(
        width: 62.w,
        height: 28.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(isAttention
                ? AppImagePath.mine_icon_focus_off
                : AppImagePath.mine_icon_focus_on),
          ),
        ),
        child: TextView(
            text: isAttention
                ? "已关注"
                : title == "粉丝"
                    ? "回关"
                    : "关注",
            fontSize: 13.w,
            color:
                isAttention ? COLOR.color_999999 : COLOR.hexColor("#fb2d45")),
      ),
    );
  }
}
