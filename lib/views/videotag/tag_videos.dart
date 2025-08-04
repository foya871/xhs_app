/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-27 19:35:07
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-24 18:50:34
 * @FilePath: /xhs_app/lib/views/videotag/tag_videos.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:xhs_app/views/videotag/short_tag_video_list.dart';
import 'package:xhs_app/views/videotag/tagvideo_list.dart';

class TagVideos extends StatefulWidget {
  final int mark;
  final String tagsTitle;
  final int videoMark;
  const TagVideos(
      {super.key,
      required this.mark,
      required this.tagsTitle,
      required this.videoMark});

  @override
  State<TagVideos> createState() => _TagVideos();
}

class _TagVideos extends State<TagVideos> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final _tabs = [
    {'name': '最近更新', 'type': 1},
    {'name': '最多观看', 'type': 2},
  ];

  @override
  void initState() {
    tabController =
        TabController(length: _tabs.length, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.tagsTitle,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight - 20.w),
            child: SizedBox(
              height: 23.w,
              child: ButtonsTabBar(
                  backgroundColor: COLOR.hexColor('#B93FFF'),
                  unselectedBackgroundColor: Colors.transparent,
                  radius: 11.5.w,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  buttonMargin: EdgeInsets.symmetric(
                    horizontal: 14.w,
                  ),
                  labelStyle: TextStyle(fontSize: 12.w, color: Colors.white),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 12.w, color: Colors.white),
                  controller: tabController,
                  tabs: _tabs.map((v) => Tab(text: '${v['name']}')).toList()),
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: _tabs.map((v) {
            return Container(
                margin: EdgeInsets.only(top: 15.w),
                child: widget.videoMark == 2
                    ? ShortTagVideoList(
                        sortType: v['type'] as int, tagsTitle: widget.tagsTitle)
                    : TagvideoList(
                        sortType: v['type'] as int,
                        tagsTitle: widget.tagsTitle,
                        videoMark: widget.videoMark,
                      ));
          }).toList(),
        ));
  }
}
