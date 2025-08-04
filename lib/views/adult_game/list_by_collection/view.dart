import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/adult_game_cell/adult_game_cell.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/model/adult_game_collection_model/adult_game_collection_model.dart';
import 'package:xhs_app/model/adult_game_model/adult_game_model.dart';
import 'package:xhs_app/repositories/adult_game.dart';
import 'package:xhs_app/routes/routes.dart';

import 'controller.dart';

class _ListByCollectionView extends StatefulWidget {
  const _ListByCollectionView({super.key, required this.gameCollectionId});

  final int gameCollectionId;

  @override
  State<_ListByCollectionView> createState() => __ListByCollectionViewState();
}

class __ListByCollectionViewState extends State<_ListByCollectionView> {
  final refreshController = EasyRefreshController();

  List<AdultGameModel> list = [];

  int page = 1;

  /// 主机类型:1-安卓 2-pc 3-Ios
  List<int> hostTypes = [0, 1, 2, 3];

  List<String> hostTypeNames = ["全部", "安卓", "PC", "iOS"];

  int _hostType = 0;

  @override
  void initState() {
    super.initState();

    initList();
  }

  void initList() async {
    var result = await AdultGamesRepositoryImpl()
        .fetchAdultGameListByCollection(page,
            gameCollectionId: widget.gameCollectionId,
            hostType: _hostType == 0 ? null : _hostType);

    final isFinish = result.length < 10;

    if (page == 1) {
      setState(() {
        list = result;
      });
    } else {
      setState(() {
        list = [...list, ...result];
      });
    }

    refreshController.finishRefresh(
        isFinish ? IndicatorResult.noMore : IndicatorResult.success, true);
  }

  void fetchMore() {
    page += 1;

    initList();
  }

  void fetchFresh() {
    page = 1;

    initList();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  void _filter(int type) {
    page = 1;
    _hostType = type;
    initList();
  }

  Widget _bildFilter() {
    Color red = const Color(0xffdd001b);
    BoxBorder redBorder = Border.all(color: red);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 14.w),
      color: const Color(0xfff1f1f1).withOpacity(0.63),
      child: Row(
        children: [
          ...hostTypeNames.asMap().entries.map((entrie) => GestureDetector(
              onTap: () {
                _filter(entrie.key);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.w, horizontal: 10.w),
                decoration: BoxDecoration(
                    border: entrie.key == _hostType ? redBorder : null,
                    borderRadius: BorderRadius.circular(12.w)),
                child: Text(
                  entrie.value,
                  style: TextStyle(
                      // fontSize: 11.w,
                      color: entrie.key == _hostType
                          ? red
                          : const Color(0xff666666),
                      letterSpacing: 0.34.w),
                ),
              )))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const Text("hello"),
        SizedBox(
          height: 4.w,
        ),
        _bildFilter(),
        SizedBox(
          height: 14.w,
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: EasyRefresh(
              onRefresh: () {
                fetchFresh();
              },
              onLoad: () {
                fetchMore();
              },
              controller: refreshController,
              child: MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                padding: const EdgeInsets.all(0),
                mainAxisSpacing: 15.w,
                crossAxisSpacing: 0,
                // controller: _scrollController,
                // primary: true,
                itemCount: list.length,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return AdultGameCell(game: list[index]);
                  // return Text(
                  //   "${list[index].gameId!}",
                  //   style: const TextStyle(color: Colors.red),
                  // );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AdultGameListByCollectionPage extends StatefulWidget {
  const AdultGameListByCollectionPage({super.key});

  @override
  State<AdultGameListByCollectionPage> createState() =>
      _AdultGameListByCollectionPageState();
}

class _AdultGameListByCollectionPageState
    extends State<AdultGameListByCollectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  AdultGameListCollectionController controller =
      Get.put(AdultGameListCollectionController());

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await controller.initCollectionList();
    _tabController = TabController(
        initialIndex: 0, length: controller.collectionList.length, vsync: this);

    // _tabController.addListener(() {
    //   controller.changeActiveCollectionIndex(_tabController.index);
    // });
  }

  Widget _buildTabBar() {
    Color redColor = const Color(0xffdd001b);

    return GetBuilder<AdultGameListCollectionController>(
        init: controller,
        builder: (controller) {
          return TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: redColor,
              unselectedLabelColor: const Color(0xff333333),
              // indicatorColor: redColor,

              labelStyle:
                  TextStyle(fontSize: 16.w, fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500),
              dividerColor: Colors.transparent,
              controller: _tabController,
              indicatorPadding: EdgeInsets.only(bottom: 6.w),
              indicator: EasyFixedIndicator(
                  color: redColor,
                  width: 10.w,
                  height: 3.w,
                  borderRadius: BorderRadius.circular(1.5)),
              tabs: controller.collectionList
                  .map((e) => Tab(
                        text: e.gameCollectionName,
                      ))
                  .toList());
        });
  }

  Widget _buildList(AdultGameCollectionModel collection) {
    return _ListByCollectionView(
      gameCollectionId: collection.gameCollectionId!,
    );
  }

  void jump2Search() {
    Get.toNamed(Routes.audltGameSearchHot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        actions: [
          TextButton(
              onPressed: () {
                jump2Search();
              },
              child: Text(
                "搜索",
                style: TextStyle(
                    color: const Color(0xff333333),
                    fontSize: 16.w,
                    fontWeight: FontWeight.w700),
              ))
        ],
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  jump2Search();
                },
                child: Container(
                  height: 38,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: const Color(0xfff5f5f5),
                      borderRadius: BorderRadius.all(Radius.circular(19.w))),
                  padding:
                      EdgeInsets.symmetric(vertical: 7.w, horizontal: 15.w),
                  child: Text(
                    "搜索喜欢的游戏",
                    style: TextStyle(
                        fontSize: 13.w, color: const Color(0xff999999)),
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff999999),
            size: 18,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<AdultGameListCollectionController>(
        init: controller,
        builder: (controller) {
          return Column(
            children: controller.collectionList.isNotEmpty
                ? [
                    _buildTabBar(),
                    Expanded(
                        child: TabBarView(
                            controller: _tabController,
                            children: controller.collectionList
                                .map((e) => _buildList(e))
                                .toList()))
                  ]
                : [],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
