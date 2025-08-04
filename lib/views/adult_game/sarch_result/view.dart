import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/adult_game_cell/adult_game_cell.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/adult_game_model/adult_game_model.dart';
import 'package:xhs_app/model/search/search_res_model.dart';
import 'package:xhs_app/routes/routes.dart';

import 'controller.dart';

class AdultGameSearchResultPage extends StatefulWidget {
  const AdultGameSearchResultPage({super.key});

  @override
  State<AdultGameSearchResultPage> createState() =>
      _AdultGameSearchResultPageState();
}

class _AdultGameSearchResultPageState extends State<AdultGameSearchResultPage> {
  late TextEditingController keywordController;

  final refreshController = EasyRefreshController();

  List<AdultGameModel> list = [];

  int page = 1;

  void fetchMore() {
    page += 1;

    initList();
  }

  void fetchFresh() {
    page = 1;

    initList();
  }

  void initList() async {
    // var result = await AdultGamesRepositoryImpl()
    //     .fetchAdultGameListByCollection(page,
    //         gameCollectionId: widget.gameCollectionId,
    //         hostType: _hostType == 0 ? null : _hostType);
    final result = await httpInstance.get<SearchResModel>(
        url: 'search/keyWord',
        queryMap: {
          'pageSize': 10,
          'searchType': 6,
          'searchWord': Get.find<AdultGameSearchResultController>().keyWord,
          'page': page,
        },
        complete: SearchResModel.fromJson);

    final isFinish = result.adultGameList.length < 10;

    if (page == 1) {
      setState(() {
        list = result.adultGameList;
      });
    } else {
      setState(() {
        list = [...list, ...result.adultGameList];
      });
    }

    refreshController.finishRefresh(
        isFinish ? IndicatorResult.noMore : IndicatorResult.success, true);
  }

  @override
  void initState() {
    keywordController = TextEditingController(
        text: Get.find<AdultGameSearchResultController>().keyWord);

    super.initState();
    initList();
  }

  void _handleSearch() {
    String text = keywordController.text;
    if (text.isEmpty) {
      SmartDialog.showToast('请输入搜索内容');
      return;
    }

    Get.toAdultGameSearchResultByWordReplace(text);
  }

  Widget _buildResult() {
    return EasyRefresh(
      onRefresh: () {
        fetchFresh();
      },
      onLoad: () {
        fetchMore();
      },
      controller: refreshController,
      child: MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        padding: const EdgeInsets.all(0),
        mainAxisSpacing: 15.w,
        crossAxisSpacing: 0,
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return AdultGameCell(game: list[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 13.w, color: const Color(0xff999999));

    return GetBuilder<AdultGameSearchResultController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          actions: [
            TextButton(
                onPressed: () {
                  _handleSearch();
                },
                child: Text(
                  "搜索",
                  style: TextStyle(
                      color: const Color(0xff333333),
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700),
                ))
          ],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 38,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: const Color(0xfff5f5f5),
                      borderRadius: BorderRadius.all(Radius.circular(19.w))),
                  padding:
                      EdgeInsets.symmetric(vertical: 7.w, horizontal: 15.w),
                  child: TextField(
                    controller: keywordController,
                    decoration: InputDecoration(
                      hintText: '搜索喜欢的游戏',
                      border: InputBorder.none,
                      hintStyle: style,
                    ),
                    style: style,
                    onSubmitted: (value) {
                      // 处理搜索逻辑
                      _handleSearch();
                    },
                  ),
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff999999),
              size: 18,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 14.w),
          child: _buildResult(),
        ),
      );
    });
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
