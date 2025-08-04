import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/model/picture_cell_model/picture_cell_model.dart';
import 'package:xhs_app/routes/routes.dart';

class PictureCell extends StatelessWidget {
  const PictureCell({super.key, required this.picture});

  final PictureCellModel picture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toPortrayPlay(portrayPicId: picture.portrayPicId!);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 183 / 234,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                      child: ImageView(src: picture.coverImg ?? '')),
                  Positioned(
                    top: 5.0,
                    right: 5.0,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(9.0)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 0),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, .5),
                        ),
                        child: Text(
                          '${picture.imgNum}',
                          style: TextStyle(
                              fontSize: 12.w,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 0, top: 8, bottom: 0),
            child: Text(
              picture.title ?? '',
              style: TextStyle(
                  fontSize: 14.w,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
