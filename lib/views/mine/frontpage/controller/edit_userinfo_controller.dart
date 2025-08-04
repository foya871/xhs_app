import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/diolog/provinces_city/provinces_city_view.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/user/user_info_model.dart';
import 'package:get/get.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:tuple/tuple.dart';
import '../../../../components/easy_toast.dart';
import '../../../../http/api/login.dart';
import '../../../../model/image_upload_resp_model.dart';
import '../../../../model/mine/share_link_model.dart';
import '../../../../routes/routes.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/loading_dialog.dart';
import '../../../../utils/logger.dart';

class EditUserInfoController extends GetxController {
  final us = Get.find<UserService>();

  onInit() {
    nameController.text = us.user.nickName ?? "";
    signController.text = us.user.personSign ?? "";
    super.onInit();
  }

  var share = ShareRespModel();

  get userInfo => us.user;
  late final modifyresp;
  bool showAccount = true;
  final node = FocusNode();
  var currentCityCode = "".obs; //城市编码
  var currentCity = "".obs; //城市
  var currentDate = "".obs; //生日
  var currentHeight = "".obs; //身高
  var currentWeight = "".obs; //体重
  var currentPrefer = "".obs; //偏好
  var currentBodyType = "".obs; //体型
  var currentEmotion = "".obs; //感情状况
  var currentFriendShip = "".obs; //交友目的

  final List<String> preferColumnsItems = [
    '0',
    '偏0',
    '0.5',
    '偏1',
    '1',
    'TS伪娘',
    '不10',
    '保密'
  ];
  final List<String> bodyTypeColumnsItems = [
    '苗条',
    '运动',
    '肉状',
    '胖熊',
    '猴',
    '狒狒',
    '狼',
    '保密'
  ];
  final List<String> emotionColumnsItems = [
    '单身',
    '约会中',
    '有固定伴侣',
    '已婚',
    '开放关系',
    '保密'
  ];
  final List<String> friendshipColumnsItems = [
    '聊天',
    '约会',
    '朋友',
    '情侣',
    '立刻见面',
    '其他'
  ];

  Future postUploadImg(Uint8List bytes) async {
    showCustomDialog(Get.context!, "正在上传中,请稍候..");
    try {
      ImageUploadRspModel? resp =
          await httpInstance.uploadImage(bytes, (int count, int total) {
        logger.d("$count/$total");
      });
      if (resp != null) {
        final result = resp!.fileName;
        try {
          modifyresp = await httpInstance.post(url: 'user/modify/info', body: {
            'logo': result,
          });
        } catch (e) {
          if (e is Map) {}
        }
      }
      EasyToast.show('上传成功');
    } catch (_) {
      EasyToast.show('上传失败');
    }
    closeDialog(Get.context!);
  }

  Future<void> postModifyInfo({
    String name = "",
    String persign = "",
    String bgImg = "",
  }) async {
    showCustomDialog(Get.context!, "提交中,请稍候..");
    try {
      await httpInstance.post(url: 'user/modify/info', body: {
        'nickName': name.isEmpty ? "" : name,
        'personSign': persign.isEmpty ? "" : persign,
        'bgImg': bgImg.isEmpty ? "" : bgImg,
      });
      EasyToast.show('修改成功');
      Get.back();
    } catch (_) {
      EasyToast.show('修改失败');
    }
    closeDialog(Get.context!);
  }

  Future loginOut() async {
    showCustomDialog(Get.context!, "退出中,请稍候..");
    try {
      await httpInstance.post(url: 'user/account/logout');
      EasyToast.show('已退出登录');
      // refreshPage();
      Get.back();
    } catch (_) {}
    closeDialog(Get.context!);
  }

  Future postSetAccountPwd(String account, String pwd) async {
    showCustomDialog(Get.context!, "设置中,请稍候..");
    try {
      final resp = await httpInstance.post(
          url: 'user/register',
          body: {
            "account": account.trim(),
            "password": pwd.trim(),
          },
          complete: UserInfo.fromJson);
      if (resp is UserInfo) {
        localStore.setToken(resp.token!);
        EasyToast.show("设置成功");
        Get.back();
      }
    } catch (_) {}
    closeDialog(Get.context!);
  }

  Future<void> postExchangeVip(String reCode) async {
    showCustomDialog(Get.context!, "提交中,请稍候..");
    try {
      if (reCode.isNotEmpty) {
        await httpInstance.post(url: 'user/redeem/vip', body: {
          'reCode': reCode,
        });
      }
      EasyToast.show('兑换成功');
      Get.back();
    } catch (_) {}
    closeDialog(Get.context!);
  }

