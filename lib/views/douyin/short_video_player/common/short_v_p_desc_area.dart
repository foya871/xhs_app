import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../assets/styles.dart';
import '../../../../components/easy_button.dart';
import '../../../../model/play/video_detail_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import '../../../videotag/tag_videos.dart';

///
/// 左边文字区域， 标签，名称，购买信息
///
class ShortVPDescArea extends StatefulWidget {
  final VideoDetail detail;
  final VoidCallback? onTapBuy;

  const ShortVPDescArea(this.detail, {super.key, this.onTapBuy});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ShortVPDescArea> {
  VideoDetail get detail => widget.detail;

  Widget _buildTags(BuildContext context) {
    final items = detail.tagTitles ?? [];
    if (items.isEmpty) return const SizedBox.shrink();
    return Wrap(
      runSpacing: 8.w,
      children: items
          .map(
            (e) => Container(
              height: 20.w,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.35),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: Text(
                e,
                style: kTextStyle(Colors.white, fontsize: 13.w),
              ),
            ).marginRight(8.w).onTap(
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return TagVideos(mark: 1, tagsTitle: e, videoMark: 2);
                    },
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildBuyInfo() {
    if (detail.canWatch ?? false) return const SizedBox.shrink();
    return EasyButton(
      detail.videoType == VideoTypeValueEnum.VIP
          ? '开通VIP观看完整版'
          : '支付${(detail.price ?? .0).toStringAsShort()}金币观看',
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      height: 21.w,
      borderRadius: BorderRadius.circular(4.w),
      backgroundColor: detail.videoType == VideoTypeValueEnum.Pay
          ? COLOR.hexColor('#9500F5')
          : null,
      backgroundGradient: detail.videoType == VideoTypeValueEnum.VIP
          ? Styles.gradient.orangeToPink
          : null,
      textStyle:
          kTextStyle(Colors.white, fontsize: 13.w, weight: FontWeight.w500),
      onTap: widget.onTapBuy,
    );
  }

  Widget _buildBuyTitle() {
    return Text(
      detail.title ?? '',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.w,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBuyInfo(),
        SizedBox(height: 10.w),
        _buildBuyTitle(),
        SizedBox(height: 12.w),
        _buildTags(context),
      ],
    );
  }
}
