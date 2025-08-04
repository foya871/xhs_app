/*
 * @Author: wangdazhuang
 * @Date: 2024-08-26 16:25:58
 * @LastEditTime: 2025-03-05 17:55:22
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/main/views/main_page.dart
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_utils.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/navigation_bar/easy_bottom_navigation_bar.dart';
import 'package:xhs_app/components/popscope/easy_pop_scope.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/initAdvertisementInfo.dart';
import 'package:xhs_app/views/activity/activity_page.dart';
import 'package:xhs_app/views/main/controllers/main_controller.dart';
import 'package:xhs_app/views/main/views/tabs/home_tab.dart';
import 'package:xhs_app/views/mine/mine_page.dart';
import 'package:xhs_app/views/small_world/small_world_page.dart';

import '../../../assets/styles.dart';
import '../../../components/easy_button.dart';
import '../../selection/selection_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  BottomNavigationBarItem _buildBarItem({
    required String label,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: const SizedBox.shrink(),
    );
  }

  Widget initTabbar() {
    final homeContoller = Get.find<MainController>();
    return EasyBottomNavigationBar.common(
      currentIndex: homeContoller.currentIndex.value,
      onTap: homeContoller.changeMainTabIndex,
      items: [
        _buildBarItem(
          label: '首页',
        ),
        _buildBarItem(
          label: '精选',
        ),
        _buildBarItem(
          label: '活动',
        ),
        _buildBarItem(
          label: '萝莉岛',
        ),
        _buildBarItem(
          label: '我的',
        ),
      ],
    );
  }

  Widget _buildFixedAd() {
    return const SizedBox.shrink();
    // final rightAd =
    //     initWeightAdvertisementInfo(AdPlaceNameEnum.CORNER_LEVITATE);
    // if (rightAd == null) return const SizedBox.shrink();
    // ValueNotifier<bool> showRightAd = ValueNotifier(true);
    // return ValueListenableBuilder(
    //     valueListenable: showRightAd,
    //     builder: (context, value, child) {
    //       return value
    //           ? Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Icon(
    //                   Icons.cancel,
    //                   color: Colors.white,
    //                   size: 30.w,
    //                 ).onTap(() {
    //                   showRightAd.value = false;
    //                 }),
    //                 SizedBox(
    //                   height: 5.w,
    //                 ),
    //                 SizedBox(
    //                   width: 80.w,
    //                   height: 80.w,
    //                   child: ImageView(src: rightAd.adImage ?? ''),
    //                 ).onTap(() {
    //                   kAdjump(rightAd.adJump, rightAd.adId);
    //                 }),
    //               ],
    //             )
    //           : const SizedBox.shrink();
    //     });
  }

  ///底部广告
  Widget _buildBottomAd() {
    final bottomAd = adHelper.getAdInfo(AdApiTypeCompat.BOTTOM_BANNER);
    ValueNotifier<bool> showAd = ValueNotifier(true);
    return ValueListenableBuilder(
        valueListenable: showAd,
        builder: (context, value, child) {
          return Positioned(
            left: 12.w,
            right: 12.w,
            bottom: 3.w,
            height: 70.w,
            child: Visibility(
              visible: value && bottomAd != null,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6.w)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          5.w.horizontalSpace,
                          ImageView(
                            src: bottomAd?.adImage ?? '',
                            borderRadius: BorderRadius.circular(5.w),
                            width: 40.w,
                            height: 40.w,
                          ),
                          8.w.horizontalSpace,
                          Expanded(
                            child: Text(
                              bottomAd?.adName ?? '',
                              style: kTextStyle(Colors.white, fontsize: 12.w),
                              maxLines: 2,
                            ),
                          ),
                          EasyButton.child(
                            Text('下载',
                                style:
                                    kTextStyle(Colors.white, fontsize: 12.w)),
                            width: 55.w,
                            height: 20.w,
                            borderRadius: BorderRadius.circular(10.w),
                            backgroundColor: COLOR.playerThemeColor,
                          ),
                          5.w.horizontalSpace,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Icon(
                        Icons.cancel,
                        color: Colors.black,
                        size: 20.w,
                      ).onTap(() => showAd.value = false)),
                ],
              ).onTap(() => kAdjump(bottomAd)),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final homeContoller = Get.find<MainController>();
    return EasyPopScope.exit(
      child: SafeArea(
        top: false,
        bottom: kIsWeb ? true : false,
        child: Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          drawerEnableOpenDragGesture: false,
          drawer: _drawer(() {}, context),
          floatingActionButton: _buildFixedAd(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Stack(
            children: [
              Positioned.fill(
                child: Obx(
                  () => LazyLoadIndexedStack(
                    index: homeContoller.currentIndex.value,
                    preloadIndexes: const [2],
                    children: [
                      const HomeTab(),
                      const SelectionPage(),
                      const ActivityPage(isShowAd: false),
                      const SmallWorldPage(mark: 1),
                      MinePage(context: context),
                    ],
                  ),
                ),
              ),
              _buildBottomAd(),
            ],
          ),
          bottomNavigationBar: Obx(
            () => kIsWeb
                ? Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: initTabbar())
                : initTabbar(),
          ),
        ),
      ),
    );
  }

  // 侧边栏
  Widget _drawer(Function onClose, BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          // 使用ClipRRect来移除圆角
          borderRadius: BorderRadius.zero, // 确保没有圆角
          child: Container(
            width: 260.w,
            color: Colors.white,
            // 保持与默认drawer颜色一致
            child: Padding(
              padding: EdgeInsets.only(
                  left: 34.w, top: 78.w, bottom: 20.w, right: 0),
              child: Column(
                children: [
                  drawerListItem(
                      '作品中心', AppImagePath.mine_mine_draw_mine_works),
                  drawerListItem('私人团', AppImagePath.mine_mine_draw_private),
                  drawerListItem('我的购买', AppImagePath.mine_mine_draw_buy),
                  drawerListItem('我的下载', AppImagePath.mine_mine_draw_down),
                  drawerListItem(
                      '博主认证', AppImagePath.mine_mine_draw_authentication),
                  drawerListItem('开车群', AppImagePath.mine_mine_draw_car_group),
                  drawerListItem(
                      '应用中心', AppImagePath.mine_mine_draw_app_center),
                  const Expanded(child: SizedBox()),
                  Row(children: [
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.settingpage);
                        },
                        child: Column(children: [
                          ImageView(
                            src: AppImagePath.mine_mine_draw_setting,
                            width: 40.w,
                            height: 40.w,
                          ),
                          10.verticalSpace,
                          Text(
                            '设置',
                            style: TextStyle(
                                fontSize: 13.w, color: COLOR.color_666666),
                          ),
                        ])),
                    40.horizontalSpace,
                    GestureDetector(
                      onTap: () {},
                      child: Column(children: [
                        GestureDetector(
                          onTap: () => {kOnLineService()},
                          child: ImageView(
                            src: AppImagePath.mine_mine_draw_customer_service,
                            width: 40.w,
                            height: 40.w,
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          '客服',
                          style: TextStyle(
                              fontSize: 13.w, color: COLOR.color_666666),
                        ),
                      ]),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ),
        // 空白区域设置回调方式
        Expanded(
            child: GestureDetector(
          onTap: () {
            onClose();
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
          ),
        ))
      ],
    );
  }

  Widget drawerListItem(String title, String icon) {
    var controler = Get.find<MainController>();
    return Container(
      margin: EdgeInsets.only(bottom: 25.w),
      child: InkWell(
        highlightColor: COLOR.black.withOpacity(0.1),
        splashColor: COLOR.black.withOpacity(0.1),
        onTap: () {
          controler.onClick(title);
        },
        child: Row(
          children: [
            ImageView(
              src: icon,
              width: 22.w,
              height: 22.w,
            ),
            10.horizontalSpace,
            Text(
              title,
              style: TextStyle(fontSize: 13.w, color: COLOR.color_666666),
            ),
          ],
        ),
      ),
    );
  }
}