  Future getUserInfo() async {
    await us.updateAPIUserInfo();
  }

  void setShowAcc() {
    showAccount = false;
  }

  showCityPicker() {
    Get.bottomSheet(
      isScrollControlled: true,
      ProvincesCityView(
        locationCode: '110000',
        width: double.infinity,
        isAlert: false,
        cancel: () {
          Get.back();
        },
        confirm: (Tuple4 result) {
          currentCity.value = result.item4;
          currentCityCode.value = result.item3;
          Get.back();
        },
      ),
    );
  }

  showDatePicker() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 10.w),
      color: COLOR.color_111,
      width: double.infinity,
      height: 300.w,
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              SizedBox(width: 10.w),
              Expanded(
                child: Text("取消",
                        style: TextStyle(fontSize: 14.w, color: COLOR.white))
                    .onTap(() => Get.back()),
              ),
              Expanded(
                  child: Text(
                "出生日期",
                style: TextStyle(fontSize: 16.w, color: COLOR.white),
                textAlign: TextAlign.center,
              )),
              Expanded(
                child: Text(
                  "确认",
                  style: TextStyle(
                    fontSize: 14.w,
                    color: COLOR.white,
                  ),
                  textAlign: TextAlign.right,
                ).onTap(() => Get.back()),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 10.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_CD73FB,
          ),
          Expanded(
            child: CupertinoTheme(
                data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle:
                      TextStyle(color: COLOR.white, fontSize: 20.w),
                )),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  dateOrder: DatePickerDateOrder.ymd,
                  onDateTimeChanged: (DateTime newDateTime) {
                    currentDate.value =
                        "${newDateTime.year}-${newDateTime.month}-${newDateTime.day}";
                  },
                )),
          ),
        ],
      ),
    ));
  }

  showHeightWeightPicker() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 10.w),
      color: COLOR.color_111,
      width: double.infinity,
      height: 300.w,
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              SizedBox(width: 10.w),
              Expanded(
                child: Text("取消",
                        style: TextStyle(fontSize: 14.w, color: COLOR.white))
                    .onTap(() => Get.back()),
              ),
              Expanded(
                  child: Text(
                "身高体重",
                style: TextStyle(fontSize: 16.w, color: COLOR.white),
                textAlign: TextAlign.center,
              )),
              Expanded(
                child: Text(
                  "确认",
                  style: TextStyle(fontSize: 14.w, color: COLOR.white),
                  textAlign: TextAlign.right,
                ).onTap(() => Get.back()),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 10.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_CD73FB,
          ),
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: CupertinoPicker(
                      itemExtent: 40,
                      scrollController:
                          FixedExtentScrollController(initialItem: 0),
                      onSelectedItemChanged: (int value) {
                        currentHeight.value = (100 + value).toString();
                        if (currentWeight.value.isEmpty)
                          currentWeight.value = '30';
                      },
                      children: List<Widget>.generate(151, (int index) {
                        return Center(
                          child: Text(
                            '${100 + index}cm',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.w),
                          ),
                        );
                      })),
                ),
                Expanded(
                  child: CupertinoPicker(
                      itemExtent: 40,
                      scrollController:
                          FixedExtentScrollController(initialItem: 0),
                      onSelectedItemChanged: (int value) {
                        currentWeight.value = (30 + value).toString();
                      },
                      children: List<Widget>.generate(121, (int index) {
                        return Center(
                          child: Text(
                            '${30 + index}kg',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.w),
                          ),
                        );
                      })),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  showPreferPicker() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 10.w),
      color: COLOR.color_111,
      width: double.infinity,
      height: 300.w,
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              SizedBox(width: 10.w),
              Expanded(
                child: Text("取消",
                        style: TextStyle(fontSize: 14.w, color: COLOR.white))
                    .onTap(() => Get.back()),
              ),
              Expanded(
                  child: Text(
                "我是",
                style: TextStyle(fontSize: 16.w, color: COLOR.white),
                textAlign: TextAlign.center,
              )),
              Expanded(
                child: Text(
                  "确认",
                  style: TextStyle(
                    fontSize: 14.w,
                    color: COLOR.white,
                  ),
                  textAlign: TextAlign.right,
                ).onTap(() => Get.back()),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 10.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_CD73FB,
          ),
          Expanded(
            child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (int index) {
                  currentPrefer.value = preferColumnsItems[index];
                },
                children: preferColumnsItems.map((item) {
                  return Center(
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.white, fontSize: 20.w),
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    ));
  }

  showBodyTypePicker() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 10.w),
      color: COLOR.color_111,
      width: double.infinity,
      height: 300.w,
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              SizedBox(width: 10.w),
              Expanded(
                child: Text("取消",
                        style: TextStyle(fontSize: 14.w, color: COLOR.white))
                    .onTap(() => Get.back()),
              ),
              Expanded(
                  child: Text(
                "体型",
                style: TextStyle(fontSize: 16.w, color: COLOR.white),
                textAlign: TextAlign.center,
              )),
              Expanded(
                child: Text(
                  "确认",
                  style: TextStyle(
                    fontSize: 14.w,
                    color: COLOR.white,
                  ),
                  textAlign: TextAlign.right,
                ).onTap(() => Get.back()),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 10.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_CD73FB,
          ),
          Expanded(
            child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (int index) {
                  currentBodyType.value = bodyTypeColumnsItems[index];
                },
                children: bodyTypeColumnsItems.map((item) {
                  return Center(
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.white, fontSize: 20.w),
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    ));
  }

  showEmotionPicker() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 10.w),
      color: COLOR.color_111,
      width: double.infinity,
      height: 300.w,
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              SizedBox(width: 10.w),
              Expanded(
                child: Text("取消",
                        style: TextStyle(fontSize: 14.w, color: COLOR.white))
                    .onTap(() => Get.back()),
              ),
              Expanded(
                  child: Text(
                "感情状况",
                style: TextStyle(fontSize: 16.w, color: COLOR.white),
                textAlign: TextAlign.center,
              )),
              Expanded(
                child: Text(
                  "确认",
                  style: TextStyle(fontSize: 14.w, color: COLOR.white),
                  textAlign: TextAlign.right,
                ).onTap(() => Get.back()),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 10.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_CD73FB,
          ),
          Expanded(
            child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (int index) {
                  currentEmotion.value = emotionColumnsItems[index];
                },
                children: emotionColumnsItems.map((item) {
                  return Center(
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.white, fontSize: 20.w),
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    ));
  }

  showFriendShipPicker() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 10.w),
      color: COLOR.color_111,
      width: double.infinity,
      height: 300.w,
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              SizedBox(width: 10.w),
              Expanded(
                child: Text("取消",
                        style: TextStyle(fontSize: 14.w, color: COLOR.white))
                    .onTap(() => Get.back()),
              ),
              Expanded(
                  child: Text(
                "交友目的",
                style: TextStyle(fontSize: 16.w, color: COLOR.white),
                textAlign: TextAlign.center,
              )),
              Expanded(
                child: Text(
                  "确认",
                  style: TextStyle(fontSize: 14.w, color: COLOR.white),
                  textAlign: TextAlign.right,
                ).onTap(() => Get.back()),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 10.w),
          Container(
            width: double.infinity,
            height: 1.w,
            color: COLOR.color_CD73FB,
          ),
          Expanded(
            child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (int index) {
                  currentFriendShip.value = friendshipColumnsItems[index];
                },
                children: friendshipColumnsItems.map((item) {
                  return Center(
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.white, fontSize: 20.w),
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    ));
  }

  void onClick(String str) {
    switch (str) {
      case "昵称":
        Get.toNamed(Routes.editusername);
        break;
      case "签名":
        Get.toNamed(Routes.edituserintroduction);
        break;
      case "切换账号":
        Get.back();
        Get.toNamed(Routes.login);
        break;
      case "城市":
        showCityPicker();
        break;
      case "出生日期":
        showDatePicker();
        break;
      case "身高体重":
        showHeightWeightPicker();
        break;
      case "我是":
        showPreferPicker();
        break;
      case "体型":
        showBodyTypePicker();
        break;
      case "感情状况":
        showEmotionPicker();
        break;
      case "交友目的":
        showFriendShipPicker();
        break;
      case "确认":
        postModifyInfo(
          name: nameController.text,
          persign: signController.text,
          bgImg: bgCoverImage.value,
        );
        break;
    }
  }

  TextEditingController nameController = TextEditingController();
  FocusNode nameNode = FocusNode();
  TextEditingController signController = TextEditingController();
  FocusNode signNode = FocusNode();

  RxString bgCoverImage = ''.obs;
}
