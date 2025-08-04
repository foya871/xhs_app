import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/mine_releases/community_release_page_controller.dart';

import '../../../utils/color.dart';
import 'community_resource_page_controller.dart';

class CommunityTopicListPage extends StatefulWidget {
  final int chooseType;

  ///1:标签，2:分类
  final List<String>? selectedTopicModels;

  const CommunityTopicListPage(
      {super.key, this.selectedTopicModels, required this.chooseType});

  @override
  State createState() => _CommunityTopicListPageState();
}

class _CommunityTopicListPageState extends State<CommunityTopicListPage> {
  var checkedItems = <String>[].obs;
  var controller;
  @override
  void initState() {
    if (widget.chooseType == 1 || widget.chooseType == 2) {
      controller = Get.find<CommunityReleasePageController>();
      if (widget.chooseType == 1) {
        controller.getAllTopicList();
      } else {
        controller.getClassifyList();
      }
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
              // 在这里执行你的逻辑，例如显示一个对话框询问用户是否确定要退出。或者直接调用Navigator.pop。
              Navigator.pop(context, checkedItems);
            },
          ),
          title: Text(
            widget.chooseType == 1 ? "选择标签" : "选择分类",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.w,
              fontWeight: FontWeight.w600,
              color: COLOR.color_333333,
            ),
          ),
        ),
        body: GetBuilder<CommunityReleasePageController>(builder: (controller) {
          return Container(
            width: 360.w,
            padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.w),
            child: widget.chooseType == 1
                ? SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: Wrap(
                      spacing: 10.w,
                      runSpacing: 10.w,
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.start,
                      children: controller.allLablesItems.map<Widget>((e) {
                        return Container(
                          // height: 30.w,/
                          padding: EdgeInsets.only(
                              left: 12.w, right: 12.w, top: 2.w, bottom: 2.w),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: checkedItems.contains(e.name)
                                      ? COLOR.hexColor("#f52d45")
                                      : COLOR.hexColor("#eee"),
                                  width: 1),
                              borderRadius: BorderRadius.circular(16.w)),
                          child: Text(
                            e.name ?? "",
                            style: TextStyle(
                              color: checkedItems.contains(e.name)
                                  ? COLOR.hexColor("#f52d45")
                                  : COLOR.hexColor("#666666"),
                              fontSize: 13.w,
                            ),
                          ),
                        ).onOpaqueTap(() {
                          if (checkedItems.contains(e.name)) {
                            checkedItems.remove(e.name);
                          } else {
                            checkedItems.add(e.name!);
                          }
                          setState(() {});
                        });
                      }).toList(),
                    ))
                : SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: Wrap(
                      spacing: 10.w,
                      runSpacing: 10.w,
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.spaceAround,
                      children: controller.classifyItems.map<Widget>((e) {
                        return Container(
                          padding: EdgeInsets.only(
                              left: 12.w, right: 12.w, top: 2.w, bottom: 2.w),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: checkedItems.contains(e.classifyTitle)
                                      ? COLOR.hexColor("#f52d45")
                                      : COLOR.hexColor("#eee"),
                                  width: 1),
                              borderRadius: BorderRadius.circular(16.w)),
                          child: Text(
                            e.classifyTitle ?? "",
                            style: TextStyle(
                              color: checkedItems.contains(e.classifyTitle)
                                  ? COLOR.hexColor("#f52d45")
                                  : COLOR.hexColor("#666666"),
                              fontSize: 13.w,
                            ),
                          ),
                        ).onOpaqueTap(() {
                          if (checkedItems.contains(e.classifyTitle)) {
                            checkedItems.remove(e.classifyTitle);
                          } else {
                            if (checkedItems.isEmpty) {
                              checkedItems.add(e.classifyTitle);
                            } else {
                              checkedItems[0] = e.classifyTitle;
                            }
                          }
                          // if (checkedItems.contains(e.classifyTitle)) {
                          //   checkedItems.remove(e.classifyTitle);
                          // } else {
                          //   checkedItems.add(e.classifyTitle);
                          // }
                          setState(() {});
                        });
                      }).toList(),
                    ),
                  ),
          );
        }));
  }
}
