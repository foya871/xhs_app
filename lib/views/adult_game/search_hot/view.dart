import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/modules/adult_game_search_hot/view.dart';
import 'package:xhs_app/routes/routes.dart';

class AdultGameSearchHotPage extends StatefulWidget {
  const AdultGameSearchHotPage({super.key});

  @override
  State<AdultGameSearchHotPage> createState() => _AdultGameSearchHotPageState();
}

class _AdultGameSearchHotPageState extends State<AdultGameSearchHotPage> {
  TextEditingController keywordController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  void _handleSearch() {
    String text = keywordController.text;
    if (text.isEmpty) {
      SmartDialog.showToast('请输入搜索内容');
      return;
    }

    Get.toAdultGameSearchResultByWord(text);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 13.w, color: const Color(0xff999999));

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
                    // expands: true,
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
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "热搜类型",
                style: TextStyle(
                    fontSize: 16.w,
                    color: const Color(0xff333333),
                    letterSpacing: 0),
              ),
              SizedBox(
                height: 12.w,
              ),
              const AdultGameSearchHotView()
            ],
          ),
        ));
  }
}
