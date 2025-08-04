import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/generate/app_image_path.dart';

import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/services/user_service.dart';

import 'controller.dart';

class PortrayPlayPage extends StatefulWidget {
  const PortrayPlayPage({
    super.key,
  });

  @override
  State<PortrayPlayPage> createState() => _PortrayPlayPageState();
}

class _PortrayPlayPageState extends State<PortrayPlayPage> {
  final PicturePlayController controller = Get.put(PicturePlayController());
  final userInfoControll = Get.find<UserService>();

  final PageController pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.initDetail();
  }

  Widget _buildNotCanWatch(int picType, int price) {
    final buttonPadding = EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.w);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '试看已结束',
                  style: TextStyle(
                    fontSize: 16.w,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                Text(
                  picType == 2 ? '支付$price金币解锁完整内容' : '开通会员观看完整内容, 邀请好友得会员',
                  style: TextStyle(
                    fontSize: 14.w,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                /// 不能看原因：1-vip 2-付费
                if (picType == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toShare();
                        },
                        child: Container(
                          padding: buttonPadding,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
                            color: const Color(0xffFEF100),
                          ),
                          child: Text(
                            '邀请好友',
                            style: TextStyle(
                              fontSize: 14.w,
                              color: Color(0xff0C0935),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toVip();
                        },
                        child: Container(
                          padding: buttonPadding,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
                            color: const Color(0xffB93FFF),
                          ),
                          child: Text(
                            '开通会员',
                            style: TextStyle(
                              fontSize: 14.w,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (picType == 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: buttonPadding,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
                            color: const Color(0xffFEF100),
                          ),
                          child: Text(
                            '上传动态',
                            style: TextStyle(
                              fontSize: 14.w,
                              color: const Color(0xff0C0935),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.pay();
                        },
                        child: Container(
                          padding: buttonPadding,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.w),
                            color: const Color(0xffB93FFF),
                          ),
                          child: Text(
                            '$price金币购买',
                            style: TextStyle(
                              fontSize: 14.w,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<PicturePlayController>(
          init: controller,
          builder: (controller) {
            final imgList = controller.detail.imgList;

            final canWatch = controller.detail.canWatch;

            final price = controller.detail.price;

            final picType = controller.detail.picType;

            return Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: userInfoControll.isVIP ? imgList?.length ?? 0 : 3,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    if (canWatch == true) {
                      return ImageView(
                        src: imgList?[index] ?? '',
                        fit: BoxFit.contain,
                      );
                    }

                    return Stack(
                      children: [
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: ImageView(
                            src: imgList?[index] ?? '',
                            fit: BoxFit.contain,
                          ),
                        ),
                        if (!userInfoControll.isVIP && index > 1)
                          _buildNotCanWatch(picType ?? 0, price ?? 0),
                      ],
                    );
                  },
                ),
                Positioned(
                  top: 44.h,
                  left: 0, // 将 left 设置为 0
                  right: 0, // 将 right 设置为 0
                  child: Center(
                    // 使用 Center 小部件来居中
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.w),
                      // decoration: BoxDecoration(
                      //   color: const Color.fromRGBO(0, 0, 0, .5),
                      //   borderRadius: Styles.borderRadius.m,
                      // ),
                      child: Text(
                        '${_currentPage + 1}/${imgList?.length ?? 0}',
                        style: TextStyle(
                          fontSize: 14.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 58.w,
                  left: 14.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      AppImagePath.icons_ic_back,
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ),
                Positioned(
                  left: 10.w,
                  bottom: 30.h,
                  child: Text(
                    controller.detail.title ?? '',
                    style: TextStyle(
                      fontSize: 13.w,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
