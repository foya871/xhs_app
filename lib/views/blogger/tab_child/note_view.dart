import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../components/base_paged/base_paged_child_builder_delegate.dart';
import '../../../components/safe_state.dart';
import '../../../http/api/api.dart';
import '../../../model/community/community_base_model.dart';
import '../../../utils/consts.dart';
import '../../community/common/base/community_base_cell.dart';

class NoteViewController {
  PagingController? _pagingController;
  void refresh() => _pagingController?.refresh();
}

class NoteView extends StatefulWidget {
  final int userId;
  final String Function() searchQueryGetter;
  final NoteViewController? controller;
  const NoteView(
      {super.key,
      required this.userId,
      required this.searchQueryGetter,
      this.controller});

  @override
  State<NoteView> createState() => _State();
}

class _State extends SafeState<NoteView> {
  final pagingController =
      PagingController<int, CommunityBaseModel>(firstPageKey: Consts.pageFirst);

  @override
  void initState() {
    pagingController.addPageRequestListener(_getHttpDatas);
    widget.controller?._pagingController = pagingController;
    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    widget.controller?._pagingController = null;
    super.dispose();
  }

  void _getHttpDatas(int page) async {
    final resp = await Api.getBloggerNoteList(
      userId: widget.userId,
      page: page,
      searchWord: widget.searchQueryGetter(),
      exclusiveToFans: false,
    );
    if (resp.isNotEmpty) {
      pagingController.appendPage(resp, page + 1);
    } else {
      pagingController.appendLastPage(resp);
    }
  }

  @override
  Widget build(BuildContext context) => PagedMasonryGridView.count(
        pagingController: pagingController,
        crossAxisCount: 2,
        builderDelegate: BasePagedChildBuilderDelegate<CommunityBaseModel>(
          itemBuilder: (context, item, index) => CommunityBaseCell(item),
        ),
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 4.w,
        padding: EdgeInsets.only(top: 10.w),
      );
}
