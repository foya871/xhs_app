import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../easy_toast.dart';

void _exit() => SystemNavigator.pop(animated: true);

// 暂时只支持安卓
class EasyPopScope extends StatefulWidget {
  final Widget child;
  final String tips;
  final Duration duration;
  final VoidCallback onConfirm;

  const EasyPopScope({
    super.key,
    this.duration = const Duration(seconds: 5),
    required this.tips,
    required this.onConfirm,
    required this.child,
  });
  const EasyPopScope.exit({
    super.key,
    required this.child,
  })  : tips = '再按一次退出',
        duration = const Duration(seconds: 5),
        onConfirm = _exit;

  @override
  State<EasyPopScope> createState() => _EasyPopScopeState();
}

class _EasyPopScopeState extends State<EasyPopScope> {
  DateTime? _lastPressAt;

  bool _onPopInvoked() {
    final now = DateTime.now();
    if (_lastPressAt == null ||
        now.difference(_lastPressAt!) > widget.duration) {
      _lastPressAt = now;
      EasyToast.show(widget.tips, displayTime: widget.duration);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (!GetPlatform.isAndroid) return widget.child;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, r) {
        if (!didPop) {
          if (_onPopInvoked()) {
            widget.onConfirm();
          }
        }
      },
      child: widget.child,
    );
  }
}
