import 'package:event_bus/event_bus.dart';

class _EventBus {
  final _bus = EventBus();

  void fire(dynamic event) => _bus.fire(event);

  void listen<T>(void Function(T e) onEvent, {bool Function(T e)? test}) {
    var stream = _bus.on<T>();
    if (test != null) {
      stream = stream.where(test);
    }
    stream.listen(onEvent);
  }
}

// ignore: non_constant_identifier_names
final EventBusInst = _EventBus();
