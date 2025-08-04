import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scan/scan.dart';

import '../../../assets/styles.dart';
import '../../../components/image_picker/easy_image_picker.dart';
import '../../../utils/color.dart';

class ScanPage extends StatelessWidget {
  ScanPage({super.key});

  IconData lightIcon = Icons.flash_on;
  final ScanController _controller = ScanController();

  void getResult(String result) {
    Get.back(result: result);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = COLOR.color_FAFAFA;

    void onBackClick() {
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 20.w,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: COLOR.color_333333,
          ),
          onPressed: () => onBackClick(),
        ),
        title: Text("找回账号",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.w,
              fontWeight: FontWeight.w500,
            )),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: COLOR.hexColor("#4d393549"))),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        ScanView(
          controller: _controller,
          scanLineColor: Color(0xFF4759DA),
          onCapture: (data) {
            _controller.pause();
            getResult(data);
          },
        ),
        Positioned(
          left: 100.w,
          bottom: 100.w,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return MaterialButton(
                  child: Icon(
                    lightIcon,
                    size: 40.w,
                    color: Color(0xFF4759DA),
                  ),
                  onPressed: () {
                    _controller.toggleTorchMode();
                    if (lightIcon == Icons.flash_on) {
                      lightIcon = Icons.flash_off;
                    } else {
                      lightIcon = Icons.flash_on;
                    }
                    setState(() {});
                  });
            },
          ),
        ),
        Positioned(
          right: 100.w,
          bottom: 100.w,
          child: MaterialButton(
              child: Icon(
                Icons.image,
                size: 40.w,
                color: Color(0xFF4759DA),
              ),
              onPressed: () async {
                _pickImage(context);
              }),
        ),
      ]),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final imageFile = await EasyImagePicker.pickSingleImageGrant();
    // final bytes = await imageFile?.bytes;
    if (imageFile != null) {
      _controller.pause();
      String? result = await Scan.parse(imageFile.path);
      if (result != null) {
        getResult(result);
      }
    }
  }
}
