import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../components/base_paged/base_paged_child_builder_delegate.dart';
import '../../../components/comics_cell/comics_cell.dart';
import '../../../components/safe_state.dart';
import '../../../http/api/api.dart';
import '../../../model/comics/comics_base.dart';
import '../../../model/community/community_base_model.dart';
import '../../../utils/color.dart';
import '../../../utils/consts.dart';
import '../../community/common/base/community_base_cell.dart';

class CollectionViewController {
  _State? _state;
  void refresh() => _state?.refresh();
}

class CollectionView extends StatefulWidget {
  final int userId;
  final String Function() searchQueryGetter;
  final CollectionViewController? controller;
  const CollectionView(
      {super.key,
      required this.userId,
      required this.searchQueryGetter,
      this.controller});
  @override
  State<CollectionView> createState() => _State();
}

class _State extends SafeState<CollectionView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final notePagingController =
      PagingController<int, CommunityBaseModel>(firstPageKey: Consts.pageFirst);
  final commodityPagingController =
      PagingController<int, ComicsBaseModel>(firstPageKey: Consts.pageFirst);
  final List<Tab> tabs = [const Tab(text: '笔记'), const Tab(text: '商品')];
  static const noteTabIndex = 0;
  static const commodityTabIndex = 1;

  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
    notePagingController.addPageRequestListener(_getCollectionNote);
    commodityPagingController.addPageRequestListener(_getCollectionCommodity);
    widget.controller?._state = this;
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?._state = null;
    notePagingController.dispose();
    commodityPagingController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void refresh() => switch (tabController.index) {
        noteTabIndex => notePagingController.refresh(),
        commodityTabIndex => commodityPagingController.refresh(),
        _ => () {},
      };

  void _getCollectionNote(int page) async {
    final resp = await Api.getBloggerCollectionNoteList(
      userId: widget.userId,
      page: page,
      searchWord: widget.searchQueryGetter(),
    );
    if (resp.isNotEmpty) {
      notePagingController.appendPage(resp, page + 1);
    } else {
      notePagingController.appendLastPage(resp);
    }
  }

  void _getCollectionCommodity(int page) async {
    final resp = await Api.getBloggerCollectionCommodityList(
      userId: widget.userId,
      page: page,
      searchWord: widget.searchQueryGetter(),
    );
    if (resp.isNotEmpty) {
      commodityPagingController.appendPage(resp, page + 1);
    } else {
      commodityPagingController.appendLastPage(resp);
    }
  }

  Widget _buildTabBar() => TabBar(
        controller: tabController,
        tabs: tabs,
        labelColor: COLOR.black,
        tabAlignment: TabAlignment.start,
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
      );

  Widget _buildTabNoteView() => PagedMasonryGridView.count(
        pagingController: notePagingController,
        crossAxisCount: 2,
        builderDelegate: BasePagedChildBuilderDelegate<CommunityBaseModel>(
          itemBuilder: (context, item, index) => CommunityBaseCell(item),
        ),
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 4.w,
        padding: EdgeInsets.only(top: 10.w),
      );

  Widget _buildTabCommodityView() => PagedMasonryGridView.count(
        pagingController: commodityPagingController,
        crossAxisCount: 2,
        builderDelegate: BasePagedChildBuilderDelegate<ComicsBaseModel>(
          itemBuilder: (context, item, index) => ComicsCell(model: item),
        ),
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 4.w,
        padding: EdgeInsets.only(top: 10.w),
      );

  Widget _buildTabBarView() => TabBarView(
        controller: tabController,
        children: [
          _buildTabNoteView(),
          _buildTabCommodityView(),
        ],
      );

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabBar(),
          Expanded(child: _buildTabBarView()),
        ],
      );
}
