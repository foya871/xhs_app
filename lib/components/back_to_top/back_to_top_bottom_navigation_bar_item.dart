import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/generate/app_image_path.dart';

class BackToTopBottomNavigationBarItem extends BottomNavigationBarItem {
  final ScrollController Function()? scrollControllerGetter;

  BackToTopBottomNavigationBarItem({
    super.label,
    required super.icon,
    required Widget activeIcon,
    this.scrollControllerGetter, // 不传入,和普通BarItem的没区别
    double? scrollThreshold,
  }) : super(
          activeIcon: scrollControllerGetter != null
              ? _BackToTopActiveIcon(
                  activeIcon,
                  scrollControllerGetter: scrollControllerGetter,
                  scrollThreshold: scrollThreshold ?? (1.sh * 2.5),
                )
              : activeIcon,
        );
}

class _BackToTopActiveIcon extends StatefulWidget {
  final ScrollController Function() scrollControllerGetter;
  final double scrollThreshold;
  final Widget icon;
  const _BackToTopActiveIcon(this.icon,
      {required this.scrollControllerGetter, required this.scrollThreshold});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_BackToTopActiveIcon> {
  bool showBackToTop = false;
  ScrollController currentScrollController = ScrollController(); // 不直接使用

  ScrollController get scrollController {
    final controller = widget.scrollControllerGetter();

    if (controller != currentScrollController) {
      currentScrollController.removeListener(_scrollListener);

      controller.addListener(_scrollListener);
      currentScrollController = controller;
    }
    return currentScrollController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.offset >= widget.scrollThreshold) {
      if (!showBackToTop) {
        setState(() {
          showBackToTop = true;
        });
      }
    } else {
      if (showBackToTop) {
        setState(() {
          showBackToTop = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showBackToTop) {
      return Column(
        children: [
          Image.asset(
            AppImagePath.icons_floating_back_to_top,
            width: 25.w,
            height: 25.w,
          ),
          Text('返回顶部'),
        ],
      );
    } else {
      return widget.icon;
    }
  }
}
