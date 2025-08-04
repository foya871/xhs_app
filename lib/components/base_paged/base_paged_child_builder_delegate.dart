import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_page/base_error_widget.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_more.dart';
import 'package:xhs_app/views/player/views/av_player_loading.dart';

class BasePagedChildBuilderDelegate<ItemType>
    extends PagedChildBuilderDelegate<ItemType> {
  BasePagedChildBuilderDelegate({
    required super.itemBuilder,
  }) : super(
          firstPageErrorIndicatorBuilder: (context) => const BaseErrorWidget(),
          newPageErrorIndicatorBuilder: (context) => Container(),
          firstPageProgressIndicatorBuilder: (context) =>
              const AvPlayerLoading(),
          newPageProgressIndicatorBuilder: (context) => const AvPlayerLoading(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          noMoreItemsIndicatorBuilder: (context) => const NoMore(),
        );
}
