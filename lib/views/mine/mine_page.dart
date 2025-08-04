import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/common_permission_alert.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/app_utils.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/mine_page_view/mine_collection_page.dart';
import 'package:xhs_app/views/mine/mine_page_view/mine_collection_product_logic.dart';
import 'package:xhs_app/views/mine/mine_page_view/mine_community_controller.dart';
import 'package:xhs_app/views/mine/mine_page_view/mine_community_view.dart';
import 'package:xhs_app/views/mine/mine_page_view/mine_resource_page.dart';

import '../../components/image_view.dart';
import '../../utils/logger.dart';
import '../../utils/utils.dart';
import 'mine_page_controller.dart';
import 'mine_page_view/mine_collection_comics_logic.dart';
import 'mine_page_view/mine_collection_commuty_logic.dart';
import 'mine_page_view/mine_resource_controller.dart';
import 'mine_releases/community_release_page.dart';

class MinePage extends StatefulWidget {
  final BuildContext context;

  const MinePage({super.key, required this.context});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with TickerProviderStateMixin {
  final controller = Get.put(MinePageController());
  var personControler = Get.find<MinePageController>();
  var logic1 = Get.put(CollecttionCommuntyLogic());
  var logic2 = Get.put(CollecttionProductLogic());
  var logic3 = Get.put(CollecttionComicsyLogic());

  final ScrollController _scrollController = ScrollController();
  bool _enableSearchState = false;

  void disableScroll() => setState(() => _enableSearchState = true);

  void enableScroll() => setState(() => _enableSearchState = false);

  double toolBarHeight() => !_enableSearchState ? 50.w : 100.w;
  final searchTextController = TextEditingController();
  late final _tabController;

  // late PageController _pageController;
  final currentIndex = 0.obs;
  final focusNode = FocusNode();
  final tabs = ['笔记', '收藏', '资源'];

  final pageViews = [
    const MineCommunityView().keepAlive,
    const MineCollectionPage().keepAlive,
    const MineResourcePage().keepAlive,
  ];

  // int _currentIndex = 0;
  Widget _buildUserInfoView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _top,
        SizedBox(
          height: 16.w,
        ),
        // 简介 todo 判断是否有简介
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              SizedBox(
                width: 330.w,
                child: Text(
                  controller.userService.user.personSign!.isNotEmpty
                      ? controller.userService.user.personSign!
                      : '暂时还没有简介',
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, letterSpacing: 0.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.w,
        ),
        _mid,
        SizedBox(
          height: 26,
        ),
        _bottom
      ],
    );
  }

  get _top {
    return Row(
      children: [
        SizedBox(
          width: 14.w,
        ),
        GestureDetector(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(40.w),
              child: SizedBox(
                width: 80.w,
                height: 80.w,
                child: Obx(
                  () => ImageView(
                    src: "${controller.userService.user.logo}",
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(40.w),
                    defaultPlace: AppImagePath.icon_avatar,
                  ).onTap(() {
                    if (controller.userService.user.account == null ||
                        controller.userService.user.account!.isEmpty) {
                      controller.onClick("登录");
                    } else {
                      controller.onClick("编辑资料");
                    }
                  }),
                ),
              )),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Row(children: [
                  TextView(
                    text: controller.userService.user.nickName ?? '游客0000',
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                    color: COLOR.white,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  3.horizontalSpace,
                  controller.userService.isVIP
                      ? ImageView(
                          src: AppUtils.getVipTypeToImagePath(
                              controller.userService.user.vipType ?? 0),
                          width: 40.w,
                          height: 16.w,
                        ).onTap(() {
                          Get.toVip(tabInitIndex: 0);
                        })
                      : SizedBox()
                ])),
            6.verticalSpace,
            Obx(() => TextView(
                  text: '用户ID：${controller.userService.user.userId}',
                  fontSize: 12.w,
                  color: COLOR.white.withOpacity(0.6),
                )),
            6.verticalSpace,
            Container(
              height: 21.w,
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4.w)),
              alignment: Alignment.center,
              child: Text(
                '每日下载剩余次数 ${controller.userService.user.resourcesResidueNum}',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12.w,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        )
      ],
    );
  }

  get _mid {
    return Container(
      width: 360.w,
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(() => midNumWidget(
                      Utils.numFmt(controller.userService.user.bu ?? 0), "粉丝",
                      onTap: () {
                    controller.onClick("粉丝");
                  })),
              20.horizontalSpace,
              Obx(() => midNumWidget(
                      Utils.numFmt(controller.userService.user.ua ?? 0), "关注",
                      onTap: () {
                    controller.onClick("关注");
                  })),
              20.horizontalSpace,
              Obx(() => midNumWidget(
                      Utils.numFmt(controller.userService.user.likedNum ?? 0),
                      "收藏", onTap: () {
                    controller.onClick("收藏");
                  })),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => GestureDetector(
                  // onTap: editmess(),
                  onTap: () {
                    (controller.userService.user.account ?? "").isEmpty
                        ? controller.onClick("登录")
                        : controller.onClick("编辑资料");
                  },
                  child: Container(
                    // width: 85.w,
                    height: 32.w,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.w),
                        color: COLOR.white.withOpacity(0.1),
                        border: Border.all(
                          color: COLOR.white.withOpacity(0.51),
                          width: 1,
                        )),
                    child: Center(
                        child: Text(
                      (controller.userService.user.account ?? "").isEmpty
                          ? "登录"
                          : "编辑资料",
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.8,
                          fontSize: 14),
                    )),
                  ),
                ),
              ),
              10.horizontalSpace,
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.settingpage);
                },
                child: Container(
                  width: 47.w,
                  height: 32.w,
                  child: Center(
                      child: ImageView(
                    src: AppImagePath.mine_mine_setting_button,
                    width: 47.w,
                    height: 32.w,
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  get _bottom {
    return Padding(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          bottomItemWidget(
            "会员中心",
            AppImagePath.mine_mine_vip_center,
            '专属会员权益',
            onTap: () {
              Get.toVip(tabInitIndex: 0);
            },
          ),
          SizedBox(
            width: 10.w,
          ),
          bottomItemWidget(
            "我的钱包",
            AppImagePath.mine_mine_money,
            '立即充值金币',
            onTap: () {
              Get.toVip(tabInitIndex: 1);
            },
          ),
          SizedBox(
            width: 10.w,
          ),
          bottomItemWidget(
            "浏览记录",
            AppImagePath.mine_mine_history,
            '看过的笔记',
            onTap: () {
              Get.toNamed(Routes.minerecord);
            },
          ),
        ]));
  }

  Widget midNumWidget(String topText, String bottomText,
      {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Text(
            topText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.w,
                fontWeight: FontWeight.w600),
          ).marginOnly(bottom: 2.w),
          Text(
            bottomText,
            style: TextStyle(
                color: COLOR.white.withOpacity(0.6),
                fontSize: 11.w,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget bottomItemWidget(String topText, String icon, String bottomText,
      {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
          width: 106.w,
          height: 48.w,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.w),
          decoration: BoxDecoration(
              color: COLOR.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8.w)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ImageView(
                    src: icon,
                    width: 16.w,
                    height: 16.w,
                  ),
                  Text(
                    topText,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.w,
                        fontWeight: FontWeight.w600),
                  ).marginOnly(left: 2.w),
                ],
              ),
              Text(
                bottomText,
                style: TextStyle(
                    color: COLOR.white.withOpacity(0.6),
                    fontSize: 11.w,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    // _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addFastListener((int i) {
    //   onChangeTabIndex(i);
    // });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        clickSearchState(true);
      }
    });
    Get.lazyPut<MineResourceController>(() => MineResourceController());
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: (info) {
        final value = info.visibleFraction;
        logger.d('visibility >>>> $value');
        if (value == 1.0) {
          personControler.userService.updateAll();
        }
      },
      child: Scaffold(
        body: _bodyView(),
      ),
    );
  }

  _bodyView() {
    return NestedScrollView(
      controller: _scrollController,
      physics: !_enableSearchState
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            expandedHeight: 340.w,
            backgroundColor: const Color.fromARGB(255, 110, 89, 91),
            //获取渐变图片或者默认渐变色
            leading: Builder(builder: (context) {
              return SizedBox(
                width: 22.w,
                height: 22.w,
                child: Center(
                  child: ImageView(
                    src: AppImagePath.mine_mine_menu,
                    width: 22.w,
                    height: 22.w,
                    // fit: BoxFit.cover,
                  ).onTap(() {
                    Scaffold.of(this.context).openDrawer();
                  }),
                ),
              );
            }),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 41, 52, 74),
                    Color.fromARGB(255, 110, 89, 91),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  // 图片全尺寸显示
                  Positioned.fill(child: Container()),
                  Positioned(
                    top: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        20.w,
                    child: _buildUserInfoView(),
                  )
                ],
              ),
            )),
            actions: [
              Badge(
                isLabelVisible: true,
                backgroundColor: Colors.redAccent,
                child: ImageView(
                  src: AppImagePath.mine_mine_notice,
                  width: 22.w,
                  height: 22.w,
                ).onTap(() {
                  Get.toNamed(Routes.minesmessageinformation);
                }),
              ).marginOnly(right: 24.w),
              ImageView(
                src: AppImagePath.mine_mine_share,
                width: 22.w,
                height: 22.w,
              ).onTap(() {
                Get.toNamed(Routes.share);
              }).marginOnly(right: 14.w),
            ],
          ),
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color.fromARGB(255, 110, 89, 91),
            primary: false,
            // automaticallyImplyLeading: true,
            leadingWidth: 0,
            leading: null,
            toolbarHeight: toolBarHeight(),
            titleSpacing: 0,
            title: Container(
              width: double.infinity,
              height: toolBarHeight(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.w),
                  topRight: Radius.circular(8.w),
                ),
              ),
              child: Column(
                children: [
                  if (_enableSearchState) _buildSearchView(),
                  _buildTabBar(),
                ],
              ),
            ),
            // 后续有无图片 颜色渐变
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: pageViews,
      ),
    );
  }

  _buildSearchView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
                // width: 296.w,
                height: 30.w,
                margin: EdgeInsets.only(left: 20.w, top: 12.w, bottom: 8.w),
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: COLOR.color_F8F8F8,
                  borderRadius: BorderRadius.circular(15.w),
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageView(
                      src: AppImagePath.mine_mine_search,
                      width: 16.w,
                      height: 16.w,
                    ),
                    Padding(padding: EdgeInsets.only(left: 8.w)),
                    Expanded(
                        child: TextField(
                      focusNode: focusNode,
                      style:
                          TextStyle(color: COLOR.color_333333, fontSize: 14.w),
                      controller: searchTextController,
                      onChanged: (value) {
                        startSearch(value);
                      },
                      decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: "请输入搜索内容",
                          hintStyle: TextStyle(
                              color: COLOR.hexColor('#898A8E'), fontSize: 14.w),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0))),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0)))),
                    ))
                  ],
                ))),
        GestureDetector(
          onTap: () {
            clickSearchState(false);
          },
          child: Text(
            '取消',
            style: TextStyle(color: COLOR.color_999999, fontSize: 15.w),
          ),
        ).paddingHorizontal(14.w)
      ],
    );
  }

  _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 235.w,
            height: 50.w,
            margin: EdgeInsets.only(left: 5.w),
            child: DefaultTabController(
              length: tabs.length,
              initialIndex: 0,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildClassifyTabBar(),
                  ],
                ),
              ),
            )),
        if (!_enableSearchState)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ///搜索按钮
              ImageView(
                src: AppImagePath.mine_mine_search,
                width: 22.w,
                height: 22.w,
              ).onTap(() async {
                clickSearchState(true);
              }).marginOnly(right: 18.w),
              Container(
                width: 64.w,
                height: 34.w,
                margin: EdgeInsets.only(right: 14.w),
                decoration: BoxDecoration(
                  color: COLOR.color_FB2D45,
                  borderRadius: BorderRadius.circular(17.w),
                ),
                child: Center(
                  child: Text(
                    "发布",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.w,
                    ),
                  ),
                ),
              ).onTap(() {
                openReleaseApp();
              })
            ],
          )
      ],
    );
  }

  _buildClassifyTabBar() {
    return SizedBox(
      width: 240.w,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: tabs
            .mapIndexed(
              (i, e) => Tab(text: e),
            )
            .toList(),
        dividerHeight: 0,
        indicator: EasyFixedIndicator(
          color: COLOR.color_FB2D45,
          height: 2.w,
          borderRadius: Styles.borderRadius.all(2.w),
        ),
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsets.only(left: 9.w, right: 9.w),
        indicatorPadding: EdgeInsets.only(bottom: 8.w),
        labelStyle: const TextStyle(
          fontSize: 16,
          color: COLOR.primaryText,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: COLOR.color_999999,
        ),
      ),
    );
  }

  Future<void> clickSearchState(bool isSearch) async {
    await _scrollController.animateTo(
        isSearch ? 340.w - kToolbarHeight - 15.w : 0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut);
    if (isSearch) {
      disableScroll();
    } else {
      focusNode.unfocus();
      enableScroll();
    }
    // startSearch(searchTextController.text);
  }

  openReleaseApp() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            height: 240.w,
            decoration: BoxDecoration(
              color: COLOR.hexColor("#f8f8f8"),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.w),
                topRight: Radius.circular(6.w),
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 162.w, top: 16.w),
                        child: TextView(
                          text: "发布",
                          fontSize: 16.w,
                          color: COLOR.color_333333,
                          fontWeight: FontWeight.w600,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 6.w, right: 14.w),
                      child: Image.asset(
                        AppImagePath.community_community_delete,
                        width: 20.w,
                        height: 20.w,
                      ),
                    ).onOpaqueTap(() {
                      Navigator.pop(context);
                    }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          AppImagePath.community_community_release_image,
                          width: 56.w,
                          height: 56.w,
                        ),
                        Text(
                          '发布视频',
                          style: TextStyle(
                            color: COLOR.color_333333,
                            fontSize: 13.w,
                          ),
                        ).marginOnly(top: 4.w),
                      ],
                    ).onOpaqueTap(() {
                      if (Get.find<UserService>().isVIP == false) {
                        permission_alert(
                          Get.context!,
                          desc: "VIP用户才可以发布哦!",
                        );
                        return;
                      }
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CommunityReleasePage(
                                    dataType: 2,
                                  )));
                    }),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          AppImagePath.community_community_release_video,
                          width: 56.w,
                          height: 56.w,
                        ),
                        Text(
                          '发布图文',
                          style: TextStyle(
                            color: COLOR.color_333333,
                            fontSize: 13.w,
                            fontWeight: FontWeight.w400,
                          ),
                        ).marginOnly(top: 4.w),
                      ],
                    ).onOpaqueTap(() {
                      if (Get.find<UserService>().isVIP == false) {
                        permission_alert(
                          Get.context!,
                          desc: "VIP用户才可以发布哦!",
                        );
                        return;
                      }
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CommunityReleasePage(
                                    dataType: 1,
                                  )));
                    }),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          AppImagePath.community_community_release_resource,
                          width: 56.w,
                          height: 56.w,
                        ),
                        Text(
                          '发布资源',
                          style: TextStyle(
                            color: COLOR.color_333333,
                            fontSize: 13.w,
                            fontWeight: FontWeight.w400,
                          ),
                        ).marginOnly(top: 4.w),
                      ],
                    ).onOpaqueTap(() {
                      if (Get.find<UserService>().isVIP == false) {
                        permission_alert(
                          Get.context!,
                          desc: "VIP用户才可以发布哦!",
                        );
                        return;
                      }
                      Navigator.pop(context);
                      Get.toNamed(Routes.communityResourceRelease);
                    }),
                  ],
                ).marginOnly(left: 36.w, right: 36.w, top: 30.w),
                Padding(
                    padding:
                        EdgeInsets.only(left: 18.w, top: 16.w, right: 18.w),
                    child: TextView(
                      text: "温馨提示：认证博主后才可发布金币视频笔记，创建粉丝团，创建合集等赚取丰厚收益",
                      fontSize: 12.w,
                      textAlign: TextAlign.center,
                      color: COLOR.color_999999,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
          );
        });
  }

  startSearch(String value) {
    String tabTitle = tabs[_tabController.index];
    if (tabTitle == '笔记') {
      var controller = Get.find<MineCommunityController>();
      controller.searchWord.value = value;
      controller.onRefresh();
    } else if (tabTitle == '收藏') {
      if (personControler.current_collect_index == 0) {
        //笔记
        var controller = Get.find<CollecttionCommuntyLogic>();
        controller.searchWord.value = value;
        controller.pagingControllers.refresh();
      } else if (personControler.current_collect_index == 1) {
        //商品
        var controller = Get.find<CollecttionProductLogic>();
        controller.searchWord.value = value;
        controller.pagingControllers.refresh();
      } else if (personControler.current_collect_index == 2) {
        //漫画
        var controller = Get.find<CollecttionComicsyLogic>();
        controller.searchWord.value = value;
        controller.pagingControllers.refresh();
      }
    } else if (tabTitle == '资源') {
      var controller = Get.find<MineResourceController>();
      controller.searchWord.value = value;
      controller.onRefresh();
    }
  }
}
