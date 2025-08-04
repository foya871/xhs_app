import 'package:flutter/widgets.dart';

import '../../assets/styles.dart';
import '../../utils/color.dart';
import '../../utils/utils.dart';

class VideoPlayCountCell extends StatelessWidget {
  final int playCount;

  const VideoPlayCountCell({super.key, required this.playCount});

  @override
  Widget build(BuildContext context) {
    final text = '${Utils.numFmtCh(playCount)}次';
    final textStyle = TextStyle(
      color: COLOR.white,
      fontSize: Styles.fontSize.xs,
    );
    return Text(text, style: textStyle);
  }
}
