/*
 * @Author: wangdazhuang
 * @Date: 2024-09-07 09:02:02
 * @LastEditTime: 2024-09-07 10:10:39
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/components/image_viewer/image_viewer_page.dart
 */
import 'package:xhs_app/components/app_bar/extend_transparent_app_bar.dart';
import 'package:xhs_app/components/image_viewer/image_viewer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key});

  @override
  State<StatefulWidget> createState() {
    return ImageViewerState();
  }
}

class ImageViewerState extends State<ImageViewer> {
  late PageController controller;
  @override
  void initState() {
    final vc = Get.find<ImageViewerController>();
    vc.initImgs();
    controller = PageController(initialPage: vc.i);
    super.initState();
  }

  _buildIndicator(ImageViewerController _) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 50.w,
      child: Text(
        "${_.i + 1}/${_.imgs.length}",
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  _buildImageChecker(ImageViewerController _) {
    return Positioned.fill(
      child: PhotoViewGallery.builder(
        pageController: controller,
        scrollPhysics: const BouncingScrollPhysics(),
        customSize: Size(Get.width, Get.height),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: _.imgs[index],
            heroAttributes: PhotoViewHeroAttributes(
              tag: index.toString(),
            ),
          );
        },
        itemCount: _.imgs.length,
        onPageChanged: (v) {
          _.setIndex(v);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ExtendTransparentAppBar(),
      body: GetBuilder<ImageViewerController>(
        builder: (_) {
          return Stack(
            children: [
              _buildImageChecker(_),
              _buildIndicator(_),
            ],
          );
        },
      ),
    );
  }
}
