import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/partner_model/partner_model.dart';

abstract class SignInRepository {
  Future<List<PartnerModel>> fetchPartnerList(int labelType);

  Future<void> fetchClickReport(String id);
}

class SignInRepositoryImpl implements SignInRepository {
  @override
  Future<List<PartnerModel>> fetchPartnerList(int labelType) async {
    return await httpInstance.get(
        url: "sys/partner/list",
        complete: PartnerModel.fromJson,
        queryMap: {
          "labelType": labelType,
        });
  }

  @override
  Future<void> fetchClickReport(String id) async {
    return await httpInstance.post(url: "sys/partner/click/report", body: {
      "id": id,
    });
  }
}
