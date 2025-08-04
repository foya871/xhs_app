import 'package:xhs_app/utils/color.dart';

import '../../assets/styles.dart';
import '../copy_paste_view.dart';
import '../../model/sys/sys_models.dart';
import 'package:flutter/widgets.dart';
import '../../utils/extension.dart';

class BussinessGroupCell extends StatelessWidget {
  final SysBussinessModel model;
  const BussinessGroupCell({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: COLOR.white,
      fontSize: Styles.fontSize.s,
      overflow: TextOverflow.ellipsis,
    );

    if (model.isEmpty()) {
      return const SizedBox.shrink();
    }
    return Text('商务合作：${model.link}', maxLines: 2, style: textStyle)
        .onTap(() => CopyPasteView.copy(model.link));
  }
}
