import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color.dart';
import '../safe_state.dart';

class ExpansionTabBar extends StatefulWidget {
  final ExpansionTileController? controller;
  final TabBar tabBar;
  final Future<bool> Function()? loadingTask;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final Color? dividerColor;
  final List<Widget> Function(BuildContext context)? loadingBuilder;
  final List<Widget> Function(BuildContext context)? loadingSuccessBuilder;
  final List<Widget> Function(BuildContext context)? loadingFailBuilder;

  const ExpansionTabBar(
    this.tabBar, {
    super.key,
    this.controller,
    this.loadingTask,
    this.onOpen,
    this.onClose,
    this.loadingBuilder,
    this.loadingSuccessBuilder,
    this.loadingFailBuilder,
    this.dividerColor,
  });

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<ExpansionTabBar> {
  bool _loading = false;
  bool _loadSuccess = true;

  List<Widget> _buildExpansion(BuildContext context) {
    if (_loading) {
      return widget.loadingBuilder?.call(context) ?? [];
    }
    if (_loadSuccess) {
      return widget.loadingSuccessBuilder?.call(context) ?? [];
    } else {
      return widget.loadingFailBuilder?.call(context) ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: widget.dividerColor ?? COLOR.transparent,
      ),
      child: ExpansionTile(
        title: widget.tabBar,
        minTileHeight: 44.w,
        tilePadding: EdgeInsets.symmetric(horizontal: 6.w),
        controller: widget.controller ?? ExpansionTileController(),
        onExpansionChanged: (isOpen) async {
          if (isOpen) {
            widget.onOpen?.call();
            if (!_loading && widget.loadingTask != null) {
              setState(() {
                _loading = true;
              });

              _loadSuccess = await widget.loadingTask!();

              setState(() {
                _loading = false;
              });
            }
          } else {
            widget.onClose?.call();
          }
        },
        children: _buildExpansion(context),
      ),
    );
  }
}
