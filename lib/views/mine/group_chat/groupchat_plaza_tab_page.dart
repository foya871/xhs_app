import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/mine/group_chat/groupchat_plaza_page.dart';
import 'package:xhs_app/views/mine/group_chat/groupchat_plaza_tab_controller.dart';

import '../../../assets/styles.dart';
import '../../../components/text_view.dart';
import '../../../utils/color.dart';

class GroupChatPlazaTabPage extends GetView<GroupChatPlazaTabPageController>{
  const GroupChatPlazaTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupChatPlazaTabPageController>(
        builder: (controller){
          return Scaffold(
            backgroundColor: Styles.color.bgColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: TextView(
                text: "群聊广场",
                textAlign: TextAlign.center,
                fontSize: 16.w,
                color: COLOR.color_333333,
                fontWeight: FontWeight.w600,
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 1,
              shadowColor: COLOR.color_EEEEEE,
            ),
            body: _bodyView(),
          );
        }
    );
  }

  _bodyView(){
    return Column(
      children: [
        SizedBox(height: 11.w),
        Container(
          width: double.infinity,
          height: 25.w,
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: controller.tabController,
            tabAlignment: TabAlignment.start,
            tabs: controller.tabs,
            isScrollable: true,
            labelStyle: TextStyle(
              fontSize: 15.w,
              color: COLOR.color_333333,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 15.w,
              color: COLOR.color_999999,
            ),
            indicator: const BoxDecoration(),
            dividerHeight: 0,
            labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
          ),
        ),
        SizedBox(height: 10.w),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: controller.tabs.asMap().entries.map((v){
              return GroupChatPlazaPage(classifyName: v.value.text!);
            }).toList(),
          ),
        ),
      ],
    );
  }
}