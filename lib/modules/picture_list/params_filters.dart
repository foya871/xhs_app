import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/generate/app_image_path.dart';

import 'controller.dart';

class SortTypeParams extends StatefulWidget {
  const SortTypeParams({super.key});

  @override
  State<SortTypeParams> createState() => _SortTypeParamsState();
}

class _SortTypeParamsState extends State<SortTypeParams> {
  final controller = Get.find<PictureListParamsManagerController>();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Obx(() {
        final sortType = controller.sortType.value;
        return DropdownButton2<int>(
          isExpanded: true,
          value: sortType,
          onChanged: (value) {
            controller.setSortType(value ?? 1);
          },
          items: controller.timeFilterList
              .map((e) => DropdownMenuItem<int>(
                  value: e['value'],
                  child: Center(
                      child: Text(
                    e['text'],
                    style: TextStyle(
                        color: const Color(0xffffffff), fontSize: 12.w),
                  ))))
              .toList(),
          customButton: Row(
            children: <Widget>[
              Image.asset(AppImagePath.community_community_filter,
                  width: 21.w, height: 19.w),
              Text(
                controller.timeFilterList.firstWhere(
                    (e) => e['value'] == sortType,
                    orElse: () => controller.timeFilterList.first)['text'],
                style: TextStyle(
                  color: const Color(0xff666666),
                  fontSize: 12.w,
                ),
              ).marginOnly(left: 8.w),
              Image.asset(AppImagePath.community_community_filter_down,
                      width: 13.w, height: 7.w)
                  .marginOnly(left: 8.w),
            ],
          ),
          buttonStyleData: const ButtonStyleData(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          dropdownStyleData: DropdownStyleData(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xff111111),
            ),
            offset: const Offset(0, -6),
          ),
        );
      }),
    );
  }
}

class ViewedParams extends StatefulWidget {
  const ViewedParams({super.key});

  @override
  State<ViewedParams> createState() => _ViewedParamsState();
}

class _ViewedParamsState extends State<ViewedParams> {
  final controller = Get.find<PictureListParamsManagerController>();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Obx(() {
        final viewed = controller.viewed.value;
        return DropdownButton2<bool?>(
          isExpanded: true,
          value: viewed,
          onChanged: (value) {
            controller.setViewed(value);
          },
          items: controller.viewFilterList
              .map((e) => DropdownMenuItem<bool?>(
                  value: e['value'],
                  child: Center(
                      child: Text(
                    e['text'],
                    style: TextStyle(
                        color: const Color(0xffffffff), fontSize: 12.w),
                  ))))
              .toList(),
          customButton: Row(
            children: <Widget>[
              Image.asset(AppImagePath.community_community_filter,
                  width: 21.w, height: 19.w),
              Text(
                controller.viewFilterList.firstWhere(
                    (e) => e['value'] == viewed,
                    orElse: () => controller.viewFilterList.first)['text'],
                style: TextStyle(
                  color: const Color(0xff666666),
                  fontSize: 12.w,
                ),
              ).marginOnly(left: 8.w),
              Image.asset(AppImagePath.community_community_filter_down,
                      width: 13.w, height: 7.w)
                  .marginOnly(left: 8.w),
            ],
          ),
          buttonStyleData: const ButtonStyleData(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          dropdownStyleData: DropdownStyleData(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xff111111),
            ),
            offset: const Offset(0, -6),
          ),
        );
      }),
    );
  }
}
