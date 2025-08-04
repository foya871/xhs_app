import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/components/adult_game_host_type/adult_game_host_type.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/model/adult_game_detail_model/adult_game_detail_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/widget_utils.dart';

import '../../../generate/app_image_path.dart';
import '../../../utils/dialog_utils.dart';
import '../../community/common/base/community_utils.dart';
import 'controller.dart';

class AdultGameDetailPage extends StatefulWidget {
  const AdultGameDetailPage({
    super.key,
  });

  @override
  State<AdultGameDetailPage> createState() => _AdultGameDetailPageState();
}

class _AdultGameDetailPageState extends State<AdultGameDetailPage> {
  final logic = Get.put(AdultGameDetailController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AdultGameDetailController>();
    super.dispose();
  }

  final double _dialogHeight = 282.w;

  final TextStyle _textStyle = TextStyle(
    fontSize: 16.w,
    color: Colors.white,
    letterSpacing: 0,
  );

  Widget _buildHeader(AdultGameDetailModel game) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 400 / 240,
          child: ImageView(src: game.coverPicture ?? ''),
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
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5), // 添加背景颜色和透明度
              ),
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
              child: Column(
                children: [
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Text(
                  //     game.gameName ?? '',
                  //     textAlign: TextAlign.left,
                  //     maxLines: 2,
                  //     style: TextStyle(
                  //         fontSize: 14.w,
                  //         color: Colors.white,
                  //         letterSpacing: 0.44.w,
                  //         overflow: TextOverflow.ellipsis),
                  //   ),
                  // ),
                  SizedBox(
                    height: 2.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "V${game.gameVersion}",
                        style: TextStyle(
                          fontSize: 14.w,
                          color: Colors.white,
                          letterSpacing: 0.44.w,
                          fontFamily: "PingFangSC-Medium",
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 60.w,
                        child: GestureDetector(
                          onTap: () {
                            Get.find<AdultGameDetailController>().fav();
                          },
                          child: Image.asset(
                            game.isFavorite == true
                                ? "assets/game/ic_fav_1.png"
                                : "assets/game/ic_fav_0.png",
                            // width: 77.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2.w),
                        child: Center(
                          child: AdultGameHostTypeView(
                            hostTypes: [game.hostType ?? 0],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget _buildPreview(AdultGameDetailModel game) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 14.w),
            child: Text(
              game.gameName ?? '',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16.w,
                  color: const Color(0xff333333),
                  letterSpacing: 0.5.w,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          height: 25.w,
        ),
        Row(
          children: [
            SizedBox(
              width: 14.w,
            ),
            Text(
              "游戏预览",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16.w,
                  color: const Color(0xff333333),
                  letterSpacing: 0.5.w,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        SizedBox(
          height: 12.w,
        ),
        SizedBox(
          width: double.infinity,
          height: 104.w,
          // padding: EdgeInsets.only(left: 14.w),
          child: ListView.separated(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 14.w, right: 14.w),
              itemBuilder: (context, index) {
                // return Text(game.publicityList![index]);
                return AspectRatio(
                  aspectRatio: 182 / 104,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.w),
                      child: ImageView(src: game.publicityList![index])),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.w,
                );
              },
              itemCount: game.publicityList?.length ?? 0),
        )
      ],
    );
  }

  Widget _paddingClipRRectContainer(Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.w),
        child: Container(
          color: const Color(0xfff52443),
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }

  List<Widget> _buyGame(AdultGameDetailModel game) {
    final userService = Get.find<UserService>();
    String freeText = "";
    if (userService.user.adultGameFreeNum! > 0) {
      freeText = "(会员权益${userService.user.adultGameFreeNum}次解锁)";
    }

    return [
      GetBuilder<AdultGameDetailController>(
        builder: (controller) {
          return _paddingClipRRectContainer(TextButton(
              onPressed: () {
                controller.buyGame();
              },
              child: Text(
                "${game.priceGold}金币解锁$freeText",
                style: _textStyle,
              )));
        },
      ),
    ];
  }

  Widget _viewGameLinks() {
    return GetBuilder<AdultGameDetailController>(builder: (controller) {
      List<Widget> list = [];

      if (controller.game.value.downUrl != null) {
        list.add(_paddingClipRRectContainer(Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Clipboard.setData(
                    ClipboardData(text: controller.game.value.downUrl!));
                SmartDialog.showToast('复制成功', alignment: Alignment.center);
                Navigator.pop(context);
              },
              child: Text(
                "安卓下载",
                style: _textStyle,
              ),
            ),
          ),
        )));
      }

      if (controller.game.value.pcDownUrl != null) {
        if (list.isNotEmpty) {
          list.add(SizedBox(
            height: 13.w,
          ));
        }

        list.add(_paddingClipRRectContainer(Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Clipboard.setData(
                    ClipboardData(text: controller.game.value.pcDownUrl!));
                SmartDialog.showToast('复制成功', alignment: Alignment.center);
                Navigator.pop(context);
              },
              child: Text(
                "PC端下载",
                style: _textStyle,
              ),
            ),
          ),
        )));
      }

      return _paddingClipRRectContainer(TextButton(
          onPressed: () {
            showDialog(
                context: Get.context!,
                // barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                    child: _buildDialogChildWrap([
                      Text("为了资源不被爆，请不要在线解压文件",
                          style: TextStyle(
                              color: const Color(0xff333333),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.w)),
                      SizedBox(
                        height: 24.w,
                      ),
                      ...list,
                    ]),
                  );
                });
          },
          child: Text(
            "查看链接",
            style: _textStyle,
          )));
    });
  }

  Widget _viewGameCode() {
    return GetBuilder<AdultGameDetailController>(builder: (controller) {
      return GestureDetector(
          onTap: () {
            Clipboard.setData(
                ClipboardData(text: controller.game.value.cheatNum!));
            SmartDialog.showToast('复制成功', alignment: Alignment.center);
          },
          child:
              Image.asset("assets/game/bg_copy_code.png", width: (294 / 3).w));
    });
  }

  Widget _buildDialogChildWrap(List<Widget> list) {
    return GetBuilder<AdultGameDetailController>(
      builder: (controller) {
        return Container(
          width: 320.w,
          height: _dialogHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 55.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xffF0F0F0)))),
                child: Text(
                  "温馨提示",
                  style: TextStyle(
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.w),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.w)),
              ...list,
            ],
          ),
        );
      },
    );
  }

  Widget _buyCode() {
    return GetBuilder<AdultGameDetailController>(
      builder: (controller) {
        return TextButton(
            onPressed: () {
              showDialog(
                  context: Get.context!,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      child: _buildDialogChildWrap([
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "${controller.game.value.cheatNumPrice}金币 ",
                              style: TextStyle(
                                  fontSize: 16.w,
                                  letterSpacing: 0.57.w,
                                  color: const Color(0xfff5008c),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "查看作弊码",
                              style: TextStyle(
                                  color: const Color(0xff333333),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.w)),
                        ])),
                        Padding(padding: EdgeInsets.only(top: 10.w)),
                        Text(
                          "购买之后即可永久使用",
                          style: TextStyle(
                              color: const Color(0xff333333), fontSize: 16.w),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 28.w, right: 28.w, top: 30.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 112.w,
                                  height: 36.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffeeeeee),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "稍后再说",
                                    style: TextStyle(
                                        color: const Color(0xff666666),
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.buyGameCode();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 112.w,
                                  height: 36.w,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xffF78248),
                                          Color(0xffF52C0F),
                                          Color(0xffF5019A)
                                        ]),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "立即支付",
                                    style: TextStyle(
                                        color: const Color(0xffffffff),
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                    );
                  });
            },
            child: Text(
              "查看作弊码",
              style: TextStyle(
                  color: const Color(0xffdd001b),
                  fontWeight: FontWeight.w700,
                  fontSize: 16.w,
                  letterSpacing: 0,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xffdd001b),
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 2.0),
            ));
      },
    );
  }

  List<Widget> _buyedGame(AdultGameDetailModel game) {
    if (game.hasCheatNum == false) {
      return [
        _viewGameLinks(),
      ];
    }

    if (game.isLockCheatNum == false) {
      return [_viewGameLinks(), _buyCode()];
    }
    return [_viewGameLinks(), _viewGameCode()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Icon(
              Icons.arrow_back_ios,
              size: 24.r,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                var detail = logic.game.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ImageView(
                          src: detail.coverPicture ?? '',
                          width: 1.sw,
                          height: 190.h,
                          fit: BoxFit.cover,
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  ImageView(
                                    src: detail.coverPicture ?? '',
                                    width: 100.r,
                                    height: 100.r,
                                    fit: BoxFit.cover,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          detail.gameName ?? "",
                                          style: TextStyle(
                                              fontSize: 18.w,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          "主机类型: ${detail.hostTypeStr}",
                                          style: TextStyle(
                                              fontSize: 13.w,
                                              color: Colors.white
                                                  .withOpacity(0.6)),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 5.h),
                                          child: Text(
                                            "版本: ${detail.gameLastVersion ?? 0}",
                                            style: TextStyle(
                                                fontSize: 14.w,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        "游戏简介",
                        style: TextStyle(
                            fontSize: 16.w,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        detail.gameIntroduction ?? '',
                        style: TextStyle(
                            fontSize: 13.w, color: ColorX.color_666666),
                      ),
                    ),
                    ...detail.publicityList?.map((item) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 10.h),
                            child: ImageView(
                              src: item,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList() ??
                        [],
                  ],
                );
              }),
            ),
          ),
          Obx(() {
            var detail = logic.game.value;
            return detail.isLock == true ? lockBtn() : unlockBtn(detail);
          }),
          SizedBox(height: 20.w),
        ],
      ),
    );
  }

  Widget unlockBtn(AdultGameDetailModel detail) {
    return WidgetUtils.buildElevatedButton(
        "${detail.priceGold ?? 0}金币解锁游戏", 332.w, 35.h,
        backgroundColor: ColorX.color_fb2d45,
        textColor: Colors.white,
        textSize: 14,
        borderRadius: BorderRadius.circular(20.r), onPressed: () {
      CommunityUtils.tryGoldBuyAdultGame(detail.gameId ?? 0,
          price: (detail.priceGold ?? 0).toDouble());
    });
  }

  Widget lockBtn() {
    var data = logic.game.value;
    return Row(
      children: [
        SizedBox(
          width: 10.w,
        ),
        Visibility(
          visible: true,
          child: Expanded(
            flex: 10,
            child: GestureDetector(
              onTap: () => DialogUtils.showDownloadLink(
                  context, "游戏下载链接", data.downUrl, "", ""),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorX.color_fb2d45,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                height: 35.h,
                alignment: Alignment.center,
                child: Text(
                  "安卓链接",
                  style: TextStyle(
                      fontSize: 14.w,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Visibility(
          visible: true,
          child: Expanded(
            flex: 10,
            child: GestureDetector(
              onTap: () => DialogUtils.showDownloadLink(
                  context, "游戏下载链接", data.pcDownUrl, "", ""),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorX.color_fb2d45,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                height: 35.h,
                alignment: Alignment.center,
                child: Text(
                  "PC链接",
                  style: TextStyle(
                      fontSize: 14.w,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
      ],
    );
  }
}
