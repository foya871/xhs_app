import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/invitecode/invite_code_page_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../assets/colorx.dart';
import '../../../assets/styles.dart';
import '../../../components/easy_toast.dart';
import '../../../services/user_service.dart';
import '../../../utils/color.dart';

class InviteCodePage extends StatelessWidget {
  const InviteCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = Styles.color.bgColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("邀请码",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.w,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: const InviteCodeChild(),
    );
  }
}

class InviteCodeChild extends StatefulWidget {
  const InviteCodeChild({super.key});

  @override
  State<StatefulWidget> createState() => InviteCodeChildState();
}

class InviteCodeChildState extends State<InviteCodeChild> {
  TextEditingController contentController = TextEditingController();
  final service = Get.find<UserService>();

  final controller = Get.find<InviteCodePageController>();

  void onSaveClick() {
    if (contentController.text.isEmpty) {
      EasyToast.show('请填写上级邀请码');
      return;
    }

    controller.postInviteCode(contentController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 36.w)),
                  Text(
                    "我的邀请码",
                    style: TextStyle(
                      fontSize: 14.w,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 7.w)),
                  Text(
                    "${service.user.inviteCode}",
                    style: TextStyle(
                      fontSize: 18.w,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 23.w),
                  QrImageView(
                    padding: EdgeInsets.all(1.w),
                    data: controller.url.value,
                    size: 135,
                    backgroundColor: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(top: 24.w)),
                  Container(
                    height: 40.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: contentController,
                      focusNode: controller.node,
                      onEditingComplete: () {
                        controller.node.unfocus();
                      },
                      style: TextStyle(
                        color: ColorX.color_333333,
                        fontSize: 15.w,
                      ),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        hintText: '请填写上级邀请码',
                        hintStyle: TextStyle(
                          color: ColorX.color_999999,
                          fontSize: 15.w,
                        ),
                        helperStyle: TextStyle(
                          color: ColorX.color_999999,
                          fontSize: 13.w,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ).onTap(() {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 28.w)),
              InkWell(
                onTap: () => onSaveClick(),
                child: AppBgView(
                  width: double.maxFinite,
                  height: 41.w,
                  imagePath: AppImagePath.mine_img_exchange_vip_bg,
                  fit: BoxFit.fill,
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "确认绑定",
                        style: TextStyle(
                          fontSize: 18.w,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
