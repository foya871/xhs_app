import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/community/community_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/extension.dart';

///我的界面 笔记cell(浏览记录，购买记录)
class MineCommunityCell extends StatefulWidget {
  final CommunityModel item;

  const MineCommunityCell({super.key, required this.item});

  @override
  State<MineCommunityCell> createState() => _MineCommunityCellState();
}

class _MineCommunityCellState extends State<MineCommunityCell> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 173.w,
      height: 296.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src: widget.item.coverImage,
                width: 173.w,
                height: 230.w,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.w),
                    topRight: Radius.circular(4.w)),
              ),
              if (widget.item.isVideo)
                Positioned(
                    top: 6.w,
                    right: 6.w,
                    child: ImageView(
                      src: AppImagePath.icons_bg_play_icon,
                      width: 20.w,
                      height: 20.w,
                    ))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: widget.item.title,
                maxLines: 1,
                fontSize: 13.w,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF333333),
              ).marginBottom(4.w),
              Row(
                children: [
                  ImageView(
                    src: widget.item.logo,
                    width: 16.w,
                    height: 16.w.w,
                    borderRadius: BorderRadius.circular(16.w),
                  ).paddingRight(2),
                  Expanded(
                      child: TextView(
                    text: widget.item.nickName,
                    maxLines: 1,
                    fontSize: 10.w,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF666666),
                  )),
                  Row(
                    children: [
                      ImageView(
                        src: widget.item.isLike == true
                            ? AppImagePath.mine_icon_click_on
                            : AppImagePath.mine_icon_click_off,
                        width: 14.w,
                        height: 11.w,
                      ),
                      TextView(
                        text: "${widget.item.fakeLikes}",
                        fontSize: 10.w,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF666666),
                      ).paddingLeft(3.w)
                    ],
                  ).onOpaqueTap(_onTapLike)
                ],
              )
            ],
          ).marginTop(4.w)
        ],
      ),
    ).onOpaqueTap(() => Get.toCommunityDetailById(widget.item.dynamicId,
        dynamicType: widget.item.dynamicType));
  }

  Future<void> _onTapLike() async {
    final ok = await Api.toggleCommunityLike(
      widget.item.dynamicId,
      isLike: widget.item.isLike,
    );
    if (!ok) return;
    widget.item.isLike = !widget.item.isLike;
    setState(() {});
  }
}
