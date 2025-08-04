/*
 * @Author: wangdazhuang
 * @Date: 2024-08-28 19:50:08
 * @LastEditTime: 2025-03-10 16:20:17
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/player/views/comment_list.dart
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';
import 'package:xhs_app/components/circle_image.dart';
import 'package:xhs_app/components/common_permission_alert.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/player/views/comment_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../http/api/api.dart';
import '../../../http/service/api_service.dart';
import '../../../model/comment/comment_model.dart';

typedef CommentsType = int;

abstract class CommentTypeEnumValue {
  //播放器
  static const CommentsType player = 1;

  //短视频
  static const CommentsType short = 2;

  //帖子评论
  static const CommentsType circle = 4;
}

class PlayCommentList extends StatefulWidget {
  final int? videoId;
  final int? dynamicId;
  final CommentsType type;
  final bool showInput;
  final FocusNode? focusNode;

// 针对短视频
  final int? commentCount;

  const PlayCommentList({
    super.key,
    this.videoId,
    this.commentCount,
    required this.type,
    this.dynamicId,
    this.showInput = true,
    this.focusNode,
  });

  @override
  State<StatefulWidget> createState() {
    return PlayerCommentsState();
  }
}

class PlayerCommentsState extends State<PlayCommentList> {
  int _page = 1;
  final _pageSize = 30;
  List<CommentModel> commentItems = [];
  bool requesting = false;
  final refreshController = EasyRefreshController();
  CommentModel? selectedItem;
  CommentModel? topModel;
  final controller = TextEditingController();
  late final node = widget.focusNode ?? FocusNode();

  /// 刷新
  Future<IndicatorResult> onRefreshComments() async {
    _page = 1;

    final params = widget.type == CommentTypeEnumValue.circle
        ? {"dynamicId": widget.dynamicId}
        : {"videoId": widget.videoId ?? 0};
    try {
      final s = await httpInstance.get(
        url: widget.type == CommentTypeEnumValue.circle
            ? "community/dynamic/commentList"
            : "video/commentList",
        queryMap: {
          "page": _page,
          "pageSize": _pageSize,
          ...params,
        },
        complete: CommentModel.fromJson,
      );
      if (s is List<CommentModel> == false) {
        return IndicatorResult.fail;
      }
      commentItems = s;
      if (mounted) {
        setState(() {});
      }
      if (s.isEmpty) {
        return IndicatorResult.none;
      }
      return IndicatorResult.success;
    } catch (_) {
      return IndicatorResult.fail;
    }
  }

  // 上拉加载更多
  Future<IndicatorResult> onLoadComments() async {
    try {
      _page = _page + 1;
      final params = widget.type == CommentTypeEnumValue.circle
          ? {"dynamicId": widget.dynamicId}
          : {"videoId": widget.videoId ?? 0};
      final s = await httpInstance.get(
        url: widget.type == CommentTypeEnumValue.circle
            ? "community/dynamic/commentList"
            : "video/commentList",
        queryMap: {
          ...params,
          "page": _page,
          "pageSize": _pageSize,
        },
        complete: CommentModel.fromJson,
      );
      if (s is List<CommentModel> == false) {
        return IndicatorResult.fail;
      }
      commentItems.addAll(s);
      if (mounted) {
        setState(() {});
      }
      if (s.isEmpty) {
        return IndicatorResult.noMore;
      }
      return IndicatorResult.success;
    } catch (_) {
      return IndicatorResult.fail;
    }
  }

  addURL(CommentsType type) {
    if (type == CommentTypeEnumValue.circle) {
      return 'community/dynamic/saveComment';
    }

    return 'video/saveComment';
  }

  // 添加评论
  Future addComments(String content) async {
    if (requesting) {
      return;
    }
    requesting = true;
    try {
      final params = widget.type == CommentTypeEnumValue.circle
          ? {"dynamicId": widget.dynamicId}
          : {"videoId": widget.videoId};

      final s = await httpInstance.post(
          url: addURL(widget.type),
          body: {
            ...params,
            "content": content,
            "topId": topModel?.commentId ?? 0,
            "parentId": selectedItem?.commentId ?? 0,
          },
          complete: CommentModel.fromJson);
      requesting = false;
      SmartDialog.showToast("评论成功,请等待审核!", alignment: Alignment.center);
      if (s is CommentModel == false) {
        reset();
        return;
      }
      if (topModel != null && selectedItem != null) {
        CommentModel some =
            commentItems.firstWhere((e) => e.commentId == topModel!.commentId);
        some.replyNum += 1;
        some.replyItems?.add(s);
      } else {
        if (commentItems.isEmpty) {
          commentItems.add(s);
        } else {
          commentItems.insert(0, s);
        }
      }
      reset();
    } catch (_) {
      requesting = false;
      reset();
    }
  }

  void reset() {
    selectedItem = null;
    topModel = null;
    controller.text = "";
    node.unfocus();
    if (mounted) {
      setState(() {});
    }
  }

  Future likeCommentAction(CommentModel m) async {
    ///点赞
    if (requesting) {
      return;
    }
    requesting = true;

    ///社区
    if (widget.type == CommentTypeEnumValue.circle) {
      final r = await Api.toogleDynamicCommentLike(m.commentId, like: m.isLike);
      requesting = false;
      if (r != null && r) {
        m.isLike = !m.isLike;
        if (m.isLike) {
          m.fakeLikes = m.fakeLikes + 1;
        } else {
          m.fakeLikes = m.fakeLikes - 1;
        }
        if (mounted) {
          setState(() {});
        }
      }
      return;
    }

    //长短视频
    final r =
        await Api.likeVideoComment(toLike: !m.isLike, commentId: m.commentId);
    requesting = false;
    if (r) {
      m.isLike = !m.isLike;
      if (m.isLike) {
        m.fakeLikes = m.fakeLikes + 1;
      } else {
        m.fakeLikes = m.fakeLikes - 1;
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  _buildCommentList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.w),
      sliver: commentItems.isEmpty
          ? SizedBox(
              width: Get.width,
              height: 250.w,
              child: const Center(child: NoData()),
            ).sliver
          : SliverList.builder(
              itemCount: commentItems.length,
              itemBuilder: (context, index) {
                return CommentCell(
                  type: widget.type,
                  videoId: widget.videoId,
                  dynamicId: widget.dynamicId,
                  model: commentItems[index],
                  tap: (v) {
                    /// 回复
                    selectedItem = v;
                    topModel = v;
                    node.requestFocus();
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  tapList: (m, m1) {
                    //m是顶层 m1是parent
                    selectedItem = m1;
                    topModel = m;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  likeLelvel1: (m) {
                    likeCommentAction(m);
                  },
                  likeLevel2: (m, m1) {
                    likeCommentAction(m1);
                  },
                );
              },
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    onRefreshComments();
    node.addListener(
      () {
        // if (node.hasFocus && Get.find<UserService>().isVIP == false) {
        //   node.unfocus();
        //   permission_alert(
        //     Get.context!,
        //     desc: "会员才能评论哟!",
        //     okAction: () {
        //       Get.toVip();
        //     },
        //   );
        //   return;
        // }
      },
    );
  }

  ///添加评论
  void sendAction() {
    if (controller.text.isEmpty) {
      node.unfocus();
      selectedItem = null;
      topModel = null;
      controller.text = "";
      setState(() {});
      return;
    }
    addComments(controller.text);
  }

  _buildShortHeader() {
    final isCircle = widget.type == CommentTypeEnumValue.circle;
    return isCircle
        ? Row(
            children: [
              TextView(
                text: '评论 ${commentItems.length}',
                color: COLOR.color_333333,
                fontSize: 14.w,
              ).marginOnly(left: 14.w),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 18.w, height: 18.w),
              Text("全部${widget.commentCount ?? 0}条评论",
                  style: kTextStyle(COLOR.color_333333,
                      fontsize: 16.w, weight: FontWeight.w500)),
              Icon(
                Icons.cancel_rounded,
                size: 18.w,
                color: COLOR.color_666666,
              ).onTap(() {
                Get.back();
              }),
            ],
          ).paddingOnly(left: 14.w, top: 18.w, right: 14.w, bottom: 8.w);
  }

  _buildShortReplyTxt() {
    return Visibility(
      visible: widget.showInput,
      maintainState: true,
      child: Container(
        width: 400.w,
        padding: EdgeInsets.only(top: 11.w, bottom: 37.w),
        decoration: const BoxDecoration(
          color: COLOR.white,
          border: Border(
            top: BorderSide(
              color: COLOR.white,
            ),
          ),
        ),
        child: Container(
          height: 40.w,
          width: 372.w,
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
              color: COLOR.color_EEEEEE,
              borderRadius: BorderRadius.circular(20.w)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 44.w,
                  width: double.infinity,
                  child: TextField(
                    cursorHeight: 20.w,
                    focusNode: node,
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      node.unfocus();
                      sendAction();
                    },
                    style: kTextStyle(Colors.black),
                    cursorColor: COLOR.color_999999,
                    decoration: InputDecoration(
                        hintText: selectedItem == null
                            ? "爱情就在一瞬间，来爱我"
                            : '回复@${selectedItem!.nickName}',
                        hintStyle:
                            kTextStyle(COLOR.color_999999, fontsize: 14.w),
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 14.w),
                        border: InputBorder.none,
                        labelStyle: kTextStyle(Colors.black, fontsize: 15.w)),
                  ),
                ).marginHorizontal(4.w),
              ),
              Image.asset(
                AppImagePath.short_short_fb,
                width: 24.w,
                height: 24.w,
              ).onTap(() {
                node.unfocus();
                sendAction();
              }),
              SizedBox(
                width: 5.w,
              )
            ],
          ).marginHorizontal(17.w),
        ),
      ),
    );
  }

  Widget _buildAds() {
    return InsertAd(
      adress: AdApiTypeCompat.PLAY_PAGE,
      margin: EdgeInsets.only(bottom: 10.w),
    );
  }

  Widget _buildTips() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10.w),
      child: Text.rich(TextSpan(children: [
        TextSpan(text: '*部分地区若遇视频无法播放，请尝试切换', style: TextStyle(fontSize: 12.w)),
        TextSpan(
            text: '移动网络或开VPN',
            style: TextStyle(color: COLOR.color_0C0935, fontSize: 12.w)),
      ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isBottom = widget.type == CommentTypeEnumValue.short ||
        widget.type == CommentTypeEnumValue.circle;

    return Column(
      children: [
        isBottom ? _buildShortHeader() : const SizedBox.shrink(),
        // SizedBox(
        //     height: 65.w,
        //     width: double.infinity,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         // _buildLine(),
        //         _buildTxtReply(),
        //       ],
        //     ),
        //   ),
        Expanded(
          child: EasyRefresh.builder(
            onRefresh: onRefreshComments,
            onLoad: onLoadComments,
            controller: refreshController,
            childBuilder: (context, physics) => CustomScrollView(
              physics: physics,
              slivers: <Widget>[
                // if (widget.type != CommentTypeEnumValue.short)
                // _buildTips().sliverBox,
                // if (widget.type != CommentTypeEnumValue.short)
                // _buildAds().sliverBox,
                _buildCommentList(),
              ],
            ),
          ),
        ),
        _buildShortReplyTxt()
      ],
    );
  }
}
