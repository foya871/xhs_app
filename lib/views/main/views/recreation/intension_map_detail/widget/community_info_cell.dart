import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/community/community_model.dart';
import 'package:xhs_app/model/video/intension_map_detail_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';


class CommunityInfoCell extends StatelessWidget {
  const CommunityInfoCell({
    super.key,
    required this.data,
    required this.pictures,
     this.community,
    this.isBlack,
  });

  final IntensionMapDetailModelData data;
  final CommunityModel? community;
  final List<String> pictures;
  final bool? isBlack;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: data.type == 0
          ? Text(
              data.text ?? '',
              style: TextStyle(
                color: isBlack == true ? COLOR.white : COLOR.color_333333,
                fontSize: 12.w,
                height: 1.5,
              ),
            )
          : data.type == 1
              ? ImageView(
                  src:data.images?[0]??"",
                  fit: BoxFit.contain,
                  clipWidth: 480,
                ).marginOnly(bottom: 5.w).onOpaqueTap(() {
                  Get.toImageViewer(pictures);
                })
              : Stack(
                  children: <Widget>[
                    ImageView(
                      src:data.video?[0]??"",
                      width: double.infinity,
                      height: 195.w,
                      borderRadius: Styles.borderRadius.s,
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: Image.asset(
                          AppImagePath.community_community_video_play,
                          width: 40.w,
                          height: 40.w,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        AppImagePath.community_community_shadow,
                        width: double.infinity,
                        height: 38.w,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Text(
                        Utils.secondsToTime(community?.video!.playTime ?? 0),
                        style: TextStyle(
                          fontSize: 12.w,
                          color: COLOR.white,
                        ),
                      ).marginOnly(right: 5.w, bottom: 5.w),
                    ),
                    ( community?.price??0) > 0
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 20.w,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      AppImagePath.community_community_gold_shadow),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    AppImagePath.community_community_gold,
                                    width: 12.w,
                                    height: 12.w,
                                  ),
                                  Text(
                                    '${(community?.price??0)?.toInt()}',
                                    style: TextStyle(
                                      fontSize: 12.w,
                                      color: Color(0xFFfbe945),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ).marginOnly(left: 3.w),
                                ],
                              ).marginOnly(left: 3.w, right: 5.w),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ).marginOnly(bottom: 5.w).onOpaqueTap(() {
                  if (data.video == null) return;
                  final video = data.video!;
                  if (video.isEmpty) {
                    EasyToast.show("视频地址非法！");
                    return;
                  }
                  // final id = video!.id ?? '';
                  // if (id.isEmpty) {
                  //   EasyToast.show("视频地址非法！");
                  //   return;
                  // }
                  // final ww = video.width ?? 0;
                  // final w = ww == 0 ? Get.width : ww;
                  //
                  // final hh = video.height ?? 0;
                  // final h = hh == 0 ? Get.height : hh;
                  // final asp = w / h;
                  // final playPath = Environment.buildAuthPlayUrlString(
                  //     videoUrl: video.videoUrl, authKey: video.authKey, id: id);
                  // Get.toComonVideoPlay(url: playPath, asp: asp);
                }),
    );
  }
}
