import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/circle_image.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/comment/comment_model.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';
import 'package:xhs_app/views/player/views/comment_sub_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../http/service/api_service.dart';
import 'comment_list.dart';

class CommentCell extends StatefulWidget {
  final CommentModel model;
  final void Function(CommentModel) tap;
  final void Function(CommentModel, CommentModel) tapList;
  final void Function(CommentModel) likeLelvel1;
  final void Function(CommentModel, CommentModel) likeLevel2;
  final CommentsType type;
  final int? videoId;
  final int? dynamicId;
  const CommentCell(
      {super.key,
      required this.model,
      this.videoId,
      this.dynamicId,
      required this.type,
      required this.tap,
      required this.tapList,
      required this.likeLelvel1,
      required this.likeLevel2});

  @override
  State<StatefulWidget> createState() {
    return CommentCellState();
  }
}

class CommentCellState extends State<CommentCell> {
  //头像
  _buildLogo() {
    return CircleImage.network(
      widget.model.logo,
      size: 35.w,
    );
  }

  addURL(CommentsType type) {
    if (type == CommentTypeEnumValue.circle) {
      return "community/dynamic/commentList";
    }
    return "video/commentList";
  }

  /// 获取二级回复
  Future getSecondCommentList() async {
    try {
      final params = widget.type == CommentTypeEnumValue.circle
          ? {"dynamicId": widget.dynamicId}
          : {"videoId": widget.videoId};
      final s = await httpInstance.get(
        url: addURL(widget.type),
        queryMap: {
          ...params,
          "page": 1,
          "pageSize": 100,
          "parentId": widget.model.commentId,
        },
        complete: CommentModel.fromJson,
      );
      if (s is List<CommentModel> == false) {
        return;
      }
      widget.model.replyItems = s;
      if (mounted) {
        setState(() {});
      }
    } catch (_) {}
  }

//名字和时间
  _buildNameAndTime() {
    return Text(
      widget.model.nickName,
      style: kTextStyle(
          COLOR.hexColor(widget.model.officialComment ? '#fff' : "#9C9AA9"),
          fontsize: 12.w),
    );

    // RichText(
    //   text: TextSpan(
    //     children: [
    //       TextSpan(
    //         text: widget.model.nickName,
    //         style: kTextStyle(COLOR.hexColor("#9C9AA9"), fontsize: 12.w),
    //       ),
    //       WidgetSpan(
    //           child: SizedBox(
    //         width: 2.w,
    //       )),
    //       TextSpan(
    //           text: Utils.dateFmt(widget.model.createdAt, ['mm', '-', 'dd']),
    //           style: kTextStyle(COLOR.hexColor("#999"), fontsize: 11.w)),
    //     ],
    //   ),
    // ).paddingBottom(4.w);
  }

  _buildTime() {
    return widget.model.officialComment
        ? Container(
            width: 57.w,
            height: 19.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: COLOR.hexColor('#FEE041'),
                borderRadius: BorderRadius.circular(10.5.w)),
            child: Text(
              '立即参与',
              style:
                  TextStyle(color: COLOR.hexColor('#0C0935'), fontSize: 11.w),
            ),
          ).onTap(() {
            // kAdjump(widget.model.jumpUrl, 0);
            jumpExternalURL(widget.model.jumpUrl);
          })
        : Row(
            children: [
              Text(
                Utils.dateFmt(widget.model.createdAt, ['mm', '-', 'dd']),
                style:
                    TextStyle(color: COLOR.hexColor('#9C9AA9'), fontSize: 10.w),
              ),
              SizedBox(
                width: 14.w,
              ),
              Text(
                '回复',
                style:
                    TextStyle(color: COLOR.hexColor('#9C9AA9'), fontSize: 10.w),
              )
            ],
          );
  }

  ///内容
  _buildContent() {
    final isShort = widget.type == CommentTypeEnumValue.short;
    return Text(
      widget.model.content,
      style: kTextStyle(
          COLOR.hexColor(widget.model.officialComment
              ? "#B93FFF"
              : isShort
                  ? '#333'
                  : "#333"),
          fontsize: 12.w),
    ).paddingBottom(12.w).onOpaqueTap(() {
      if (widget.model.officialComment) {
        // kAdjump(widget.model.jumpUrl, {});
        jumpExternalURL(widget.model.jumpUrl);
      }
    });
  }

  ///点赞和回复
  _buildLikeAndReply() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          widget.model.isLike
              ? AppImagePath.player_like_y
              : AppImagePath.player_like,
          width: 18.w,
          height: 18.w,
        ).onOpaqueTap(() {
          widget.likeLelvel1(widget.model);
        }),
        SizedBox(width: 8.w),
        Text(Utils.numFmt(widget.model.fakeLikes),
            style: kTextStyle(COLOR.hexColor("#BEBEBE"), fontsize: 12.w)),
        Text('回复', style: kTextStyle(COLOR.hexColor("#999"), fontsize: 12.w))
            .marginOnly(left: 20.w)
            .onOpaqueTap(() {
          widget.tap(widget.model);
        }),
      ],
    );
  }

  _buildExpand() {
    return widget.model.replyNum == 0
        ? const SizedBox()
        : (widget.model.replyItems?.isEmpty ?? true)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 20.w,
                    height: 1.w,
                    color: COLOR.hexColor('#9C9AA9'),
                  ),
                  Text("展开全部回复",
                          style: kTextStyle(COLOR.hexColor("#9C9AA9"),
                              fontsize: 12.w))
                      .marginLeft(8.w),
                  Icon(
                    Icons.expand_more,
                    size: 20.w,
                    color: COLOR.hexColor('#9C9AA9'),
                  ),
                ],
              ).marginOnly(top: 14.w).onOpaqueTap(() {
                getSecondCommentList();
              })
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.model.replyItems!
                    .map((e) => CommentSubCell(
                          model: e,
                          tap: (subItem) {
                            widget.tapList(widget.model, subItem);
                          },
                          likeTap: (e) {
                            widget.likeLevel2(widget.model, e);
                          },
                        ))
                    .toList(),
              ).marginTop(14.w);
  }

  _buildRight() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameAndTime(),
          _buildContent(),
          _buildTime(),
          // widget.model.officialComment
          //     ? const SizedBox.shrink()
          //     : _buildLikeAndReply(),
          _buildExpand(),
        ],
      ).paddingOnly(left: 8.w),
    );
  }

  _buildLike() {
    if (widget.model.officialComment) return const SizedBox.shrink();
    return Column(
      children: [
        Image.asset(
          widget.model.isLike
              ? AppImagePath.player_like_y
              : AppImagePath.player_like,
          width: 16.w,
        ).onTap(() {
          widget.likeLelvel1(widget.model);
        }),
        SizedBox(
          height: 6.w,
        ),
        Text(
          '${widget.model.fakeLikes}',
          style: TextStyle(color: COLOR.hexColor('#9C9AA9'), fontSize: 12.w),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogo(),
        _buildRight(),
        SizedBox(width: 8.w),
        _buildLike()
      ],
    ).onOpaqueTap(() {
      widget.tap(widget.model);
    }).paddingBottom(15.w);
  }
}
