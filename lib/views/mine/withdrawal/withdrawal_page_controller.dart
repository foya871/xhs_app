import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/services/user_service.dart';

class MineWithdrawalPageController extends GetxController {
  final userService = Get.find<UserService>();

  RxInt purType = 1.obs; // 1-余额; 2-金币
  void changePurType(int type) {
    purType.value = type;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController moneyController = TextEditingController();
  final TextEditingController accountController = TextEditingController();

  RxString receiptName = "".obs;
  RxString accountNo = "".obs;
  RxDouble money = 0.0.obs;

  void withdrawal() {
    Api.withdrawal(
        accountNo.value, money.value, 1, purType.value, receiptName.value);
  }
}
