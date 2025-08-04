import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../assets/styles.dart';
import '../../utils/ad_jump.dart';
import '../../utils/extension.dart';
import '../ad/ad_enum.dart';
import '../ad/ad_info_model.dart';
import '../ad/ad_utils.dart';
import '../image_view.dart';

class ClassifyAds extends StatefulWidget {
  final AdApiType place;
  const ClassifyAds({super.key, this.place = AdApiType.TOP_BANNER});

  @override
  State<ClassifyAds> createState() => _ClassifyAdsState();
}

class _ClassifyAdsState extends State<ClassifyAds> {
  List<AdInfoModel> ads = [];
  @override
  void initState() {
    super.initState();
    ads = adHelper.getAdLoadInOrder(widget.place);
  }

  @override
  Widget build(BuildContext context) {
    if (ads.isEmpty) return const SizedBox.shrink();
    return CarouselSlider.builder(
      itemCount: ads.length,
      itemBuilder: (context, index, realIndex) {
        return ImageView(
          src: ads[index].adImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          borderRadius: Styles.borderRadius.all(8.w),
        ).onTap(() => kAdjump(ads[index])).marginHorizontal(14.w);
      },
      options: CarouselOptions(
        viewportFraction: 1.0,
        autoPlay: true,
        aspectRatio: widget.place.ratio,
      ),
    );
  }
}
