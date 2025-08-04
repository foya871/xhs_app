import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import '../../../assets/colorx.dart';
import '../../../assets/styles.dart';
import '../../../components/save_screen/save_screen.dart';
import '../../../utils/color.dart';
import 'controller/account_credentials_controller.dart';

///账号凭证
class AccountCredentialsPage extends StatelessWidget {
  const AccountCredentialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = Styles.color.bgColor;
    ScreenshotController screenshotController = ScreenshotController();

    void onBackClick() {
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 20.w,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => onBackClick(),
        ),
        title: Text("账号凭证",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.w,
              fontWeight: FontWeight.w500,
            )),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: COLOR.hexColor("#4d393549"))),
            ),
          ),
        ),
      ),
      body: GetBuilder<AccountCredentialsController>(
          init: AccountCredentialsController(),
          builder: (controller) {
            return AccountCredentialsPageChild(
                controller, screenshotController);
          }),
    );
  }
}

class AccountCredentialsPageChild extends StatelessWidget {
  final AccountCredentialsController controller;
  final ScreenshotController screenshotController;

  const AccountCredentialsPageChild(this.controller, this.screenshotController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 89.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 280.w,
                    height: 312.w,
                    child: Stack(
                      children: [
                        Image.asset(
                          AppImagePath.mine_img_account_creden_bg_top,
                          width: 280.w,
                          height: 312.w,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 30.w, left: 19.w, right: 19.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  AppImagePath.mine_img_account_title_tips,
                                  width: 88.w,
                                  height: 25.w,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 14.w)),
                              Text(
                                "身份卡是除绑定手机号外唯一可以用于恢复/切换账号的凭证，请及时保存 保存后请妥善保管切勿丢失或泄露给他人",
                                style: TextStyle(
                                  fontSize: 13.w,
                                  color: ColorX.color_333333,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 20.w)),
                              Text(
                                "您的账号信息",
                                style: TextStyle(
                                  fontSize: 15.w,
                                  color: ColorX.color_333333,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.w)),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    "用户名",
                                    style: TextStyle(
                                      fontSize: 14.w,
                                      color: ColorX.color_333333,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.w)),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10.w),
                                      height: 38.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(2.r),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${controller.userInfo.nickName}",
                                          style: TextStyle(
                                            fontSize: 14.w,
                                            color: COLOR.hexColor('#cc333333'),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.w)),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    "用户ID",
                                    style: TextStyle(
                                      fontSize: 14.w,
                                      color: ColorX.color_333333,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.w)),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10.w),
                                      height: 38.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(2.r),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${controller.userInfo.userId}",
                                          style: TextStyle(
                                            fontSize: 14.w,
                                            color: COLOR.hexColor('#cc333333'),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 280.w,
                    height: 82.w,
                    child: Stack(
                      children: [
                        Image.asset(
                          AppImagePath.mine_img_account_creden_bg_bottom,
                          width: 280.w,
                          height: 82.w,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 19.w),
                                      child: Text(
                                        "扫描二维码恢复账号",
                                        style: TextStyle(
                                          fontSize: 14.w,
                                          color: ColorX.color_333333,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 4.w)),
                                    Container(
                                      padding: EdgeInsets.only(left: 19.w),
                                      child: Text(
                                        controller.share.url ??
                                            "http://www.baidu.com",
                                        style: TextStyle(
                                          fontSize: 13.w,
                                          color: ColorX.color_333333,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 70.w,
                                height: 70.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                                child: QrImageView(
                                  data:
                                      '${controller.storageService.deviceId}*${controller.userInfo.userId}',
                                  size: 70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 41.w)),
            InkWell(
              highlightColor: Styles.color.bgColor,
              splashColor: Styles.color.bgColor,
              onTap: () =>
                  SaveScreen.onCaptureClick(context, screenshotController),
              child: Container(
                width: 186.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: COLOR.hexColor('#eb29c6'),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "保存到相册",
                    style: TextStyle(
                      fontSize: 14.w,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
