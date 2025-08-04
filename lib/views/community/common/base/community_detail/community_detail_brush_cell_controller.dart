import '../../../../../components/brush/brush_base_cell_controller.dart';
import '../../../../../components/generic_player/generic_player.dart';
import '../../../../../model/community/community_model.dart';
import '../../../controllers/community_detail_page_controller.dart';

class CommunityBrushDetailCellController
    extends BrushBaseCellController<CommunityBrushBaseInfo, CommunityModel> {
  CommunityBrushDetailCellController();

  final playerController = GenericPlayerController();
  late final Function() _checkPlayable;

  void initCheckPlayable(bool Function() check) => _checkPlayable = check;

  void _playOrPause() {
    if (_checkPlayable()) {
      playerController.play();
    } else {
      playerController.pause();
    }
  }

  @override
  void onPageIndexChanged(int pageIndex) => _playOrPause();

  @override
  void onPageVisibleChanged(bool pageVisible) => _playOrPause();
}
