import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/widget_utils.dart';
import 'package:xhs_app/views/search/search_logic.dart';

import '../../../assets/colorx.dart';
import 'search_preview_widget.dart';
import 'search_result_widget.dart';
import 'search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchLogic logic = Get.put(SearchLogic());
  final SearchState state = Get.find<SearchLogic>().state;

  @override
  void initState() {
    logic.textController.addListener(() {
      state.showClear.value = logic.textController.text.isNotEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SearchLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorX.color_FaFaFa,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: ColorX.color_FaFaFa,
        actions: [
          GestureDetector(
            onTap: () {
              final show = state.showResult.value;
              if (show) {
                state.showResult.value = false;
                return;
              }
              Get.back();
            },
            child: Container(
              width: 40.w,
              alignment: Alignment.center,
              child: Image.asset(AppImagePath.icons_base_ic_back_grey,
                  width: 20.r, height: 20.r),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorX.color_eeeeee,
                borderRadius: BorderRadius.circular(28.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: WidgetUtils.buildTextField(
                        null, 32.h, 13.w, Colors.black, "输入搜索内容",
                        hintColor: ColorX.color_999999,
                        enabled: true,
                        backgroundColor: Colors.transparent,
                        borderRadius: BorderRadius.zero,
                        controller: logic.textController),
                  ),
                  Obx(() {
                    return Visibility(
                      visible: state.showClear.value,
                      child: GestureDetector(
                        onTap: () => logic.textController.clear(),
                        child: Container(
                          width: 30.r,
                          height: 30.r,
                          alignment: Alignment.center,
                          child: Image.asset(
                            AppImagePath
                                .community_discover_select_classify_remove,
                            width: 18.r,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => logic.onSearch(logic.textController.text),
            child: Container(
              width: 50.w,
              alignment: Alignment.center,
              child: Text(
                "搜索",
                style: TextStyle(fontSize: 14.w, color: ColorX.color_666666),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return state.showResult.value == true
            ? SearchResultWidget()
            : SearchPreviewWidget();
      }),
    );
  }
}
