import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/diolog/loading/loading_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/safe_state.dart';
import 'package:xhs_app/generate/app_image_path.dart';

import '../../assets/colorx.dart';
import '../../assets/styles.dart';
import '../../http/api/api.dart';
import '../../model/video/product_detail_model.dart';
import '../../routes/routes.dart';
import '../../utils/widget_utils.dart';
import '../diolog/dialog.dart';
import '../easy_toast.dart';

class ProductPayBottomSheet extends StatefulWidget {
  final ProductDetailModel? model;
  const ProductPayBottomSheet(this.model, {super.key});

  @override
  State<StatefulWidget> createState() => ProductPayBottomSheetState();
}

class ProductPayBottomSheetState extends SafeState<ProductPayBottomSheet> {
  ///购买数量
  var count = 1.obs;
  ProductDetailModel? get model => widget.model;
  var result;
  late var addressDesc = (widget.model?.goodsType == 1 ? "去添加联系方式" : "去添加收货地址");
  late var addressTitle = widget.model?.goodsType == 1 ? "添加联系方式" : "添加收货地址";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () => Get.back(result: false),
                child: Image.asset(
                  AppImagePath.community_discover_close_popup,
                  width: 20.r,
                ),
              ),
            ],
          ),
          Row(
            children: [
              ImageView(
                src: widget.model?.coverImg ?? "",
                width: 70.r,
                height: 70.r,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRadius.xs,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: "金币 ",
                      style: TextStyle(
                          fontSize: 17.w, color: ColorX.color_fb2d45)),
                  TextSpan(
                      text: "${widget.model?.price ?? 0}",
                      style: TextStyle(
                          fontSize: 28.sp,
                          color: ColorX.color_fb2d45,
                          fontWeight: FontWeight.w500)),
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "数量",
                style: TextStyle(
                    fontSize: 14.w,
                    color: ColorX.color_333333,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                height: 36.h,
                decoration: BoxDecoration(
                  color: ColorX.color_eeeeee,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (count.value > 1) {
                          count.value = count.value - 1;
                        }
                      },
                      child: Obx(() {
                        count.value;
                        return Image.asset(
                          AppImagePath.icons_ic_redu,
                          width: 20.r,
                          opacity:
                              AlwaysStoppedAnimation(count.value > 1 ? 1 : 0.3),
                        );
                      }),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Obx(() {
                      return Text(
                        "$count",
                        style: TextStyle(
                            fontSize: 20.w, color: ColorX.color_333333),
                      );
                    }),
                    SizedBox(
                      width: 30.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        count.value = count.value + 1;
                      },
                      child: Image.asset(
                        AppImagePath.icons_ic_add,
                        width: 20.r,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Text(
                addressTitle,
                style: TextStyle(
                    fontSize: 14.w,
                    color: ColorX.color_333333,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () async {
              if (model?.goodsType == 1) {
                result = await Get.toNamed(Routes.newContact);
                if (result != null) {
                  addressDesc = "${result["contactDetails"]}";
                  setState(() {});
                }
              } else {
                result = await Get.toNamed(Routes.newAddress);
                if (result != null) {
                  setState(() {});
                  addressDesc = result["contactDetails"];
                }
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagePath.icons_bg_contact),
                    fit: BoxFit.fill),
              ),
              height: 45.h,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                      child: Text(
                    addressDesc,
                    style: TextStyle(
                      fontSize: 13.w,
                      color: ColorX.color_333333,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Image.asset(
                    AppImagePath.icons_icon_right,
                    width: 10.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          WidgetUtils.buildElevatedButton("立即购买", 332.w, 35.h,
              backgroundColor: ColorX.color_fb2d45,
              textColor: Colors.white,
              textSize: 14,
              borderRadius: BorderRadius.circular(20.r), onPressed: () {
            if (GetUtils.isNullOrBlank(result) == true) {
              if (model?.goodsType == 1) {
                showToast("请先添加联系方式");
              } else {
                showToast("请先添加收货地址");
              }
            } else {
              result["goodsNum"] = count.value.toString();
              result["productId"] = model?.productId.toString();
              LoadingView.singleton.wrap(
                  context: Get.context!,
                  asyncFunction: () async {
                    final resp = await Api.productBuy(result);
                    if (resp) {
                      EasyToast.show('恭喜您购买成功!');
                    }
                    return resp;
                  });
            }
          }),
        ],
      ),
    );
  }
}
