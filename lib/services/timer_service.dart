import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class _Minute with ChangeNotifier {
  late final Timer timer;

  _Minute() {
    timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => notifyListeners(),
    );
  }
  @override
  @mustCallSuper
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class TimerService extends GetxService {
  final _minute = _Minute();

  void addMinuteListener(VoidCallback fn) => _minute.addListener(fn);
  void removeMinuteListener(VoidCallback fn) => _minute.removeListener(fn);

  @override
  void onClose() {
    _minute.dispose();
    super.onClose();
  }
}
