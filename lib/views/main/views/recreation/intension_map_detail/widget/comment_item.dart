/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-11-01 14:23:30
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-11-08 14:23:53
 * @FilePath: /51yuseman_app/lib/app/pages/home/comment_item.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/circle_image.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/components/image_upload/image_comm.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/image_viewer/image_viewer_sheet.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/comment/comment_dynamic_model.dart';
import 'package:xhs_app/model/comment/comment_send_model.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map_detail/widget/comment_list.dart';

import '../../../../../../assets/colorx.dart';

typedef CommentsType = int;

abstract class CommentTypeEnumValue {
  //帖子评论
  static const CommentsType topic = 1;
}

class CommentItem extends StatefulWidget {
  final Function reply;
  final CommentDynamicModel comment;
  final bool? hasMore;
  final CommentsType? type;

  const CommentItem({
    super.key,
    required this.reply,
    required this.comment,
    this.hasMore = true,
    this.type,
  });

  @override
  State<StatefulWidget> createState() => _CommentItem();
}

class _CommentItem extends State<CommentItem> {
  ValueNotifier<bool> isLike = ValueNotifier(false);
  ValueNotifier<int> fakeLikes = ValueNotifier(0);
  ValueNotifier<String> defalutText = ValueNotifier('');
  TextEditingController commTextController = TextEditingController();
  CommentSendModel params = CommentSendModel.fromJson({});
  FocusNode focusNode = FocusNode();

  //点赞
  void handleLike(bool like) async {
    await httpInstance.post(
      url: widget.type == CommentTypeEnumValue.topic
          ? 'community/dynamic/comment/${like ? 'unLike' : 'saveLike'}'
          : '/gossip/comment/${like ? 'unLike' : 'saveLike'}',
      body: {'commentId': widget.comment.commentId},
    );
    if (like) {
      fakeLikes.value -= 1;
    } else {
      fakeLikes.value += 1;
    }
    isLike.value = !like;
  }

  //评论
  void handleComment() async {
    params.content = commTextController.text;
    if (params.content!.isEmpty && params.img == null) {
      EasyToast.show('评论内容不能为空');
      return;
    }
    try {
      await httpInstance.post(
        url: widget.type == CommentTypeEnumValue.topic
            ? 'community/dynamic/saveComment'
            : '/gossip/saveComment',
        body: params.toJson(),
      );
      params = CommentSendModel.fromJson({
        'parentId': 0,
        'topId': 0,
      });
      EasyToast.show('评论成功');
      // ignore: empty_catches
    } catch (e) {}
    commTextController.text = '';
    focusNode.unfocus();
  }

  //回复列表

