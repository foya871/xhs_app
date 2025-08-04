import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../assets/styles.dart';
import '../../../components/ad/ad_enum.dart';
import '../../../components/ad/ad_info_model.dart';
import '../../../components/ad/ad_utils.dart';
import '../../../components/image_view.dart';

class TimerAd extends StatefulWidget {
  const TimerAd({super.key});

  @override
  State<TimerAd> createState() => _TimerAdState();
}

class _TimerAdState extends State<TimerAd> {
  late final AdInfoModel? _ad;
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _ad = adHelper.getAdInfo(AdApiType.PLAY_PAGE_THUMBNAIL);
    if (_ad != null) {
      _seconds = _ad.minStaySecond ?? 10;
      // _seconds = 30;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _seconds--;
            if (_seconds == 0) {
              _timer?.cancel();
              _timer = null;
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  Widget _buildTimerNum(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.6),
          borderRadius: BorderRadius.circular(size.height / 2.0)),
      child: Text(
        '$_seconds',
        style: kTextStyle(Colors.white, fontsize: 12.w),
      ),
    );
  }

  Widget _buildAdImage(Size adSize) {
    return ImageView(
      src: _ad?.adImage ?? '',
      fit: BoxFit.fill,
      width: adSize.width,
      height: adSize.height,
      // borderRadius: Styles.borderRadius.s,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_ad == null || _seconds == 0) return const SizedBox.shrink();
    final size = Size(20.w, 20.w);
    final adSize = Size(160.w, 32.w);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildAdImage(adSize),
        Positioned(right: -5.w, top: -6.w, child: _buildTimerNum(size)),
      ],
    );
  }
}
