import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/utils/extension.dart';

class NoDataSliverMasonryGrid extends StatelessWidget {
  final bool noData;
  final SliverChildDelegate? delegate;
  final SliverSimpleGridDelegate? gridDelegate;
  final int? crossAxisCount; // count
  final double? maxCrossAxisExtent; // extent
  final int? itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  final Widget? emptyWidget;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const NoDataSliverMasonryGrid({
    super.key,
    required this.delegate,
    required this.gridDelegate,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    required this.noData,
    this.emptyWidget,
  })  : itemCount = null,
        itemBuilder = null,
        crossAxisCount = null,
        maxCrossAxisExtent = null;

  const NoDataSliverMasonryGrid.count({
    super.key,
    required this.crossAxisCount,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    required this.noData,
    this.emptyWidget,
  })  : delegate = null,
        gridDelegate = null,
        maxCrossAxisExtent = null;

  const NoDataSliverMasonryGrid.extent({
    super.key,
    required this.maxCrossAxisExtent,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    required this.noData,
    this.emptyWidget,
  })  : delegate = null,
        gridDelegate = null,
        crossAxisCount = null;

  @override
  Widget build(BuildContext context) {
    if (noData && itemCount == 0) {
      return emptyWidget?.sliver ?? const NoData.empty().sliver;
    }
    if (delegate != null && gridDelegate != null) {
      return SliverMasonryGrid(
        delegate: delegate!,
        gridDelegate: gridDelegate!,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      );
    }
    if (crossAxisCount != null) {
      return SliverMasonryGrid.count(
        crossAxisCount: crossAxisCount!,
        itemBuilder: itemBuilder!,
        childCount: itemCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      );
    }
    if (maxCrossAxisExtent != null) {
      return SliverMasonryGrid.extent(
        maxCrossAxisExtent: maxCrossAxisExtent!,
        itemBuilder: itemBuilder!,
        childCount: itemCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
      );
    }
    assert(false, 'NoDataSliverMasonryGrid bad args');
    return Container();
  }
}
