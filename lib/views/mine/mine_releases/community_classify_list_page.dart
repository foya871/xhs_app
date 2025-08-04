import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/model/community/community_classify_model.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/mine_releases/community_release_page_controller.dart';

import '../../../utils/color.dart';
import 'community_resource_page_controller.dart';

///选择分类
class CommunityClassifyListPage extends StatefulWidget {
  final int chooseType;

  ///1:图文，视频分类，2:资源分类
  final List<CommunityClassifyModel>? selectedTopicModels;

  const CommunityClassifyListPage(
      {super.key, this.selectedTopicModels, required this.chooseType});

  @override
  State createState() => _CommunityClassifyListPageState();
}

class _CommunityClassifyListPageState extends State<CommunityClassifyListPage> {
  var checkedItems = <CommunityClassifyModel>[].obs;
  var controller;
  @override
  void initState() {
    if (widget.chooseType == 1) {
      controller = Get.find<CommunityReleasePageController>();
      controller.getClassifyList();
    } else {
      controller = Get.find<CommunityResourcePageController>();
      controller.getResourcesClassifyList();
    }

    widget.selectedTopicModels?.forEach((element) {
      checkedItems.add(element);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // 返回图标按钮
          onPressed: () {
            Navigator.pop(context, checkedItems);
          },
        ),
        title: Text(
          "选择分类",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.w,
            fontWeight: FontWeight.w600,
            color: COLOR.color_333333,
          ),
        ),
      ),
      body: Container(
        width: 360.w,
        padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.w),
        child: Wrap(
          spacing: 8.w,
          runSpacing: 12.w,
          runAlignment: WrapAlignment.start,
          alignment: WrapAlignment.start,
          children: _buildClassify(),
        ),
      ),
    );
  }

  _buildClassify() {
    List<Widget> items = [];
    controller.classifyItems.forEach((e) {
      items.add(Container(
        padding:
            EdgeInsets.only(left: 12.w, right: 12.w, top: 2.w, bottom: 2.w),
        decoration: BoxDecoration(
            border: Border.all(
                color: checkedItems.contains(e)
                    ? COLOR.hexColor("#f52d45")
                    : COLOR.hexColor("#eee"),
                width: 1),
            borderRadius: BorderRadius.circular(16.w)),
        child: Text(
          e.classifyTitle ?? "",
          style: TextStyle(
            color: checkedItems.contains(e)
                ? COLOR.hexColor("#f52d45")
                : COLOR.hexColor("#666666"),
            fontSize: 13.w,
          ),
        ),
      ).onOpaqueTap(() {
        if (checkedItems.contains(e)) {
          checkedItems.remove(e);
        } else {
          if (checkedItems.isEmpty) {
            checkedItems.add(e);
          } else {
            checkedItems[0] = e;
          }
        }
        setState(() {});
      }));
    });
    return items;
  }
}
