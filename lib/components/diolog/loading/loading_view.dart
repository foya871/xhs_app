/*
 * @Author: wangdazhuang
 * @Date: 2025-01-11 17:08:52
 * @LastEditTime: 2025-03-05 17:01:24
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/components/diolog/loading/loading_view.dart
 */
import 'package:flutter/material.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';

class LoadingView {
  static final LoadingView singleton = LoadingView._();

  factory LoadingView() => singleton;

  LoadingView._();

  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  bool _isVisible = false;

  Future<T> wrap<T>({
    required BuildContext context,
    required Future<T> Function() asyncFunction,
    Color? color,
    bool showing = true,
  }) async {
    if (showing) show(context, color);
    T data;
    try {
      data = await asyncFunction();
    } on Exception catch (_) {
      rethrow;
    } finally {
      dismiss();
    }
    return data;
  }

  Future<T> wrapWidget<T>({
    required BuildContext context,
    required Future<T> Function() asyncFunction,
    Widget? child,
    Color? background,
    Color? color,
    bool showing = true,
  }) async {
    if (showing) show(context, color, background: background, child: child);
    T data;
    try {
      data = await asyncFunction();
    } on Exception catch (_) {
      rethrow;
    } finally {
      dismiss();
    }
    return data;
  }

  void show(BuildContext context, Color? color,
      {Color? background, Widget? child}) async {
    if (_isVisible) return;
    _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        color: background ?? Colors.transparent,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ImageView(
              src: AppImagePath.player_loading,
              width: 90,
              height: 90,
            ),
            // SpinKitCircle(color: color ?? COLOR.playerThemeColor),
            const SizedBox(height: 20),
            if (child != null) child,
          ],
        )),
      ),
    );
    _isVisible = true;
    _overlayState?.insert(_overlayEntry!);
  }

  dismiss() async {
    if (!_isVisible) return;
    _overlayEntry?.remove();
    _isVisible = false;
  }
}
