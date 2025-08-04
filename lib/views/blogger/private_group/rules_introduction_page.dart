import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/extension.dart';

class RulesIntroductionPage extends StatefulWidget {
  const RulesIntroductionPage({super.key});

  @override
  State<RulesIntroductionPage> createState() => _RulesIntroductionPageState();
}

class _RulesIntroductionPageState extends State<RulesIntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('私人团介绍')),
      body: Column(
        children: [
          16.verticalSpace,
          // const ImageView(
          //   src: AppImagePath.mine_private_group_rules,
          //   width: double.infinity,
          //   fit: BoxFit.fitWidth,
          // ).marginHorizontal(16.w),
        ],
      ),
    );
  }
}
