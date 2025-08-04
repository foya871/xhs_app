import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/model/blogger/blogger_fans_model.dart';
import 'package:xhs_app/model/mine/fans_club_model.dart';
import 'package:xhs_app/services/user_service.dart';

import '../../../http/api/api.dart';
import '../../../model/blogger/blogger_fans_group.dart';

class MineFansClubPageController extends GetxController {
  final userService = Get.find<UserService>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final nameNode = FocusNode();
  final groupAnnoController = TextEditingController();
  final groupAnnoNode = FocusNode();

  final monthPriceController = TextEditingController();
  final monthPriceNode = FocusNode();

  final seasonPriceController = TextEditingController();
  final seasonPriceNode = FocusNode();

  final yearPriceController = TextEditingController();
  final yearPriceNode = FocusNode();

  RxString coverImg = ''.obs;

  var blogger = BloggerFansGroupModel.fromJson({}).obs;
  @override
  void onInit() {
    super.onInit();
    getFansGroupConfig();
    // getFansGroupList();
  }

  RxInt monthPrice = 0.obs;

  Future<void> queryFansGroup() async {
    final result = await Api.queryFansGroupByUserId(userService.user.userId);
    if (result != null) {
      blogger.value = result;
      update();
    }
  }

  RxList<BloggerFansModel> fansRankingList = <BloggerFansModel>[].obs;

  getFansRankingList() {
    Api.queryFansRankingList(userService.user.userId ?? 0, 1, 100)
        .then((value) {
      if (value.isNotEmpty) {
        fansRankingList.value = value;
      }
    });
  }

  Future<void> getFansGroupConfig() async {
    final result = await Api.getFansGroupConfig();
    if (result != null) {
      monthPrice.value = result;
    }
  }

  Future<bool> createGroup() async {
    final result = await Api.createFansGroup(
      coverImg: coverImg.value,
      groupAnno: groupAnnoController.text,
      groupName: nameController.text,
      monthTicketPrice: double.parse(monthPriceController.text),
      seasonTicketPrice: double.parse(seasonPriceController.text),
      yearTicketPrice: double.parse(yearPriceController.text),
    );
    if (result == true) {
      EasyToast.show('创建成功');
      return true;
    } else {
      EasyToast.show('创建失败');
      return false;
    }
  }

  Future<bool> updateGroup() async {
    final result = await Api.updateGroup(
      groupId: blogger.value.groupId ?? 0,
      coverImg: coverImg.value,
      groupAnno: groupAnnoController.text,
      groupName: nameController.text,
      monthTicketPrice: double.parse(monthPriceController.text),
      seasonTicketPrice: double.parse(seasonPriceController.text),
      yearTicketPrice: double.parse(yearPriceController.text),
    );
    if (result == true) {
      EasyToast.show('编辑成功');
      return true;
    } else {
      EasyToast.show('编辑失败');
      return false;
    }
  }

  RxList<FansClubModel> fansGroupList = <FansClubModel>[].obs;

  RxList<FansClubModel> hotList = <FansClubModel>[].obs;

  ///获取我加入的粉丝团
  Future<void> getFansGroupList() async {
    final result = await Api.getBuyFansClubDataList(
      page: 1,
      pageSize: 100,
    );
    if (result != null) {
      fansGroupList.value = result;
    }
  }

  Future<void> getHotList() async {
    final result = await Api.getHostList();
    if (result != null) {
      hotList.value = result;
    }
  }
}
