import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'base_refresh_simple_state.dart';

class BaseRefreshSimpleStateWidget<T extends StatefulWidget, E>
    extends StatelessWidget {
  final BaseRefreshSimpleState<T, E> state;
  final Widget? child;
  final ERChildBuilder? childBuilder;
  final ScrollController? scrollController;
  final bool refreshOnStart;
  final bool enableLoad;
  const BaseRefreshSimpleStateWidget(
    this.state, {
    super.key,
    required this.child,
    this.scrollController,
    this.refreshOnStart = true,
    this.enableLoad = true,
  }) : childBuilder = null;

  const BaseRefreshSimpleStateWidget.buider(
    this.state, {
    super.key,
    this.childBuilder,
    this.scrollController,
    this.refreshOnStart = true,
    this.enableLoad = true,
  }) : child = null;

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return EasyRefresh(
        controller: state.refreshController,
        onRefresh: state.onRefresh,
        onLoad: state.onLoad,
        refreshOnStart: refreshOnStart,
        child: child,
      );
    } else {
      return EasyRefresh.builder(
        controller: state.refreshController,
        onRefresh: state.onRefresh,
        onLoad: state.onLoad,
        refreshOnStart: refreshOnStart,
        childBuilder: childBuilder,
      );
    }
  }
}
