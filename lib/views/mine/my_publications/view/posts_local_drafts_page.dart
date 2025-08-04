import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/utils/color.dart';

import 'item_posts_view.dart';

class PostsLocalDraftsPage extends StatefulWidget {
  const PostsLocalDraftsPage({super.key});

  @override
  State<StatefulWidget> createState() => _PostsLocalDraftsPageState();
}

class _PostsLocalDraftsPageState extends State<PostsLocalDraftsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(
        titleText: "本地草稿",
        isShowBottomLine: true,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 35.h,
              color: COLOR.color_FFE5E5,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              child: TextView(
                text: "草稿在应用卸载后会被删除，请及时发布（最多保存10条）",
                color: COLOR.color_FF4340,
                fontSize: 12.w,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    child: ItemPostsView(
                      fromType: 4,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
