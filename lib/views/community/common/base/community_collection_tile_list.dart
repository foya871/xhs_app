import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/base_refresh/stateful/base_refresh_simple_state.dart';
import '../../../../components/base_refresh/stateful/base_refresh_simple_state_widget.dart';
import '../../../../components/no_more/no_data_list_view.dart';
import '../../../../http/api/api.dart';
import '../../../../model/community/community_base_model.dart';
import '../../../../utils/enum.dart';
import 'community_base_tile_cell.dart';

const _pageSize = 60;

class CommunityCollectionTileList extends StatefulWidget {
  final String collectionName;
  final int? userId;
  final bool removeTopPadding;
  final Color? cellBackgroundColor;
  final EdgeInsets? cellPadding;
  final ValueCallback<CommunityBaseModel>? cellOnTap;

  const CommunityCollectionTileList(
    this.collectionName, {
    super.key,
    this.userId,
    this.removeTopPadding = true,
    this.cellBackgroundColor,
    this.cellPadding,
    this.cellOnTap,
  });
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends BaseRefreshSimpleState<CommunityCollectionTileList,
    CommunityBaseModel> {
  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
        context: context,
        removeTop: widget.removeTopPadding,
        child: BaseRefreshSimpleStateWidget(
          this,
          child: NoDataListView.separated(
            itemCount: data.length,
            itemBuilder: (context, index) => CommunityBaseTileCell(
              data[index],
              backgroundColor: widget.cellBackgroundColor,
              padding: widget.cellPadding,
              onTap: widget.cellOnTap != null
                  ? () => widget.cellOnTap!(data[index])
                  : null,
            ),
            separatorBuilder: (context, index) => 10.verticalSpaceFromWidth,
            noData: dataInited,
          ),
        ),
      );
  @override
  Future<List<CommunityBaseModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return Api.getCommunityPersonList(
      collectionName: widget.collectionName,
      userId: widget.userId,
      page: page,
      pageSize: _pageSize,
    );
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}
