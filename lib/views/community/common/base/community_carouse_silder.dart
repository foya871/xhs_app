import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/safe_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/utils/color.dart';

class CommunityCarouseSlider extends StatefulWidget {
  final List<String> images;

  const CommunityCarouseSlider(this.images, {super.key});
  @override
  State<StatefulWidget> createState() => _CarsouleState();
}

class _CarsouleState extends SafeState<CommunityCarouseSlider> {
  List<String> get images => widget.images;
  int _index = 1;

  Widget _buildSilder() => CarouselSlider.builder(
        itemCount: images.length,
        itemBuilder: (ctx, i, realIndex) => ImageView(
          src: images[i],
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 9 / 14,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _index = (index + 1);
            });
          },
        ),
      );

  Widget _buildBanner() => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
        decoration: BoxDecoration(
          color: COLOR.black.withOpacity(0.5),
          borderRadius: Styles.borderRadius.all(12.w),
        ),
        alignment: Alignment.center,
        child: Text(
          '$_index/${images.length}',
          style: TextStyle(color: COLOR.white, fontSize: 12.w),
        ),
      );

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          _buildSilder(),
          Positioned(
            top: 16.w,
            right: 10.w,
            child: _buildBanner(),
          )
        ],
      );
}
