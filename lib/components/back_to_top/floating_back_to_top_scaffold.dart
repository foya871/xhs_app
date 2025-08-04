import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/generate/app_image_path.dart';

import 'package:xhs_app/utils/extension.dart';

class FloatingBackToTopScaffold extends StatefulWidget {
  final ScrollController scrollController;
  final double scrollThreshold;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Color? backgroundColor;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  FloatingBackToTopScaffold({
    super.key,
    required this.scrollController,
    double? scrollThreshold,
    this.appBar,
    this.body,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.backgroundColor,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  }) : scrollThreshold = scrollThreshold ?? (1.sh * 2.5);

  @override
  State createState() => _State();
}

class _State extends State<FloatingBackToTopScaffold> {
  bool _isButtonVisible = false;

  ScrollController get scrollController => (widget).scrollController;
  double get scrollThreshold => (widget).scrollThreshold;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_listenScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_listenScroll);
    // scrollController.dispose(); // 这里不dispose， 是外部传进来的
    super.dispose();
  }

  void _listenScroll() {
    final visible = scrollController.offset > scrollThreshold;
    if (visible) {
      if (!_isButtonVisible) {
        setState(() {
          _isButtonVisible = true;
        });
      }
    } else {
      if (_isButtonVisible) {
        setState(() {
          _isButtonVisible = false;
        });
      }
    }
  }

  Widget _buildFloatingButton() {
    return Image.asset(
      AppImagePath.icons_floating_back_to_top,
      width: 60.w,
      height: 60.w,
    ).onTap(() => scrollController.jumpTo(0.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      appBar: widget.appBar,
      body: widget.body,
      floatingActionButton: _isButtonVisible ? _buildFloatingButton() : null,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      backgroundColor: widget.backgroundColor,
    );
  }
}
