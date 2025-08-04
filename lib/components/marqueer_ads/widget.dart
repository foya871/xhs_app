import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marqueer/marqueer.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/image_view.dart';
// import 'package:xhs_app/model/sys_special_cell_model/sys_special_cell_model.dart';
import 'package:xhs_app/utils/ad_jump.dart';

class MarqueerAds extends StatefulWidget {
  const MarqueerAds({super.key, required this.ads});
  final List<AdInfoModel> ads;

  @override
  State<MarqueerAds> createState() => _MarqueerAdsState();
}

class _MarqueerAdsState extends State<MarqueerAds> {
  final MarqueerController marqueerController = MarqueerController();

  List<AdInfoModel> get fist4Ads => widget.ads.take(4).toList();

  List<AdInfoModel> get lastAds => widget.ads.skip(4).toList();

  Widget _buildSpecialsItem(AdInfoModel e) {
    return GestureDetector(
        onTap: () {
          kAdjump(e);
          // jumpExternalAddress(e.link ?? '', {
          //   "type": 4,
          //   "adId": e.id,
          //   "address": "顶部专区广告",
          // });
        },
        child: Column(
          children: [
            ImageView(
                src: e.adImage ?? '',
                width: 54.w,
                height: 54.w,
                borderRadius: BorderRadius.circular(5.w)),
            5.verticalSpaceFromWidth,
            SizedBox(
              width: 54.w,
              child: Text(e.adName ?? '',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis),
            )
          ],
        ));
  }

  Widget _buildFirst4Specials() {
    return Row(
      spacing: 10.w,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...fist4Ads.map((e) => _buildSpecialsItem(e)),
      ],
    );
  }

  Widget _buildLastSpecials() {
    return SizedBox(
        width: double.infinity,
        height: 78.w,
        child: Marqueer(
          // interaction: false,
          // restartAfterInteraction: true,
          // pps: 100,

          /// optional
          controller: marqueerController,

          /// optional
          direction: MarqueerDirection.rtl,

          /// optional
          // restartAfterInteractionDuration: const Duration(seconds: 6),

          /// optional
          // restartAfterInteraction: false,
          separatorBuilder: (context, index) => SizedBox(width: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10.w,
            children: [
              ...lastAds.map((e) => _buildSpecialsItem(e)),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return widget.ads.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 14.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (fist4Ads.isNotEmpty) _buildFirst4Specials(),
              if (lastAds.isNotEmpty) _buildLastSpecials(),
            ],
          );
  }
}
