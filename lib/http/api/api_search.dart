
part of 'api.dart';

extension ApiSearch on _Api {

  // 猜你喜欢
  Future<List<HotWordModel>?> getSearchHotWord() async {
    try {
      final resp = await httpInstance.get<HotWordModel>(
        url: 'search/hotWord',
        // queryMap: {'mark': 4,},
        complete: HotWordModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 搜索热搜词
  Future<List<DynamicHotWordModel>?> getDynamicHotWord() async {
    try {
      final resp = await httpInstance.get<DynamicHotWordModel>(
        url: 'search/getDynamicHot',
        // queryMap: {'mark': 4,},
        complete: DynamicHotWordModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  //搜索
  Future<SearchVideoModel?> getResultByKeyword(int page,int pageSize,int searchType,String searchWord) async {
    try {
      final resp = await httpInstance.get<SearchVideoModel>(
        url: 'search/keyWord',
        queryMap: {'page': page,'pageSize':pageSize,'searchType':searchType,'searchWord':searchWord},
        complete: SearchVideoModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }


}