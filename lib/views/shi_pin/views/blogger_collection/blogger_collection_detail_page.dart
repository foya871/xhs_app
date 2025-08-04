import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/app_bar/extend_transparent_app_bar.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../components/base_refresh/base_refresh_tab_widget.dart';
import '../../../../components/circle_image.dart';
import '../../../../components/easy_button.dart';
import '../../../../components/image_view.dart';
import '../../../../components/no_more/no_data_sliver_list.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/blogger/blogger_video_collection.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../../utils/utils.dart';
import '../../../mine/watch/views/item_video_long_view.dart';
import '../../controllers/blogger_collection/blogger_collection_detail_page_controller.dart';

class BloggerCollectionDetailPage
    extends GetView<BloggerCollectionDetailPageController> {
  const BloggerCollectionDetailPage({super.key});

  AppBar _buildAppBar() => ExtendTransparentAppBar(title: const Text('合集详情'));

  Widget _buildProfileLeft(CollectionDetailModel detail) => ImageView(
        src: detail.coverImg,
        width: 114.w,
        height: 114.w,
      );

  Widget _buildProfileRight(CollectionDetailModel detail) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.collectionName,
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500),
          ),
          10.verticalSpaceFromWidth,
          Row(
            children: [
              CircleImage.network(detail.logo, size: 34.w),
              8.horizontalSpace,
              Text(detail.nickName, style: TextStyle(fontSize: 11.w))
            ],
          ),
          8.verticalSpaceFromWidth,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImagePath.shi_pin_video_num,
                    width: 12.w,
                    height: 12.w,
                  ),
                  4.horizontalSpace,
                  Text(
                    '作品数量：${Utils.numFmt(detail.videoNum, upper: true)}',
                    style: TextStyle(color: COLOR.color_DBDBDB, fontSize: 11.w),
                  ),
                ],
              ).onOpaqueTap(() => Get.toBloggerDetail(userId: detail.userId)),
              EasyButton(
                detail.favorite ? '已收藏' : '收藏',
                width: 68.w,
                height: 30.w,
                backgroundColor: detail.favorite ? null : COLOR.color_FEF100,
                borderColor: detail.favorite ? COLOR.white : null,
                borderWidth: detail.favorite ? 1.w : null,
                borderRadius: Styles.borderRadius.all(16.w),
                textStyle: TextStyle(
                  color: detail.favorite ? COLOR.white : COLOR.black,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                ),
                onTap: controller.toogleFavorite,
              )
            ],
          )
        ],
      ).marginOnly(top: 4.w, bottom: 2.w);

  Widget _buildProfie() => Obx(
        () {
          final detail = controller.detail.value;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfileLeft(detail),
              10.horizontalSpace,
              Expanded(child: _buildProfileRight(detail))
            ],
          );
        },
      );

  Widget _buildTabBar() => TabBar(
        tabs: BloggerCollectionDetailPageController.sortTabs
            .map((e) => Tab(text: e.item1))
            .toList(),
        dividerHeight: 0,
        indicator: const BoxDecoration(),
        labelStyle: TextStyle(
            color: COLOR.color_DDDDDD,
            fontSize: 14.w,
            fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(
          color: COLOR.color_808080,
          fontSize: 14.w,
        ),
        padding: EdgeInsets.zero,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsets.symmetric(horizontal: 10.5.w),
      );

  Widget _buildTabBarView() => TabBarView(
        children: BloggerCollectionDetailPageController.sortTabs.mapIndexed(
          (i, e) {
            final tabKey = BaseRefreshTabIndexKey(i);
            return BaseRefreshTabWidget(
              controller,
              tabKey: tabKey,
              child: CustomScrollView(
                slivers: [
                  Obx(
                    () {
                      final data = controller.getData(tabKey);
                      return NoDataSliverList.separated(
                        itemCount: data.length,
                        itemBuilder: (ctx, i) {
                          return ItemVideoLongView(data[i]);
                        },
                        separatorBuilder: (ctx, i) => 15.verticalSpaceFromWidth,
                        noData: controller.dataInited(tabKey),
                      );
                    },
                  ),
                ],
              ),
            ).keepAlive;
          },
        ).toList(),
      ).baseMarginHorizontal;

  Widget _buildVideosBlock() => Container(
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadius.all(16.w),
          color: COLOR.scaffoldBg,
        ),
        child: DefaultTabController(
          length: BloggerCollectionDetailPageController.sortTabs.length,
          child: Column(
            children: [
              _buildTabBar().marginHorizontal(30.w),
              Expanded(child: _buildTabBarView()),
            ],
          ),
        ),
      );

  Widget _buildBackground(double height) => Stack(
        children: [
          Obx(
            () => ImageView(
              src: controller.detail.value.coverImg,
              height: height,
              width: 1.sw,
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: COLOR.color_232323.withOpacity(0.65),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final appBar = _buildAppBar();
    final statusBarHeight = ScreenUtil().statusBarHeight;
    final appBarHeight = appBar.preferredSize.height;
    final profileHeight = 114.w;
    final backgroundHeight =
        statusBarHeight + appBarHeight + profileHeight + 40.w;
    final profileOffset = statusBarHeight + appBarHeight;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Stack(
        children: [
          SizedBox(width: 1.sw, height: 1.sh),
          Positioned(
            top: 0,
            child: _buildBackground(backgroundHeight),
          ),
          Positioned(
            top: profileOffset,
            width: 1.sw,
            height: 1.sh - profileOffset,
            child: Column(
              children: [
                _buildProfie().marginHorizontal(20.w),
                15.verticalSpaceFromWidth,
                Expanded(child: _buildVideosBlock()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
