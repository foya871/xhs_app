import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/extension.dart';
import '../../../assets/colorx.dart';
import '../../../components/no_more/no_data_text.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/search/hot_word_model.dart';
import 'search_logic.dart';
import 'search_state.dart';

class SearchPreviewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPreviewWidgetState();
}

class SearchPreviewWidgetState extends State<SearchPreviewWidget> {
  final SearchLogic logic = Get.put(SearchLogic());
  final SearchState state = Get.find<SearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "历史搜索",
                  style: TextStyle(fontSize: 15.w, color: ColorX.color_333333),
                ),
                GestureDetector(
                  onTap: () => logic.clearHistory(),
                  child: Text(
                    "清除",
                    style:
                        TextStyle(fontSize: 13.w, color: ColorX.color_999999),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            child: Obx(() {
              if (state.historyKeys.isEmpty) {
                return NoDataText(
                  tips: "暂无搜索记录",
                  height: 60,
                );
              }
              return Wrap(
                runSpacing: 10.h,
                spacing: 12.w,
                children: state.historyKeys.map((key) {
                  return buildHistoryTab(key, () {
                    logic.textController.text = key ?? "";
                    logic.onSearch(logic.textController.text);
                  });
                }).toList(),
              );
            }),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "猜你想搜",
                  style: TextStyle(fontSize: 15.w, color: ColorX.color_333333),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            child: Obx(() {
              if (state.guessLike.isEmpty) {
                return const NoDataText(
                  tips: "暂无数据",
                  height: 60,
                );
              }
              return Wrap(
                runSpacing: 10.h,
                spacing: 12.w,
                children: state.guessLike.map((item) {
                  return buildGuessLikeItem(item, () {
                    logic.textController.text = item.hotTitle ?? "";
                    logic.onSearch(logic.textController.text);
                  });
                }).toList(),
              );
            }),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            child: Image.asset(
              AppImagePath.selection_ic_recent_hot,
              height: 15.h,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Obx(() {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: buildRecentHot,
              separatorBuilder: (_, index) => Divider(
                height: 1.h,
                color: ColorX.color_eeeeee,
                indent: 14.w,
                endIndent: 14.w,
              ),
              itemCount: state.hotWords.length,
            );
          }),
        ],
      ),
    );
  }

  Widget buildHistoryTab(String key, Function() onTap) {
    //
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // color: ColorX.color_eeeeee,
          border: Border.all(color: ColorX.color_eeeeee, width: 1.r),
          borderRadius: BorderRadius.all(Radius.circular(18.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
        child: Text(
          key,
          style: TextStyle(fontSize: 13.w, color: ColorX.color_666666),
        ),
      ),
    );
  }

  Widget buildGuessLikeItem(HotWordModel item, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        child: Text(
          item.hotTitle ?? '',
          style: TextStyle(fontSize: 13.w, color: ColorX.color_666666),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget buildRecentHot(context, index) {
    var item = state.hotWords[index];
    var color = ColorX.color_999999;
    switch (index) {
      case 0:
        color = ColorX.color_fb2d45;
        break;
      case 1:
        color = ColorX.color_fc4a0f;
        break;
      case 2:
        color = ColorX.color_fcb72b;
        break;
      default:
        color = ColorX.color_999999;
        break;
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      height: 40.h,
      child: Row(
        children: [
          Text(
            "${index + 1}",
            style: TextStyle(
                fontSize: 14.w, color: color, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Text(
              item.title ?? '',
              style: TextStyle(fontSize: 14.w, color: ColorX.color_333333),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "${item.fakeWatchTimes ?? 0}观看",
            style: TextStyle(fontSize: 12.w, color: ColorX.color_999999),
          ),
        ],
      ),
    ).onTap(() {
      Get.toCommunityDetailById(item.dynamicId ?? 0,
          dynamicType: item.dynamicType ?? 1);
    });
  }
}
