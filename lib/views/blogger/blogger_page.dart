import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/app_bg_view.dart';
import '../../components/image_view.dart';
import '../../components/text_view.dart';
import '../../generate/app_image_path.dart';
import '../../model/user/user_info_model.dart';
import '../../routes/routes.dart';
import '../../utils/color.dart';
import '../../utils/enum.dart';
import '../../utils/extension.dart';
import '../../utils/utils.dart';
import 'blogger_page_controller.dart';
import 'tab_child/blogger_search_view.dart';
import 'tab_child/collection_view.dart';
import 'tab_child/note_view.dart';
import 'tab_child/private_group_view.dart';
import 'tab_child/resource_view.dart';

class BloggerPage extends GetView<BloggerPageController> {
  const BloggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  _bodyView() {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildHeadView().sliver,
            SizedBox(
              child: Obx(() => controller.isShowSearch.value
                  ? BloggerSearchView(
                      searchController: controller.searchController,
                      onTap: () => controller.startSearch(),
                    )
                  : const SizedBox.shrink()),
            ).sliver,
            SizedBox(
              width: double.infinity,
              height: 40.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TabBar(
                    controller: controller.tabController,
                    tabs: controller.tabs,
                    labelColor: COLOR.black,
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    labelStyle: TextStyle(
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelColor: COLOR.color_666666,
                    unselectedLabelStyle: TextStyle(
                      fontSize: 14.w,
                    ),
                    indicatorColor: COLOR.color_FB2D45,
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                  Positioned(
                      top: 10.w,
                      right: 15.w,
                      child: ImageView(
                        src: AppImagePath.mine_mine_search,
                        width: 20.w,
                        height: 20.w,
                      ).onOpaqueTap(() {
                        controller.isShowSearch.value =
                            !controller.isShowSearch.value;
                      })),
                ],
              ),
            ).sliver,
          ];
        },
        body: TabBarView(
          controller: controller.tabController,
          children: [
            NoteView(
              userId: controller.userId,
              searchQueryGetter: controller.getSearchText,
              controller: controller.noteController,
            ).keepAlive,
            PrivateGroupView(
              userId: controller.userId,
              searchQueryGetter: controller.getSearchText,
              controller: controller.privateGroupController,
            ).keepAlive,
            CollectionView(
              userId: controller.userId,
              searchQueryGetter: controller.getSearchText,
              controller: controller.collectionController,
            ).keepAlive,
            ResourceView(
              userId: controller.userId,
              searchQueryGetter: controller.getSearchText,
              controller: controller.resourceController,
            ).keepAlive,
          ],
        ));
  }

  Widget _buildHeadView() {
    return AppBgView(
      imagePath: AppImagePath.mine_head_bg,
      child: Column(
        children: [
          ///返回按钮  举报按钮
          AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                icon: ImageView(
                    src: AppImagePath.mine_blogger_report,
                    width: 17.w,
                    height: 17.w),
                onPressed: () {
                  Get.toBloggerReport(userId: controller.userId);
                },
              ),
            ],
          ),
          10.verticalSpace,

          Obx(() => _buildUserInfoView(controller.bloggerInfo.value)),
          const ImageView(
            src: AppImagePath.mine_blogger_top_bg,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }

  Widget _buildHeadView1() {
    return Stack(
      children: [
        Obx(() => ImageView(
              src: controller.bloggerInfo.value.bgImg ??
                  AppImagePath.mine_head_bg,
              fit: BoxFit.fill,
              defaultPlace: AppImagePath.mine_head_bg,
            )),
        Column(
          children: [
            ///返回按钮  举报按钮
            AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                IconButton(
                  icon: ImageView(
                      src: AppImagePath.mine_blogger_report,
                      width: 17.w,
                      height: 17.w),
                  onPressed: () {
                    Get.toBloggerReport(userId: controller.userId);
                  },
                ),
              ],
            ),
            10.verticalSpace,

            Obx(() => _buildUserInfoView(controller.bloggerInfo.value)),
            const ImageView(
              src: AppImagePath.mine_blogger_top_bg,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ],
    );
  }

  ///用户信息
  _buildUserInfoView(UserInfo bloggerInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///头像 用户名 用户ID
        Row(
          children: [
            ImageView(
              src: bloggerInfo.logo ?? "",
              width: 80.w,
              height: 80.w,
              borderRadius: BorderRadius.circular(40.w),
              defaultPlace: AppImagePath.icon_avatar,
            ),
            10.horizontalSpace,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextView(
                      text: bloggerInfo.nickName ?? "",
                      color: COLOR.white,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w600,
                    ),
                    8.horizontalSpace,
                    (bloggerInfo.vipType ?? 0) > 0 &&
                            VipTypeEnum.badge(bloggerInfo.vipType).isNotEmpty
                        ? ImageView(
                            src: VipTypeEnum.badge(bloggerInfo.vipType),
                            width: 40.w,
                            height: 16.w,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                5.verticalSpace,
                TextView(
                  text: '用户ID：${bloggerInfo.userId ?? 0}',
                  color: COLOR.white.withOpacity(0.6),
                  fontSize: 12.w,
                ),
              ],
            ),
          ],
        ),
        15.verticalSpace,
        TextView(
          text: bloggerInfo.personSign ?? "暂时没有简介",
          color: COLOR.white,
          maxLines: 4,
          fontSize: 13.w,
          textAlign: TextAlign.start,
        ),
        20.verticalSpace,
        Row(
          children: [
            _buildUserInfoItemView('关注', Utils.numFmt(bloggerInfo.ua ?? 0)),
            _buildUserInfoItemView('粉丝', Utils.numFmt(bloggerInfo.bu ?? 0)),
            _buildUserInfoItemView(
                '获赞', Utils.numFmt(bloggerInfo.likedNum ?? 0)),
            20.horizontalSpace,
            AppBgView(
              width: 80.w,
              height: 32.w,
              radius: 16.w,
              backgroundColor: bloggerInfo.attentionHe == true
                  ? COLOR.white.withOpacity(0.12)
                  : COLOR.color_FB2D45,
              border: bloggerInfo.attentionHe == true
                  ? Border.all(color: COLOR.white, width: 0.5)
                  : null,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              text: bloggerInfo.attentionHe == true ? "已关注" : "关注",
              textColor: COLOR.white,
              onTap: () {
                controller.attentionBlogger();
              },
            ),
            10.horizontalSpace,
            ImageView(
              src: AppImagePath.mine_blogger_chat,
              width: 47.w,
              height: 32.w,
              fit: BoxFit.fill,
            ).onOpaqueTap(() {
              //跳转到聊天页面
              Get.toPrivateChatMessage(
                logo: controller.bloggerInfo.value.logo ?? "",
                name: controller.bloggerInfo.value.nickName ?? "",
                userid: controller.bloggerInfo.value.userId ?? 0,
              );
            }),
          ],
        ),
        (bloggerInfo.hasChatRoom == true ||
                bloggerInfo.hasCollection == true ||
                bloggerInfo.hasFansGroup == true)
            ? 20.verticalSpace
            : 0.verticalSpace,
        Row(
          children: [
            if (bloggerInfo.hasChatRoom == true)
              Expanded(
                flex: 1,
                child: _buildOptionView(
                  AppImagePath.mine_blogger_chat_s,
                  '群聊',
                  '查看详情',
                  onTap: () => Get.toBloggerGroupChat(
                      userId: controller.userId,
                      nickName: bloggerInfo.nickName ?? ""),
                ),
              ),
            if (bloggerInfo.hasChatRoom == true) 8.horizontalSpace,
            if (bloggerInfo.hasCollection == true)
              Expanded(
                flex: 1,
                child: _buildOptionView(
                  AppImagePath.mine_blogger_collection,
                  'Ta的合集',
                  '精彩不容错过',
                  onTap: () =>
                      Get.toBloggerCollection(userId: controller.userId),
                ),
              ),
            if (bloggerInfo.hasCollection == true) 8.horizontalSpace,
            if (bloggerInfo.hasFansGroup == true)
              Expanded(
                flex: 1,
                child: _buildOptionView(
                  AppImagePath.mine_blogger_group,
                  '私人团',
                  '专属内容更精彩',
                  onTap: () =>
                      Get.toBloggerPrivateGroup(userId: controller.userId),
                ),
              ),
          ],
        ),
        20.verticalSpace,
      ],
    ).paddingSymmetric(horizontal: 10.w);
  }

  _buildUserInfoItemView(String title, String count) {
    return Expanded(
      child: Column(
        children: [
          TextView(
            text: count,
            color: COLOR.white,
            fontSize: 15.w,
            fontWeight: FontWeight.w600,
            maxLines: 1,
          ),
          5.verticalSpace,
          TextView(
            text: title,
            color: COLOR.white.withOpacity(0.6),
            fontSize: 11.w,
          ),
        ],
      ),
    );
  }

  _buildOptionView(String imagePath, String title, String desc,
      {Function()? onTap}) {
    return AppBgView(
      height: 48.w,
      radius: 8.w,
      backgroundColor: COLOR.white.withOpacity(0.12),
      padding: EdgeInsets.symmetric(horizontal: 11.w),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageView(src: imagePath, width: 16.w, height: 16.w),
              5.horizontalSpace,
              TextView(
                text: title,
                color: COLOR.white,
                fontSize: 12.w,
              ),
            ],
          ),
          TextView(
            text: desc,
            color: COLOR.white.withOpacity(0.6),
            fontSize: 11.w,
          ),
        ],
      ),
    );
  }
}