  void showCommBack() {
    final us = Get.find<UserService>().user;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: 700.w),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.w),
                topRight: Radius.circular(16.w))),
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Flex(
              direction: Axis.vertical,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 368.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 30.w),
                      child: Text(
                        '更多回复',
                        style: TextStyle(
                            color: ColorX.color_333333,
                            fontSize: 15.w,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 24.w,
                      child: Icon(
                        size: 30.w,
                        color: COLOR.hexColor('#999'),
                        Icons.clear,
                      ).onOpaqueTap(() {
                        Navigator.pop(context);
                      }),
                    )
                  ],
                ),
                Expanded(
                    child: CustomScrollView(
                  slivers: [
                    CommentItem(
                      reply: (CommentSendModel v, String t) {
                        focusNode.requestFocus();
                        defalutText.value = '回复@$t';
                        params.parentId = 0;
                        params.topId = 0;
                      },
                      comment: widget.comment,
                      hasMore: false,
                    ).sliver,
                    Container(
                      height: 1.w,
                      color: COLOR.hexColor('#ececec'),
                    ).sliver,
                    SliverPadding(padding: EdgeInsets.only(top: 30.w)),
                    CommentList(
                      gossipId: widget.comment.gossipId!,
                      parentId: widget.comment.commentId,
                      hasMore: false,
                      reply: (CommentSendModel v, String t) {
                        focusNode.requestFocus();
                        defalutText.value = '回复@$t';
                        params = v;
                      },
                    )
                  ],
                )),
                Container(
                  height: 110.w,
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36.w,
                        height: 36.w,
                        child: CircleImage(
                          url: us.logo,
                        ),
                      ).padding(EdgeInsets.only(left: 6.w, right: 20.w)),
                      Container(
                        width: 202.w,
                        height: 36.w,
                        alignment: Alignment.center,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: COLOR.hexColor('#ededed'),
                            borderRadius: BorderRadius.circular(18.w)),
                        child: ValueListenableBuilder(
                            valueListenable: defalutText,
                            builder: (context, value, child) {
                              return TextField(
                                maxLines: 1,
                                focusNode: focusNode,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13.w),
                                controller: commTextController,
                                onSubmitted: (value) {
                                  params.content = value;
                                  handleComment();
                                },
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.only(left: 16.w),
                                    hintText: value,
                                    hintStyle: TextStyle(
                                        color: COLOR.hexColor('#908c9b'),
                                        fontSize: 12.w),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(0, 0, 0, 0))),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0)))),
                              );
                            }),
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 12.w)),
                          ImageComm(
                            limit: 3,
                            success: (v) {
                              params.img = v;
                            },
                          ),
                          Padding(padding: EdgeInsets.only(left: 16.w)),
                          Image.asset(
                            AppImagePath.community_home_send,
                            width: 24.w,
                            height: 24.w,
                          ).onOpaqueTap(() {
                            handleComment();
                          }),
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ).padding(EdgeInsets.symmetric(horizontal: 16.w)),
          ).onOpaqueTap(() {
            focusNode.unfocus();
          });
        });
  }

  @override
  initState() {
    defalutText.value = '回复@${widget.comment.nickName}';
    params = widget.type == CommentTypeEnumValue.topic
        ? CommentSendModel.fromJson({
            'parentId': widget.comment.commentId,
            'topId': widget.comment.commentId,
            'dynamicId': widget.comment.gossipId
          })
        : CommentSendModel.fromJson({
            'parentId': widget.comment.commentId,
            'topId': widget.comment.commentId,
            'gossipId': widget.comment.gossipId
          });

    isLike.value = widget.comment.isLike!;
    fakeLikes.value = widget.comment.fakeLikes!;
    super.initState();
  }

  @override
  void dispose() {
    commTextController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildText(String str, int size, [bool? wight]) {
    return Text(
      str,
      style: TextStyle(
          color: ColorX.color_333333,
          fontSize: size.w,
          fontWeight: wight == true ? FontWeight.w600 : FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.w),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: widget.hasMore == true
                      ? COLOR.hexColor('#ececec')
                      : Colors.transparent))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleImage(
            url: widget.comment.logo ?? "",
          ).marginRight(12.w),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildText('${widget.comment.nickName}', 15, true),
                  widget.comment.officialComment == true
                      ? const SizedBox.shrink()
                      : Row(
                          children: [
                            ValueListenableBuilder(
                                valueListenable: fakeLikes,
                                builder: (context, value, child) {
                                  return _buildText('$value', 14)
                                      .marginRight(8.w);
                                }),
                            ValueListenableBuilder(
                                valueListenable: isLike,
                                builder: (context, value, child) {
                                  return Image.asset(
                                    value
                                        ? AppImagePath.community_home_like_y
                                        : AppImagePath.community_home_like,
                                    width: 17.w,
                                  );
                                })
                          ],
                        ).onOpaqueTap(() {
                          handleLike(isLike.value);
                        })
                ],
              ).padding(EdgeInsets.symmetric(vertical: 14.w)),
              //文本内容
              widget.comment.content!.isNotEmpty
                  ? Text(
                      '${widget.comment.content}',
                      style: TextStyle(
                        color: COLOR.hexColor(
                            widget.comment.officialComment == true
                                ? '#ff0331'
                                : '#333333'),
                        height: 2.27,
                        fontSize: 15.w,
                      ),
                    ).onOpaqueTap(() {
                      if (widget.comment.jump == true) {
                        // kAdjump(widget.comment.jumpUrl, 0);
                        jumpExternalURL(widget.comment.jumpUrl);
                      }
                    })
                  : const SizedBox.shrink(),
              widget.comment.img != null
                  ? Wrap(
                      spacing: 5.w,
                      children: widget.comment.img!.map((v) {
                        return ImageView(
                          src: v,
                          width: 98.w,
                          height: 98.w,
                          clipWidth: 1,
                        ).onOpaqueTap(() {
                          focusNode.unfocus();
                          imageViewerSheet(v);
                        });
                      }).toList(),
                    )
                  : const SizedBox.shrink(),
              //回复
              Row(
                children: [
                  _buildText(
                      '${Utils.dateAgo(widget.comment.createdAt!)}发布', 15),
                  widget.comment.officialComment == true
                      ? const SizedBox.shrink()
                      : Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 12.w),
                          width: 52.w,
                          height: 24.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.w),
                              color: COLOR.hexColor('#ececec'),
                              border:
                                  Border.all(color: COLOR.hexColor('#979797'))),
                          child: Text(
                            '回复',
                            style: TextStyle(
                                color: COLOR.hexColor('#252525'),
                                fontSize: 10.w),
                          ),
                        ).onOpaqueTap(() {
                          widget.reply(params, widget.comment.nickName);
                        })
                ],
              ).marginTop(20.w),
              widget.comment.replyNum! > 0 && widget.hasMore == true
                  ? Text(
                      '查看全部${widget.comment.replyNum}条回复',
                      style: TextStyle(
                          color: COLOR.hexColor('#1a68d0'),
                          fontSize: 16.w,
                          fontWeight: FontWeight.w600),
                    ).marginTop(15.w).onOpaqueTap(() {
                      showCommBack();
                    })
                  : const SizedBox.shrink()
            ],
          ))
        ],
      ),
    );
  }
}
