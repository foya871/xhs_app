/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-10-22 09:31:20
 * @LastEditors: wangdazhuang
 * @LastEditTime: 2024-12-11 17:50:44
 * @FilePath: /xhs_app/lib/src/views/video_collect/video_clollect.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:xhs_app/views/video_collect/collectvideo_list.dart';

class VideoClollect extends StatefulWidget {
  final int collectionId;
  final String collectionName;

  const VideoClollect({
    super.key,
    required this.collectionId,
    required this.collectionName,
  });

  @override
  State<VideoClollect> createState() => _TagVideos();
}

class _TagVideos extends State<VideoClollect>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final _tabs = [
    {'name': '最近更新', 'type': 2},
    {'name': '最多观看', 'type': 1},
    {'name': '最多收藏', 'type': 3},
  ];

  @override
  void initState() {
    tabController = TabController(length: _tabs.length, vsync: this);
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.collectionName,
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Column(
              children: [
                Container(
                  height: 1.0,
                  color: COLOR.hexColor('#F0F0F0'),
                ),
                TabBar(
                    labelColor: COLOR.hexColor('#D8201D'),
                    unselectedLabelColor: COLOR.hexColor('#666666'),
                    indicatorColor: COLOR.hexColor('D8201D'),
                    labelStyle:
                        TextStyle(fontSize: 14.w, fontWeight: FontWeight.w600),
                    unselectedLabelStyle:
                        TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500),
                    dividerColor: Colors.transparent,
                    controller: tabController,
                    indicatorPadding: EdgeInsets.only(bottom: 6.w),
                    indicator: EasyFixedIndicator(
                      color: COLOR.hexColor('D8201D'),
                      width: 10.w,
                      height: 3.w,
                    ),
                    tabs: _tabs.map((v) => Tab(text: '${v['name']}')).toList())
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: _tabs.map((v) {
            return Container(
              color: Colors.white,
              child: CollectvideoList(
                sortType: v['type'] as int,
                collectionId: widget.collectionId,
              ),
            );
          }).toList(),
        ));
  }
}
