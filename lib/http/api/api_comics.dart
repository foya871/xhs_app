part of 'api.dart';

extension ApiComics on _Api {

 ///漫画详情的推荐
 Future<List<ComicDetailModel>?> getComicsRecommendList(int comicsId) async {
  try {
   final resp = await httpInstance.get(
    url: 'comics/base/getRec',
    queryMap: {'comicsId': comicsId,},
    complete: ComicDetailModel.fromJson,
   );
   return resp ?? [];
  } catch (e) {
   return null;
  }
 }

 // 获取漫画详情
 Future<ComicDetailModel?> getComicsBaseInfo(int comicsId) async {
  try {
   final resp = await httpInstance.get(
    url: 'comics/base/info',
    queryMap: {'comicsId': comicsId},
    requestEntireModel: true,
    complete: ComicDetailModel.fromJson,
   );
   return resp;
  } catch (e) {
   return null;
  }
 }

 ///漫画收藏
 Future<bool> comicsLike(int comicsId,bool isLike) async {
  try {
   final _ = await httpInstance.post(
    url: "comics/like/submit",
    body: {'comicsId': comicsId,"isLike":isLike},
   );
   return true;
  } catch (e) {
   return false;
  }
 }

 ///章节信息
 Future<ComicsChapterModel?> getChapterInfo(int chapterId) async {
  try {
   final resp = await httpInstance.get(
    url: 'comics/base/chapterInfo',
    queryMap: {'chapterId': chapterId},
    requestEntireModel: true,
    complete: ComicsChapterModel.fromJson,
   );
   return resp;
  } catch (e) {
   return null;
  }
 }

}

