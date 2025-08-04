import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/generate/app_image_path.dart';

import '../../../assets/styles.dart';
import '../../../components/common_permission_alert.dart';
import '../../../routes/routes.dart';
import '../../../utils/color.dart';
import '../frontpage/controller/edit_userinfo_controller.dart';

///编辑简介
class EditUserIntroductionPage extends StatelessWidget {
  const EditUserIntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = Styles.color.bgColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("编辑个人资料",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
            )),
        centerTitle: true,
      ),
      body: const EditUserPersignChild(),
    );
  }
}

class EditUserPersignChild extends StatefulWidget {
  const EditUserPersignChild({super.key});

  @override
  State<StatefulWidget> createState() => EditUserPersignChildState();
}

class EditUserPersignChildState extends State<EditUserPersignChild> {
  TextEditingController contentController = TextEditingController();
  final controller = Get.find<EditUserInfoController>();

  void onSaveClick() {
    if (contentController.text.isEmpty) {
      EasyToast.show('请输入简介信息');
      return;
    }
    if (!controller.us.isVIP) {
      permission_alert(Get.context!, desc: "您还不是会员,会员才可以修改！", oktitle: "去开通",
          okAction: () {
        Get.toVip();
      });
      return;
    }
    controller.postModifyInfo(persign: contentController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w, bottom: 30.w),
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 360.w,
                    ),
                    child: TextField(
                      maxLines: null,
                      minLines: 7,
                      controller: contentController,
                      maxLength: 30,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.w,
                      ),
                      decoration: InputDecoration(
                        hintText: controller.userInfo.personSign.isEmpty
                            ? '点击添加签名，让大家认识你…'
                            : controller.userInfo.personSign,
                        helperText: '签名最多30字',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 15.w,
                        ),
                        helperStyle: TextStyle(
                          color: COLOR.color_B940FF,
                          fontSize: 13.w,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: COLOR.hexColor('#F0F0F0'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => onSaveClick(),
              child: AppBgView(
                width: double.maxFinite,
                height: 40.w,
                imagePath: AppImagePath.mine_img_exchange_vip_bg,
                fit: BoxFit.fill,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "保存",
                      style: TextStyle(
                        fontSize: 14.w,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
