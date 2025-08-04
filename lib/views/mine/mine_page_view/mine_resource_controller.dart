/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-02 11:05:16
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-02 12:45:34
 * @FilePath: /xhs_app/lib/views/mine/mine_download/mine_download_list_page_controller.dart
 * @Description: MineDownloadListPageController
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_simple_controller.dart';
import 'package:xhs_app/model/download_resource_model.dart';

import '../../../http/api/api.dart';

const _pageSize = 20;
const _useObs = true;

class MineResourceController
    extends BaseRefreshSimpleController<DownloadResourceModel> {
  RxString searchWord = ''.obs;

  @override
  bool get useObs => _useObs;
  @override
  Future<List<DownloadResourceModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return Api.getPersonResourceList(
        page: page, pageSize: _pageSize, searchWord: searchWord.value);
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}
