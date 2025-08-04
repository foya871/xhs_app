import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../model/community/community_base_model.dart';
import '../../../../model/community/community_model.dart';
import '../../../../utils/extension.dart';
import 'community_carouse_silder.dart';
import 'community_utils.dart';

// 图文解锁后
class CommunityTextPictureModeContent extends StatelessWidget {
  final List<String> images;
  final String title;
  final String contentText;
  final List<String> topic;
  final String checkAt;
  final bool showImage;

  CommunityTextPictureModeContent.fromBase(CommunityBaseModel model,
      {super.key, required this.showImage})
      : images = model.images,
        title = model.title,
        contentText = model.contentText,
        topic = model.topic,
        checkAt = model.checkAt;

  CommunityTextPictureModeContent.fromDetail(CommunityModel model,
      {super.key, required this.showImage})
      : images = model.images,
        title = model.title,
        contentText = model.contentText,
        topic = model.topic,
        checkAt = model.checkAt;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showImage && images.isNotEmpty) ...[
            CommunityCarouseSlider(images),
            14.verticalSpaceFromWidth
          ],
          CommunityUtils.buildTitle(title).baseMarginHorizontal,
          10.verticalSpaceFromWidth,
          CommunityUtils.buildContentText(contentText).baseMarginHorizontal,
          5.verticalSpaceFromWidth,
          CommunityUtils.buildTopic(topic).baseMarginHorizontal,
          10.verticalSpaceFromWidth,
          CommunityUtils.buildCheckAt(checkAt).baseMarginHorizontal,
          10.verticalSpaceFromWidth,
        ],
      );
}
