/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-10-16 21:15:53
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-10-16 21:42:18
 * @FilePath: /xhs_app/lib/src/views/mine/favorite/views/favorite_game.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/adult_game_cell/adult_game_cell.dart';
import 'package:xhs_app/components/keep_alive_wrapper.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_more.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/adult_game_model/adult_game_model.dart';

class FavoriteGame extends StatefulWidget {
  final bool isBuy;
  const FavoriteGame({super.key, this.isBuy = true});

  @override
  State<FavoriteGame> createState() => _FavoriteGame();
}

class _FavoriteGame extends State<FavoriteGame> {
  final _pageSize = 10;
  final PagingController<int, AdultGameModel> _pagingController =
      PagingController(firstPageKey: 1);

  Future _initListData(int pageKey) async {
    final dynamic = await httpInstance.get<AdultGameModel>(
        url: widget.isBuy
            ? 'adultgame/getBuyGameRecord'
            : 'adultgame/queryUserFavoriteGames',
        queryMap: {
          'pageSize': _pageSize,
          'page': pageKey,
        },
        complete: AdultGameModel.fromJson);
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
        child: PagedListView<int, AdultGameModel>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<AdultGameModel>(
            noMoreItemsIndicatorBuilder: (_) {
              return const NoMore();
            },
            noItemsFoundIndicatorBuilder: (_) {
              return const NoData();
            },
            itemBuilder: (context, item, index) => Container(
              margin: EdgeInsets.only(
                  top: 5.w, left: 14.w, right: 14.w, bottom: 10.w),
              child: AdultGameCell(
                game: item,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
