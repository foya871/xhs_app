import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/widget_utils.dart';
import 'package:xhs_app/views/selection/adult_game/adult_game_page.dart';
import 'package:xhs_app/views/selection/recommend/recommend_page.dart';
import 'package:xhs_app/views/selection/resource_download/resource_download_page.dart';

import '../../assets/styles.dart';
import '../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../generate/app_image_path.dart';
import '../../routes/routes.dart';
import '../../utils/color.dart';
import '../community/views/community_discover_page.dart';
import 'naked_chat_service/naked_chat_service_page.dart';
import 'original_underwear/original_underwear_page.dart';
import 'selection_logic.dart';
import 'selection_state.dart';

///精选
class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  final SelectionLogic logic = Get.put(SelectionLogic());
  final SelectionState state = Get.find<SelectionLogic>().state;

  ///控制ai按钮显示和隐藏
  bool _displayAi = true;
  void _updateDisplayAi(bool value) {
    if (mounted) {
      setState(() {
        _displayAi = value;
      });
    }
  }

  @override
  void dispose() {
    Get.delete<SelectionLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _displayAi
          ? SizedBox(
              width: 110.w,
              height: 200.w,
              child: Stack(
                children: [
                  Positioned(
                    top: 10.w,
                    child: Image.asset(
                      AppImagePath.selection_ai_in,
                      width: 100.w,
                      height: 120.w,
                    ).onTap(() {
                      jump2Ai();
                    }),
                  ),
                  Positioned(
                    right: 0,
                    child: Icon(
                      Icons.cancel,
                      color: Colors.black,
                      size: 20.w,
                    ).onTap(() => _updateDisplayAi(false)),
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // Distribute spacing evenly
            children: [
              SizedBox(width: 9.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.selectionSearch),
                  child: WidgetUtils.buildTextField(
                    null,
                    32.h,
                    13.w,
                    ColorX.color_999999,
                    "输入搜索内容",
                    hintColor: ColorX.color_999999,
                    enabled: false,
                    backgroundColor: ColorX.color_eeeeee,
                    borderRadius: BorderRadius.all(Radius.circular(18.r)),
                  ),
                ),
              ),
              SizedBox(width: 9.w),
              // Spacing between input and button
              // "开通会员" Button
              Container(
                width: 100.w, // Adjust as needed
                height: 32.h, // Adjust as needed
                child: Center(
                  child: Image.asset(
                    AppImagePath.selection_open_vip,
                    height: 32.w,
                    fit: BoxFit.fitHeight,
                  ).onTap(() => Get.toVip()),
                ),
              ),
              SizedBox(width: 9.w),
            ],
          ),
          Container(
            color: COLOR.color_AFAFAF,
          ),
          Expanded(
              child: DefaultTabController(
            length: state.tabs.length,
            child: Column(
              children: [
                SizedBox(
                  height: 11.h,
                ),
                SizedBox(
                  height: 30.h,
                  child: _buildTabBar(),
                ),
                Divider(
                  height: 1.h,
                  color: ColorX.color_eeeeee,
                ),
                Expanded(child: _buildTabBarView()),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTabBar() => SizedBox(
        child: TabBar(
          tabs: state.tabs.map((e) => Tab(text: e)).toList(),
          dividerHeight: 0,
          indicator: EasyFixedIndicator(
            color: COLOR.color_FB2D45,
            height: 0.w,
            borderRadius: Styles.borderRadius.all(2.w),
          ),
          tabAlignment: TabAlignment.fill,
          labelPadding: EdgeInsets.zero,
          labelStyle: TextStyle(
            fontSize: 16.w,
            fontWeight: FontWeight.bold,
            color: COLOR.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16.w,
            fontWeight: FontWeight.w400,
            color: COLOR.color_666666,
          ),
        ),
      );

  Widget _buildTabBarView() => const TabBarView(
        children: [
          RecommendPage(),
          ResourceDownloadPage(),
          OriginalUnderwearPage(),
          AdultGamePage(),
          NakedChatServicePage(),
        ],
      );
}
