import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/frontpage/controller/login_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../assets/colorx.dart';
import '../../../components/text_view.dart';
import '../../../generate/app_image_path.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerTwo = TextEditingController();
  final controller = Get.find<LoginRegisterController>();

  void onClick() async {
    final name = nameController.text;
    if (name.isEmpty) {
      EasyToast.show('请输入账号名称');
      return;
    }
    if (name.length > 8) {
      EasyToast.show('请输入最多8位的账号名称');
      return;
    }
    final pass = passwordController.text;
    if (pass.isEmpty) {
      EasyToast.show('请输入密码');
      return;
    }

    if (pass.length < 6 || pass.length > 20) {
      EasyToast.show('请输入6-20位的密码');
      return;
    }

    final repass = passwordControllerTwo.text;
    if (repass.isEmpty) {
      EasyToast.show('请输入密码');
      return;
    }

    if (repass.length < 6 || repass.length > 20) {
      EasyToast.show('请输入6-20位的密码');
      return;
    }

    if (repass != pass) {
      EasyToast.show('两次密码不一致！');
      return;
    }

    var result = await controller.postRegister(
        nameController.text.trim(), passwordController.text.trim());
    if (result) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 14.w, top: 44.w, right: 14.w),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "注册账号",
                style: TextStyle(
                  fontSize: 20.w,
                  fontWeight: FontWeight.w600,
                  color: ColorX.color_333333,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30.w)),
              TextField(
                controller: nameController,
                style: TextStyle(
                  color: ColorX.color_333333,
                  fontSize: 14.w,
                ),
                decoration: InputDecoration(
                  hintText: '请输入账号名称（最多8位）',
                  hintStyle: TextStyle(
                    color: ColorX.color_999999,
                    fontSize: 14.w,
                  ),
                  helperStyle: TextStyle(
                    color: ColorX.color_999999,
                    fontSize: 11.w,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.13),
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.13),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.13),
                      width: 1.0,
                    ),
                  ),
                  counter: const SizedBox.shrink(),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30.w)),
              TextField(
                controller: passwordController,
                style: TextStyle(
                  color: ColorX.color_333333,
                  fontSize: 14.w,
                ),
                decoration: InputDecoration(
                  hintText: '请输入密码',
                  hintStyle: TextStyle(
                    color: ColorX.color_999999,
                    fontSize: 14.w,
                  ),
                  helperStyle: TextStyle(
                    color: ColorX.color_999999,
                    fontSize: 11.w,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.13),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.13),
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.13),
                      width: 1.0,
                    ),
                  ),
                  counter: const SizedBox.shrink(),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30.w)),
              TextField(
                controller: passwordControllerTwo,
                style: TextStyle(
                  color: ColorX.color_333333,
                  fontSize: 14.w,
                ),
                decoration: InputDecoration(
                  hintText: '请再次输入密码',
                  hintStyle: TextStyle(
                    color: ColorX.color_999999,
                    fontSize: 14.w,
                  ),
                  helperStyle: TextStyle(
                    color: ColorX.color_999999,
                    fontSize: 11.w,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.13),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.13),
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.13),
                      width: 1.0,
                    ),
                  ),
                  counter: const SizedBox.shrink(),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 40.w)),
              Container(
                width: 332.w,
                height: 40.w,
                margin: EdgeInsets.only(bottom: 16.w),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImagePath.mine_icon_big_button),
                  ),
                ),
                child: TextView(
                  text: "注册",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.white,
                ),
              ).onOpaqueTap(() {
                onClick();
              }),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                    text: "已有账号，去登录>",
                    fontSize: 13.w,
                    color: ColorX.color_333333,
                  ).onOpaqueTap(() {
                    Get.back();
                    // onCLick(2);
                  }),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20.w)),
              Text(
                "温馨提示：",
                style: TextStyle(
                  fontSize: 13.w,
                  color: ColorX.color_333333,
                  fontWeight: FontWeight.w600,
                ),
              ).marginOnly(bottom: 10.w),
              Text(
                "1 请记住自己的账号密码",
                style: TextStyle(
                  fontSize: 13.w,
                  height: 23 / 13,
                  color: COLOR.hexColor('#666666'),
                ),
              ),
              Text(
                "2 不退供密码修改服务",
                style: TextStyle(
                  fontSize: 13.w,
                  height: 23 / 13,
                  color: COLOR.hexColor('#666666'),
                ),
              ),
              Text(
                "3 不提供密码找回功能",
                style: TextStyle(
                  fontSize: 13.w,
                  height: 23 / 13,
                  color: COLOR.hexColor('#666666'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
