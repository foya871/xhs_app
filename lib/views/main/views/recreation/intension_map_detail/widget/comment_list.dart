/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-10-31 10:44:07
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-11-05 17:45:46
 * @FilePath: /51yuseman_app/lib/app/pages/home/comment_list.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_more.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/comment/comment_dynamic_model.dart';
import 'package:xhs_app/model/comment/comment_send_model.dart';
import 'package:xhs_app/utils/extension.dart';

import 'comment_item.dart';

typedef CommentsType = int;

abstract class CommentTypeEnumValue {
  //帖子评论
  static const CommentsType topic = 1;
}

class CommentList extends StatefulWidget {
  final Function reply;
  final int gossipId;
  final int? parentId;
  final bool? hasMore;
  final CommentsType? type;

  const CommentList({
    super.key,
    required this.reply,
    required this.gossipId,
    this.parentId,
    this.hasMore = true,
    this.type,
  });

  @override
  State<StatefulWidget> createState() => _CommentList();
}

class _CommentList extends State<CommentList> {
  final PagingController<int, CommentDynamicModel> _pagingController =
      PagingController(firstPageKey: 1);
  final _pageSize = 20;

  Future _initListData(int pageKey) async {
    final params = widget.type == CommentTypeEnumValue.topic
        ? {
            'dynamicId': widget.gossipId,
            'parentId': widget.parentId,
          }
        : {
            'gossipId': widget.gossipId,
            'parentId': widget.parentId,
          };
    final comm = await httpInstance.get<CommentDynamicModel>(
        url: widget.type == CommentTypeEnumValue.topic
            ? 'community/dynamic/commentList'
            : '/gossip/commentList',
        queryMap: {
          'pageSize': _pageSize,
          'page': pageKey,
          ...params,
        },
        complete: CommentDynamicModel.fromJson);
    final isLastPage = comm.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(comm);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(comm, nextPageKey as int?);
    }
  }

  @override
  initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _initListData(pageKey);
    });
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedSliverList(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CommentDynamicModel>(
            noMoreItemsIndicatorBuilder: (_) {
          return const NoMore();
        }, noItemsFoundIndicatorBuilder: (_) {
          return const NoData();
        }, itemBuilder: (context, value, index) {
          return CommentItem(
            reply: (CommentSendModel v, String nick) {
              widget.reply(v, nick);
            },
            comment: value,
            hasMore: widget.hasMore,
            type: CommentTypeEnumValue.topic,
          ).marginBottom(30.w);
        }));
  }
}
