import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/keep_alive_wrapper.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_more.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/community/community_model.dart';

class FavoriteCommunity extends StatefulWidget {
  final bool isBuy;
  const FavoriteCommunity({super.key, this.isBuy = true});

  @override
  State<FavoriteCommunity> createState() => _FavoriteCommunity();
}

class _FavoriteCommunity extends State<FavoriteCommunity> {
  final _pageSize = 10;
  final PagingController<int, CommunityModel> _pagingController =
      PagingController(firstPageKey: 1);

  Future _initListData(int pageKey) async {
    final dynamic = await httpInstance.get<CommunityModel>(
        url: widget.isBuy
            ? 'community/dynamic/user/purList'
            : 'community/dynamic/userFavorite',
        queryMap: {
          'pageSize': _pageSize,
          'page': pageKey,
        },
        complete: CommunityModel.fromJson);
    final isLastPage = dynamic.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(dynamic);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(dynamic, nextPageKey as int?);
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _initListData(pageKey);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, CommunityModel>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<CommunityModel>(
            noMoreItemsIndicatorBuilder: (_) {
              return const NoMore();
            },
            noItemsFoundIndicatorBuilder: (_) {
              return const NoData();
            },
            itemBuilder: (context, item, index) => Container(
              margin: EdgeInsets.only(top: 10.w, bottom: 10.w),
              // child: CommunityCell(
              //   data: item,
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
