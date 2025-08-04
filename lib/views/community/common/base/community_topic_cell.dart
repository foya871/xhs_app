import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';

class CommunityTopicCell extends StatelessWidget {
  final String topic;
  const CommunityTopicCell(this.topic, {super.key});
  @override
  Widget build(BuildContext context) => Text(
        '#$topic',
        style: TextStyle(fontSize: 12.w, color: COLOR.color_2b4465),
      ).onTap(() => Get.toCommunityTopic(topic));
}
