/*
 * @Author: wangdazhuang
 * @Date: 2024-08-29 15:50:19
 * @LastEditTime: 2024-08-31 15:00:17
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/views/mine/frontpage/controller/announcement_controller.dart
 */
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/mine/ann_news_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../utils/utils.dart';

class AnnouncementController extends GetxController {
  var annnews = [];
  String dateTime = "";
  int total = 0;

  Future getAnnList() async {
    try {
      final resp = await httpInstance.get(
        url: "news/ann/list",
        queryMap: {
          "page": 1,
          "pageSize": 1,
        },
      );
      if (resp is Map) {
        total = resp["total"];
        annnews =
            resp["data"].map((e) => AnnNewsRespModel.fromJson(e)).toList();
      }
      if (annnews.isEmpty) return;
      dateTime =
          Utils.dateFmt(annnews[0].startTime, ["yyyy", '-', 'mm', '-', 'dd']);
      update();
    } catch (e) {
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAnnList();
  }
}
