import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/mine/publications_posts_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/utils.dart';

/// 我的发布：帖子
class ItemPostsView extends StatefulWidget {
  //1：已发布  2：审核中   3：未通过    4：本地草稿
  int fromType;
  PublicationsPostsModel? model;

  ItemPostsView({required this.fromType, this.model, super.key});

  @override
  State<StatefulWidget> createState() => _ItemPostsViewState();
}

class _ItemPostsViewState extends State<ItemPostsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String image = '';
    if (widget.model!.coverImg != null) {
      if (widget.model!.coverImg!.isNotEmpty) {
        image = widget.model!.coverImg![0];
      }
    }
    return Container(
      height: 104.h,
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 104.h,
            margin: EdgeInsets.only(right: 6.w),
            child: Stack(
              children: [
                ImageView(
                  src: image,
                  width: 182.w,
                  height: 104.h,
                  fit: BoxFit.cover,
                ),
                Visibility(
                  visible: widget.fromType == 2,
                  child: Positioned.fill(
                    child: Center(
                      child: underReviewView(),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.fromType == 3,
                  child: Positioned.fill(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 5.w, bottom: 5.h),
                      child: TextView(
                        text: "${widget.model?.notPass}",
                        fontSize: 10.w,
                        color: COLOR.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextView(
                      text: widget.model?.title ?? "",
                      maxLines: 4,
                      fontSize: 12.w,
                      color: COLOR.color_333333,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextView(
                            text: widget.fromType == 4
                                ? "${Utils.dateAgo(widget.model?.checkAt ?? "")}"
                                : "${Utils.dateFmt(widget.model?.checkAt ?? "")} 发布",
                            fontSize: 9.sp,
                            color: COLOR.color_A4A4B2,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Visibility(
                          visible: widget.fromType == 4,
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/mine/icon_posts_delete.png",
                              width: 16.w,
                              height: 17.h,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
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
