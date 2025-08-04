import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/picture_cell_model/picture_cell_model.dart';
import 'package:xhs_app/model/picture_detail_model/picture_detail_model.dart';

abstract class PictureRepository {
  Future<List<PictureCellModel>> fetchPictureList(
      {int? sortType, bool? viewed, int? page = 1});

  Future<PictureDetailModel> fetchPictureDetailById(int portrayPicId);

  Future<void> pay(int portrayPicId);
}

class PictureRepositoryImpl implements PictureRepository {
  @override
  Future<List<PictureCellModel>> fetchPictureList({
    int? sortType,
    bool? viewed,
    int? page = 1,
  }) async {
    List<PictureCellModel> result = await httpInstance.get(
        url: 'portray/getPictureList',
        queryMap: {
          'page': page,
          'pageSize': 10,
          'sortType': sortType,
          'viewed': viewed,
        },
        complete: PictureCellModel.fromJson);

    return result;
  }

  @override
  Future<PictureDetailModel> fetchPictureDetailById(int portrayPicId) async {
    PictureDetailModel result = await httpInstance.get(
        url: 'portray/getPictureDetailById',
        queryMap: {
          'portrayPicId': portrayPicId,
        },
        complete: PictureDetailModel.fromJson);

    return result;
  }

  @override
  Future<void> pay(int portrayPicId) async {
    await httpInstance.post(url: 'portray/pur', body: {
      'portrayPicId': portrayPicId,
    });
  }
}
