import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../http/api/api.dart';
import '../../model/user/user_info_model.dart';
import 'tab_child/collection_view.dart';
import 'tab_child/note_view.dart';
import 'tab_child/private_group_view.dart';
import 'tab_child/resource_view.dart';

class BloggerPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final noteController = NoteViewController();
  final privateGroupController = PrivateGroupViewController();
  final collectionController = CollectionViewController();
  final resourceController = ResourceViewController();
  late TabController tabController;
  int userId = 0;
  Rx<UserInfo> bloggerInfo = UserInfo.fromJson({}).obs;
  TextEditingController searchController = TextEditingController();
  List<Tab> tabs = const [
    Tab(text: '笔记'),
    Tab(text: '私人团'),
    Tab(text: '收藏'),
    Tab(text: '资源'),
  ];

  String getSearchText() => searchController.text.trim();

  var isShowSearch = false.obs;

  @override
  void onInit() {
    userId = Get.arguments['userId'];
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    getUserInfo();
  }

  /// 获取用户信息
  getUserInfo() {
    Api.queryBloggerInfo(userId.toString()).then((value) {
      if (value != null) {
        bloggerInfo.value = value;
      }
    });
  }

  startSearch() => switch (tabController.index) {
        0 => noteController.refresh(),
        1 => privateGroupController.refresh(),
        2 => collectionController.refresh(),
        3 => resourceController.refresh(),
        _ => () {},
      };

  void attentionBlogger() {
    if (bloggerInfo.value.attentionHe == true) {
      ///取消关注
      Api.cancelAttentionUser(userId).then((value) {
        if (value) {
          bloggerInfo.update((val) {
            val!.attentionHe = false;
          });
          getUserInfo();
        }
      });
    } else {
      ///关注
      Api.attentionUser(userId).then((value) {
        if (value) {
          bloggerInfo.update((val) {
            val!.attentionHe = true;
          });
          getUserInfo();
        }
      });
    }
  }
}
