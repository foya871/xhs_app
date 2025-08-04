import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/frontpage/controller/login_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../assets/colorx.dart';
import '../../../components/text_view.dart';
import '../../../generate/app_image_path.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: COLOR.color_FAFAFA,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: const LoginRegisterPageState(),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController contentController = TextEditingController();
  TextEditingController contentControllerTwo = TextEditingController();
  final controller = Get.find<LoginRegisterController>();

  void onCLick(int index) {
    switch (index) {
      case 1:
        final name = contentController.text;
        if (name.isEmpty) {
          EasyToast.show('请输入账号名称');
          return;
        }
        if (name.length > 8) {
          EasyToast.show('请输入最多8位的账号名称');
          return;
        }

        final pass = contentControllerTwo.text;
        if (pass.isEmpty) {
          EasyToast.show('请输入密码');
          return;
        }

        if (pass.length < 6 || pass.length > 20) {
          EasyToast.show('请输入6-20位的密码');
          return;
        }

        controller.postLogin(name.trim(), pass.trim());
        break;
      case 2:
        Get.toNamed(Routes.register);
        break;
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
                "登录账号",
                style: TextStyle(
                  fontSize: 20.w,
                  fontWeight: FontWeight.w600,
                  color: ColorX.color_333333,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30.w)),
              TextField(
                controller: contentController,
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
                controller: contentControllerTwo,
                style: TextStyle(
                  color: ColorX.color_333333,
                  fontSize: 14.w,
                ),
                decoration: InputDecoration(
                  hintText: '请输入密码最少6位字符',
                  // helperText: '账号无法修改，建议使用手机号/邮箱等常用信息',
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
                  text: "登录",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                  color: COLOR.white,
                ),
              ).onOpaqueTap(() {
                onCLick(1);
              }),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                    text: "没有账号，去注册>",
                    fontSize: 13.w,
                    color: ColorX.color_333333,
                  ).onOpaqueTap(() {
                    onCLick(2);
                  }),
                  // InkWell(
                  //   highlightColor: Styles.color.bgColor,
                  //   splashColor: Styles.color.bgColor,
                  //   onTap: () => onCLick(2),
                  //   child: Container(
                  //     width: 160.w,
                  //     height: 40.w,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       border: Border.all(
                  //         color: COLOR.hexColor('#B940FF'),
                  //         width: 1.0,
                  //       ),
                  //     ),
                  //     child: Flex(
                  //       direction: Axis.horizontal,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "注册",
                  //           style: TextStyle(
                  //             fontSize: 14.w,
                  //             color: COLOR.hexColor('#B940FF'),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(padding: EdgeInsets.only(left: 16.w)),
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
