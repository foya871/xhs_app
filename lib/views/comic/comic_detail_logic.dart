import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../http/api/api.dart';
import '../../model/comics/comic_detail_model.dart';
import '../../model/portrait/portrait_model.dart';
import '../../utils/logger.dart';
import 'comic_detail_state.dart';

class ComicDetailLogic extends GetxController with StateMixin, GetTickerProviderStateMixin {
  final tabs = <PortraitModel>[];
  TabController? tabController;
  final ComicDetailState state = ComicDetailState();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }


  void loadData() async {
    Api.getComicsBaseInfo(state.comicId).then((resp){
      state.comicDetail.value = resp ?? ComicDetailModel();
    });
    Api.getComicsRecommendList(state.comicId).then((resp){
      state.recommendComic.assignAll(resp ?? []);
    });
  }


  void comicsLike(bool isLike){
    SmartDialog.showLoading(msg: '提交中...');
    Api.comicsLike(state.comicId, !isLike).then((resp){
      loadData();
      SmartDialog.dismiss();
    });
  }



}
