import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import '../../../assets/colorx.dart';
import '../../../assets/styles.dart';
import '../../../components/easy_toast.dart';
import '../../../utils/color.dart';
import 'controller/edit_userinfo_controller.dart';

class ExchangeVipPage extends StatelessWidget {
  const ExchangeVipPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = Styles.color.bgColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("兑换会员",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.w,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: const ExchangeVipCodeChild(),
    );
  }
}

class ExchangeVipCodeChild extends StatefulWidget {
  const ExchangeVipCodeChild({super.key});

  @override
  State<StatefulWidget> createState() => ExchangeVipCodeChildState();
}

class ExchangeVipCodeChildState extends State<ExchangeVipCodeChild> {
  TextEditingController contentController = TextEditingController();

  final controller = Get.find<EditUserInfoController>();

  void onSaveClick() {
    if (contentController.text.isEmpty) {
      EasyToast.show('请输入兑换码');
      return;
    }
    controller.postExchangeVip(contentController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: COLOR.hexColor('#F5F5F5'),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    focusNode: controller.node,
                    controller: contentController,
                    textAlignVertical: TextAlignVertical.center,
                    onEditingComplete: () {
                      controller.node.unfocus();
                    },
                    style: TextStyle(
                      color: ColorX.color_333333,
                      fontSize: 15.w,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: '请输入兑换码',
                      hintStyle: TextStyle(
                        color: ColorX.color_999999,
                        fontSize: 15.w,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 50.w)),
                Text(
                  "兑换规则：",
                  style: TextStyle(
                    fontSize: 14.w,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 7.w)),
                Text(
                  "1.每张兑换码仅限使用一次",
                  style: TextStyle(
                    fontSize: 12.w,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 7.w)),
                Text(
                  "2.切勿频繁尝试兑换，如频繁验证系统将限制兑换",
                  style: TextStyle(
                    fontSize: 12.w,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 150.w),
            InkWell(
              onTap: () => onSaveClick(),
              child: AppBgView(
                height: 40.w,
                fit: BoxFit.fill,
                imagePath: AppImagePath.mine_img_exchange_vip_bg,
                text: "确认兑换",
                textStyle: TextStyle(fontSize: 14.w, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
