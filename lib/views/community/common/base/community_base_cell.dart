import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/circle_image.dart';
import '../../../../components/easy_button.dart';
import '../../../../components/image_view.dart';
import '../../../../components/safe_state.dart';
import '../../../../event_bus/event_bus.dart';
import '../../../../event_bus/events/dynamic_event.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../http/api/api.dart';
import '../../../../model/community/community_base_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../../utils/utils.dart';

// 动态
// 一行两个，瀑布流
class CommunityBaseCell extends StatelessWidget {
  final CommunityBaseModel model;
  const CommunityBaseCell(this.model, {super.key});

  void _onTap() => Get.toCommunityDetail(model);

  Widget _buildCover() => Stack(
        children: [
          ImageView(
            src: model.cover,
            width: 173.w,
            borderRadius: Styles.borderRadius.top(4.w),
          ),
          if (model.isVideo)
            Positioned(
              top: 6.w,
              right: 6.w,
              child: Image.asset(
                AppImagePath.community_discover_play,
                width: 20.w,
                height: 20.w,
              ),
            ),
        ],
      ).onOpaqueTap(_onTap);

  Widget _buildTitle() => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              model.title,
              style: TextStyle(fontSize: 13.w, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );

  Widget _buildInfo() => _BottomInfoWidget(model);

  @override
  Widget build(BuildContext context) => Container(
        color: COLOR.white,
        child: Column(
          children: [
            _buildCover(),
            8.verticalSpaceFromWidth,
            _buildTitle().marginHorizontal(5.w),
            9.verticalSpaceFromWidth,
            _buildInfo().marginHorizontal(5.w),
          ],
        ),
      );
}

class _BottomInfoWidget extends StatefulWidget {
  final CommunityBaseModel model;
  const _BottomInfoWidget(this.model);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<_BottomInfoWidget> {
  CommunityBaseModel get model => widget.model;

  @override
  void initState() {
    EventBusInst.listen<DynamicChangeEvent>(
      (e) => setState(() => model.onChangeEvent(e)),
      test: (e) => e.id == model.dynamicId,
    );
    super.initState();
  }

  Future<void> _onTapLike() async {
    final ok = await Api.toggleCommunityLike(
      model.dynamicId,
      isLike: model.isLike,
    );
    if (!ok) return;
    setState(() {
      model.onToggleLikeSuccess();
    });
  }

  Widget _buildLeading() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleImage.network(model.logo, size: 16.w),
          2.horizontalSpace,
          Expanded(
            child: Text(
              model.nickName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: COLOR.color_666666,
                fontSize: 10.w,
              ),
            ),
          ),
        ],
      ).onOpaqueTap(() => Get.toBloggerDetail(userId: model.userId));

  Widget _buildTrailing() => Row(
        children: [
          EasyButton.child(
            Image.asset(
              model.isLike
                  ? AppImagePath.community_discover_like_y
                  : AppImagePath.community_discover_like,
              width: 13.w,
              height: 11.w,
            ),
            width: 13.1.w,
            height: 10.9.w,
            loadingStrokeWidth: 1.w,
            loadingSize: 10.w,
            onTap: _onTapLike,
          ),
          2.9.horizontalSpace,
          Text(
            Utils.numFmt(model.fakeLikes),
            style: TextStyle(
              color: COLOR.color_666666,
              fontSize: 10.w,
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: _buildLeading()),
          5.horizontalSpace,
          _buildTrailing(),
        ],
      );
}
