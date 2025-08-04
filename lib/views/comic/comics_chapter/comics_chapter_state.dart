import 'package:get/get.dart';

import '../../../model/comics/comic_detail_model.dart';
import '../../../model/comics/comics_chapter.dart';

class ComicsChapterState {
  ComicsChapterState() {
    ///Initialize variables
  }

  var chapter = ChapterList();
  final comicDetail = ComicDetailModel().obs;

  var chapterDetail = ComicsChapterModel().obs;

  ///章节id
  var chapterIndex = 0.obs;

}
