import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/mine/publications_videos_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/utils.dart';

import '../../../../assets/styles.dart';

/// 我的发布：帖子
class ItemDyView extends StatefulWidget {
  //1：已发布  2：审核中   3：未通过
  int fromType;
  double height;
  PublicationsVideosModel model;

  ItemDyView({
    required this.fromType,
    required this.height,
    required this.model,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ItemDyViewState();
}

class _ItemDyViewState extends State<ItemDyView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var imagePath = "";
    var imagePaths = widget.model.verticalImg;
    if (imagePaths != null && imagePaths.isNotEmpty) {
      imagePath = imagePaths.first;
    } else {
      imagePaths = widget.model.coverImg;
      if (imagePaths != null && imagePaths.isNotEmpty) {
        imagePath = imagePaths.first;
      }
    }

    return Container(
      child: Column(
        children: [
          Container(
            height: widget.height,
            child: Stack(
              children: [
                ImageView(
                  src: imagePath,
                  width: double.infinity,
                  height: widget.height,
                  fit: BoxFit.cover,
                  borderRadius: Styles.borderRadius.m,
                ),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        //已发布 ｜｜ 未通过
                        Visibility(
                          visible: widget.fromType == 1 || widget.fromType == 3,
                          child: Expanded(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(left: 5.w, bottom: 5.h),
                              child: TextView(
                                text: widget.fromType == 1
                                    ? "${widget.model.fakeWatchNum}"
                                    : "${widget.model.notPass}",
                                fontSize: 10.w,
                                color: COLOR.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.only(right: 5.w, bottom: 5.h),
                            child: TextView(
                              text:
                                  "${Utils.convertSeconds(widget.model.playTime ?? 0)}",
                              fontSize: 10.w,
                              color: COLOR.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //审核中
                Visibility(
                  visible: widget.fromType == 2,
                  child: Positioned.fill(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(right: 5.w, bottom: 5.h),
                      child: underReviewView(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            alignment: Alignment.centerLeft,
            child: TextView(
              text: "${widget.model.title}",
              fontSize: 12.w,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: COLOR.color_333333,
            ),
          ),
        ],
      ),
    );
  }

  /// 审核中
  Widget underReviewView() {
    return Column(
      mainAxisSize: MainAxisSize.min, // 让Column根据内容自适应高度
      mainAxisAlignment: MainAxisAlignment.center, // 让内容在Column中垂直居中
      children: [
        Image.asset(
          AppImagePath.mine_icon_mine_under_review,
          width: 16.w,
          height: 18.h,
          fit: BoxFit.cover,
        ),
        TextView(
          text: '审核中',
          fontSize: 14.w,
          color: COLOR.white,
        ),
      ],
    );
  }
}
