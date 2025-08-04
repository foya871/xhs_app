import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/views/community/common/base/community_utils.dart';

import '../../../assets/styles.dart';
import '../../../components/image_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/video/product_detail_model.dart';
import '../../../utils/logger.dart';
import 'naked_chat_detail_logic.dart';
import 'naked_chat_detail_state.dart';

class NakedChatDetailPage extends StatefulWidget {
  const NakedChatDetailPage({super.key});

  @override
  State<NakedChatDetailPage> createState() => _NakedChatDetailPageState();
}

class _NakedChatDetailPageState extends State<NakedChatDetailPage> {
  final NakedChatDetailLogic logic =
      Get.put(NakedChatDetailLogic(), tag: "${Get.arguments}");
  final NakedChatDetailState state =
      Get.find<NakedChatDetailLogic>(tag: "${Get.arguments}").state;
  var pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<NakedChatDetailLogic>(tag: "${Get.arguments}");
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Image.asset(
              AppImagePath.icons_ic_back,
              width: 24.r,
              height: 24.r,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: ColorX.color_FaFaFa,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 460.h,
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Obx(() {
                          if (GetUtils.isNullOrBlank(
                                  state.productDetail.value.bgImgs) ==
                              false) {
                            return PageView(
                              controller: pageController,
                              onPageChanged: (index) =>
                                  state.pageIndex.value = index,
                              children:
                                  state.productDetail.value.bgImgs?.map((item) {
                                        return ImageView(
                                          src: item.url ?? "",
                                          width: double.infinity,
                                          height: 460.h,
                                          fit: BoxFit.cover,
                                          // borderRadius: Styles.borderRaidus.m,
                                          axis: CoverImgAxis.horizontal,
                                        );
                                      }).toList() ??
                                      [],
                            );
                          } else {
                            return Container();
                          }
                        }),
                        Positioned(
                          right: 10.w,
                          bottom: 10.h,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            child: Obx(() {
                              return Text(
                                "${state.pageIndex.value} / ${state.productDetail.value.bgImgs?.length ?? 0}",
                                style: TextStyle(
                                    fontSize: 11.w, color: Colors.white),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Obx(() {
                      return Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: "金币 ",
                              style: TextStyle(
                                  fontSize: 12.w, color: ColorX.color_fb2d45)),
                          TextSpan(
                              text: "${state.productDetail.value.price ?? 0}",
                              style: TextStyle(
                                  fontSize: 20.w,
                                  color: ColorX.color_fb2d45,
                                  fontWeight: FontWeight.w500)),
                        ]),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Obx(() {
                      return Text(
                        state.productDetail.value.title ?? "",
                        style: TextStyle(
                            fontSize: 13.w,
                            color: ColorX.color_333333,
                            fontWeight: FontWeight.w500),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Obx(() {
                      return Text(
                        "${state.productDetail.value.buyNum ?? 0}人已买",
                        style: TextStyle(
                          fontSize: 11.w,
                          color: ColorX.color_999999,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    color: ColorX.color_eeeeee,
                    height: 1.h,
                    indent: 14.w,
                    endIndent: 14.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Text(
                      "产品详情",
                      style: TextStyle(
                          fontSize: 15.w,
                          color: ColorX.color_333333,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Obx(() {
                      return Text(
                        state.productDetail.value.detail ?? "",
                        style: TextStyle(
                          fontSize: 13.w,
                          color: ColorX.color_666666,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Text(
                      "相关商品",
                      style: TextStyle(
                          fontSize: 15.w,
                          color: ColorX.color_333333,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 1.sw,
                    alignment: Alignment.center,
                    child: Obx(() {
                      return Wrap(
                        runSpacing: 10.h,
                        spacing: 10.w,
                        children: state.recommendList
                            .map((item) => buildProductCell(item, () {
                                  Get.toNakedChatDetail(
                                      id: item.productId ?? 0);
                                }))
                            .toList(),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50.h,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () => kOnLineService(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImagePath.icons_ic_service,
                          color: ColorX.color_333333,
                          width: 22.r,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "客服",
                          style: TextStyle(
                            fontSize: 12.w,
                            color: ColorX.color_333333,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Obx(() {
                    return GestureDetector(
                      onTap: () => logic.productLike(
                          state.productDetail.value.isLike == true),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.productDetail.value.isLike == true)
                            Image.asset(
                              AppImagePath.player_collect_y,
                              width: 22.r,
                            )
                          else
                            Image.asset(
                              AppImagePath.icons_ic_star_0,
                              color: ColorX.color_333333,
                              width: 22.r,
                            ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "收藏",
                            style: TextStyle(
                              fontSize: 12.w,
                              color: ColorX.color_333333,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Expanded(
                  flex: 10,
                  child: GestureDetector(
                    onTap: () => CommunityUtils.tryGoldBuyNakedChat(
                        state.productDetail.value),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorX.color_fb2d45,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      height: 35.h,
                      alignment: Alignment.center,
                      child: Text(
                        "立即购买",
                        style: TextStyle(
                            fontSize: 14.w,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildProductCell(ProductDetailModel item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              src: item.coverImg ?? "",
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
              borderRadius: Styles.borderRaidus.xs,
              axis: CoverImgAxis.horizontal,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              item.title ?? "",
              style: TextStyle(
                  fontSize: 13.w,
                  color: ColorX.color_333333,
                  fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: "金币 ",
                    style:
                        TextStyle(fontSize: 10.w, color: ColorX.color_fb2d45)),
                TextSpan(
                    text: "${item.price ?? 0}",
                    style: TextStyle(
                        fontSize: 15.w,
                        color: ColorX.color_fb2d45,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: " ${item.buyNum ?? 0}人已买",
                    style:
                        TextStyle(fontSize: 10.w, color: ColorX.color_666666)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
