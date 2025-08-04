import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/model/adult_game_model/adult_game_model.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/views/main/views/recreation/ai_customization/ai_customization_logic.dart';
import 'package:xhs_app/views/main/views/recreation/ai_customization/ai_customization_state.dart';

class AiCustomizationPage extends StatefulWidget {
  const AiCustomizationPage({Key? key}) : super(key: key);

  @override
  State<AiCustomizationPage> createState() => _AiCustomizationPageState();
}

class _AiCustomizationPageState extends State<AiCustomizationPage> {
  final AiCustomizationLogic logic = Get.put(AiCustomizationLogic());
  final AiCustomizationState state = Get.find<AiCustomizationLogic>().state;

  @override
  void dispose() {
    Get.delete<AiCustomizationLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTabBar(),
        Expanded(
          child: BaseRefreshWidget(
            logic.refreshController,
            refreshOnStart: false,
            child: PagedGridView<int, AdultGameModel>(
              padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
              addAutomaticKeepAlives: true,
              pagingController: logic.refreshController.pagingControllers,
              builderDelegate: PagedChildBuilderDelegate<AdultGameModel>(
                firstPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                newPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noMoreItemsIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noItemsFoundIndicatorBuilder: (context) => const NoData(),
                itemBuilder: (context, item, index) =>
                    buildShortVideoCell(item),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 8.w,
                  crossAxisCount: 2,
                  childAspectRatio: 162 / 130),
            ),
          ),
        ),
      ],
    );
  }

  buildTabBar() {
    return Obx(() {
      if (state.tabs.isEmpty) return Container();
      return TabBar(
        controller: logic.tabController,
        tabs: state.tabs.map((e) {
          return Row(
            children: [
              Visibility(
                visible: state.tabs.indexOf(e) != 0,
                child: Container(
                  height: 5.h,
                  width: 1.w,
                  color: ColorX.color_eeeeee,
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              Tab(text: e.gameCollectionName),
              SizedBox(
                width: 7.w,
              ),
            ],
          );
        }).toList(),
        indicatorColor: COLOR.transparent,
        dividerHeight: 0,
        isScrollable: true,
        onTap: (index) => logic.onChangeTab(state.tabs[index]),
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsets.zero,
      );
    });
  }

  Widget buildShortVideoCell(AdultGameModel item) {
    return Column(
      children: [
        ImageView(
          src: "${logic.refreshController.domain}${item.coverPicture}",
          width: double.infinity,
          height: 90.h,
          fit: BoxFit.cover,
          borderRadius: Styles.borderRaidus.m,
          axis: CoverImgAxis.horizontal,
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          item.gameName ?? "",
          style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
