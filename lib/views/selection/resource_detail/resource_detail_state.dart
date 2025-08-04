import 'package:get/get.dart';

import '../../../model/video/resouce_info_model.dart';
import '../../../model/video/resource_download_model.dart';
import '../../../model/video/resource_report.dart';

class ResourceDetailState {
  ResourceDetailState() {
    ///Initialize variables
  }

  var resourceDetail = ResourceInfoModel().obs;

  var reports = RxList<ResourceReport>.empty(growable: true);

}
