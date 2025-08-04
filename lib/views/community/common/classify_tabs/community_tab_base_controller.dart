import 'package:xhs_app/components/base_refresh/base_refresh_simple_controller.dart';
import 'package:xhs_app/model/community/community_classify_model.dart';

abstract class CommunityTabBaseController<E>
    extends BaseRefreshSimpleController<E> {
  final CommunityClassifyModel classify;
  CommunityTabBaseController(this.classify);
}
