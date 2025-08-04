import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/text_view.dart';

import '../../../assets/styles.dart';
import '../../../components/image_view.dart';
import '../../../components/common_permission_alert.dart';
import '../../../components/image_picker/easy_image_picker.dart';
import '../../../routes/routes.dart';
import '../../../utils/color.dart';
import '../frontpage/controller/edit_userinfo_controller.dart';

class EditUserHeadPage extends StatefulWidget {
  const EditUserHeadPage({super.key});

  @override
  State<StatefulWidget> createState() => _EditUserHeadPage();
}

class _EditUserHeadPage extends State<EditUserHeadPage> {
  Uint8List? _imgFile;
  bool isShowCliop = false;
  final controller = Get.find<EditUserInfoController>();

  void _showPicker() {
    if (!controller.us.isVIP) {
      permission_alert(context, desc: "您还不是会员,会员才可以修改！", oktitle: "去开通",
          okAction: () {
            Get.toVip();
      });
      return;
    }
    if (kIsWeb) {
      _pickImage(3);
      return;
    }
    showModalBottomSheet(
        context: context,
        backgroundColor: COLOR.hexColor("#111111"),
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  title: Text('从手机相册获取',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.w)),
                  onTap: () {
                    _pickImage(1);
                    Navigator.of(context).pop();
                  }),
              Divider(height: 3.w, color: COLOR.color_181818),
              ListTile(
                  title: Text('取消',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.w)),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> _pickImage(int index) async {
    final imageFile = index == 2
        ? await EasyImagePicker.pickSingleImageGrantCamera()
        : await EasyImagePicker.pickSingleImageGrant();
    final bytes = await imageFile?.bytes;
    if (!mounted) return;
    if (bytes != null) {
      setState(() {
        isShowCliop = true;
        _imgFile = bytes;
      });
      controller.postUploadImg(_imgFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Styles.color.bgColor,
      splashColor: Styles.color.bgColor,
      onTap: () => _showPicker(),
      child: SizedBox(
        width: double.infinity,
        height: 150.w,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: isShowCliop,
                    child: ClipOval(
                      child: _imgFile != null
                          ? Image.memory(
                              _imgFile!,
                              fit: BoxFit.cover,
                              width: 100.w,
                              height: 100.w,
                            )
                          : SizedBox.square(dimension: 100.w),
                    ),
                  ),
                  Visibility(
                    visible: !isShowCliop,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.w),
                      child: ImageView(
                        src: "${controller.userInfo.logo}",
                        width: 100.w,
                        height: 100.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.w),
              TextView(
                text: "点击更换头像",
                style: TextStyle(color: COLOR.color_333333, fontSize: 14.w),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
