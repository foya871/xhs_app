import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/mine_page_view/mine_collection_view.dart';

import '../../../assets/styles.dart';
import '../mine_page_controller.dart';
import 'mine_collection_comics_logic.dart';
import 'mine_collection_commuty_logic.dart';
import 'mine_collection_product_logic.dart';

class MineCollectionPage extends StatefulWidget {
  const MineCollectionPage({super.key});

  @override
  State<MineCollectionPage> createState() => _MineCollectionPageState();
}

class _MineCollectionPageState extends State<MineCollectionPage>
    with SingleTickerProviderStateMixin {
  final BJcontroller = Get.put(CollecttionCommuntyLogic());
  final productController = Get.put(CollecttionProductLogic());
  final MHController = Get.put(CollecttionComicsyLogic());

  var personControler = Get.find<MinePageController>();

// 创建 TabController 并指定长度
  late TabController _tabController;
  final List tabs = [
    '笔记·0',
    '商品·0',
    '漫画·0',
  ];

  @override
  void initState() {
    super.initState();

    BJcontroller.pagingControllers.refresh();
    productController.firstRequest();
    MHController.firstRequest();

    _tabController = TabController(length: 3, vsync: this);
    // 监听 TabController 的变化
    _tabController.addListener(() {
      personControler.current_collect_index = _tabController.index;
    });
  }

  Widget initList(String v) {
    return MineCollectionView(
      title: v,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              MineCollectCommuntyView(), //笔记
              MineCollectProductView().keepAlive, //商品
              MineCollectionView(title: '').keepAlive, //漫画
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
        height: 48.w,
        alignment: Alignment.centerLeft,
        child: Obx(() {
          return TabBar(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorColor: COLOR.hexColor('ffffff'),
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
              dividerColor: Colors.transparent,
              labelPadding: EdgeInsets.only(left: 9.w, right: 9.w),
              indicatorPadding: EdgeInsets.only(bottom: 8.w),
              indicator: EasyFixedIndicator(
                color: COLOR.color_FB2D45,
                height: 2.w,
                borderRadius: Styles.borderRadius.all(2.w),
              ),
              tabs: tabs.mapIndexed((i, e) {
                if (i == 0) {
                  return Tab(text: '笔记·${BJcontroller.total}');
                } else if (i == 1) {
                  return Tab(text: '商品·${productController.total}');
                } else {
                  return Tab(text: '漫画·${MHController.total}');
                }
              }).toList());
        }));
  }
}
