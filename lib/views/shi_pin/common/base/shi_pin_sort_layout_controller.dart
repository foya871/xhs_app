import 'package:xhs_app/utils/enum.dart';
import 'package:get/get.dart';

mixin ShiPinSortLayoutController {
  final layout = VideoLayout.small.obs;

  void toogleLayout() => layout.value == VideoLayout.big
      ? layout.value = VideoLayout.small
      : layout.value = VideoLayout.big;
}
