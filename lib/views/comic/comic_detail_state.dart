import 'package:get/get.dart';
import 'package:xhs_app/model/comics/comic_detail_model.dart';

class ComicDetailState {

   int comicId = -1;
   var selectIndex = (-1).obs;
  final comicDetail = ComicDetailModel().obs;

  var recommendComic = RxList<ComicDetailModel>.empty(growable: true);

  ComicDetailState() {
    if (Get.parameters.isNotEmpty && Get.parameters['comicId'] != null) {
      comicId = int.parse(Get.parameters['comicId'] ?? '0');
    }
  }
}
