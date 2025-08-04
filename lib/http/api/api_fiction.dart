part of 'api.dart';

//
extension ApiFiction on _Api {
// 获取分类(包含固定和已选的)
  Future<FictionBaseModel?> getFictionFindList(
      Map<String, dynamic>? body1,
      {int? page = 0,
        int? pageSize = 30}) async {
    Map<String, dynamic>? body = body1 ?? {};
    body["page"] = page;
    body["pageSize"] = pageSize;
    try {
      final resp = await httpInstance.post(
        url: 'fiction/base/findList',
        body: body,
      );
      return FictionBaseModel.fromJson(resp);
    } catch (e) {
      return null;
    }
  }

  ///小说浏览记录
  Future<List<FictionBase>?> getRecordFictionList({
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get<FictionBase>(
        url: 'fiction/base/getBrowseRecord',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: FictionBase.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///小说详情
  Future<FictionInfoModel?> getFictionBaseInfo({required int fictionId,}) async {
    try {
      final resp = await httpInstance.get<FictionInfoModel>(
        url: 'fiction/base/info',
        queryMap: {'fictionId': fictionId,},
        complete: FictionInfoModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  ///小说章节详情
  Future<FictionChapterInfoModel?> getFictionChapterInfo({required int fictionId,required int chapterId,}) async {
    try {
      final resp = await httpInstance.get<FictionChapterInfoModel>(
        url: 'fiction/base/chapterInfo',
        queryMap: {'fictionId': fictionId,'chapterId': chapterId,},
        complete: FictionChapterInfoModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }


  Future<String?> getFictionContent(String url) async {
    const firstLength = 100;
    const String keyyyy = 'a';
    final key = utf8.encode(keyyyy);
    try {
      final resp = await Dio(
          BaseOptions(responseType: ResponseType.bytes,)
      ).get(url);
      if(resp.statusCode == 200){
        Uint8List novelContent = resp.data;
        for (int i = 0; i < firstLength; i++) {
          novelContent[i] ^= key[i % key.length];
        }
        String str = const Utf8Decoder().convert(novelContent);
        var list = _splitText(str, 200);
        var content = StringBuffer();
        list.forEach((text){
          content.write(text);
          content.write("\n");
        });
        return content.toString();
      }
      return null;
    } catch (e) {
      return null;
    }
  }


  List<String> _splitText(String text, int chunkSize) {
    List<String> chunks = [];

    // 如果文本包含换行符，则按换行符分割
    if (text.contains('\n')) {
      chunks = text.split('\n');
    } else {
      // 否则，按指定字数分割
      for (int i = 0; i < text.length; i += chunkSize) {
        int end = (i + chunkSize < text.length) ? i + chunkSize : text.length;
        chunks.add(text.substring(i, end));
      }
    }

    // 重新计算每个段落，确保它们不超过指定字数
    List<String> finalChunks = [];
    for (String chunk in chunks) {
      if (chunk.length > chunkSize) {
        // 如果分割后的段落超过指定字数，再次按字数分割
        for (int i = 0; i < chunk.length; i += chunkSize) {
          int end =
          (i + chunkSize < chunk.length) ? i + chunkSize : chunk.length;
          finalChunks.add(chunk.substring(i, end));
        }
      } else {
        finalChunks.add(chunk);
      }
    }

    return finalChunks;
  }



}