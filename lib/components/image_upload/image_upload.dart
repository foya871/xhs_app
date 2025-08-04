import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';

import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/image_upload_resp_model.dart';
import 'package:xhs_app/model/upload_image/upload_image.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import 'package:xhs_app/utils/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../assets/styles.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({
    super.key,
    required this.success,
    this.limit = 9,
    this.isVertical,
  });

  final int limit;
  final Function success;
  final bool? isVertical;

  @override
  State<StatefulWidget> createState() => _ImageUpload();
}

class _ImageUpload extends State<ImageUpload> {
  ValueNotifier<List<UploadImageModel>> images = ValueNotifier([]);
  List<PlatformFile> webfiles = [];
  List<String?> appfiles = [];

  void getPermission() async {
    if (!kIsWeb) {
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        selectImages();
      }
    } else {
      selectImages();
    }
  }

  void selectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result != null) {
      var idx = images.value.length;
      images.value = [
        ...images.value,
        ...result.files.map((v) {
          return UploadImageModel.fromJson({'path': '', 'status': ''});
        }).take(widget.limit - idx)
      ];
      if (kIsWeb) {
        var list = result.files.take(widget.limit).toList();
        webfiles = [...webfiles, ...list];
        for (var i = 0; i < list.length; i++) {
          var bytes = list[i].bytes;
          try {
            ImageUploadRspModel? resp =
                await httpInstance.uploadImage(bytes!, (int count, int total) {
              logger.d("$count/$total");
            });
            images.value[i + idx].path = resp!.fileName!;
            images.value[i + idx].status = 'sucess';
            images.value = [...images.value];
          } catch (e) {
            images.value[i + idx].path = '';
            images.value[i + idx].status = 'error';
          }
        }
      } else {
        var list = result.paths.take(widget.limit).toList();
        appfiles = [...appfiles, ...list];
        for (var i = 0; i < list.length; i++) {
          Uint8List lll = await File(list[i]!).readAsBytes();

          try {
            ImageUploadRspModel? resp =
                await httpInstance.uploadImage(lll, (int count, int total) {
              logger.d("$count/$total");
            });
            images.value[i + idx].path = resp!.fileName!;
            images.value[i + idx].status = 'success';
            images.value = [...images.value];
          } catch (e) {
            images.value[i + idx].path = '';
            images.value[i + idx].status = 'error';
          }
        }
      }
      var backList = images.value.map((v) {
        return v.path;
      }).toList();
      widget.success(List<String>.from(backList));
    }
  }

  void retransmit(int idx) async {
    if (kIsWeb) {
      var bytes = webfiles[idx].bytes;
      images.value[idx].path = '';
      images.value[idx].status = '';
      images.value = [...images.value];
      try {
        ImageUploadRspModel? resp =
            await httpInstance.uploadImage(bytes!, (int count, int total) {
          logger.d("$count/$total");
        });
        images.value[idx].path = resp!.fileName!;
        images.value[idx].status = 'sucess';
        images.value = [...images.value];
      } catch (e) {
        images.value[idx].path = '';
        images.value[idx].status = 'error';
      }
    } else {
      images.value[idx].path = '';
      images.value[idx].status = '';
      images.value = [...images.value];
      Uint8List lll = await File(appfiles[idx]!).readAsBytes();
      try {
        ImageUploadRspModel? resp =
            await httpInstance.uploadImage(lll, (int count, int total) {
          logger.d("$count/$total");
        });
        images.value[idx].path = resp!.fileName!;
        images.value[idx].status = 'success';
        images.value = [...images.value];
      } catch (e) {
        images.value[idx].path = '';
        images.value[idx].status = 'error';
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBtn() {
    return Container(
      width: widget.isVertical == true ? 114.w : 120.w,
      height: widget.isVertical == true ? 131.w : 120.w,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImagePath.community_community_add_image),
        ),
      ),
    ).onOpaqueTap(() {
      getPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: images,
        builder: (context, value, child) {
          return Wrap(
            spacing: 6.w,
            runSpacing: 6.w,
            children: [
              ...value.asMap().entries.map((v) {
                return Stack(
                  children: [
                    Container(
                      width: widget.isVertical == true ? 114.w : 120.w,
                      height: widget.isVertical == true ? 131.w : 120.w,
                      clipBehavior: Clip.hardEdge,
                      decoration:
                          BoxDecoration(borderRadius: Styles.borderRadius.m),
                      child: ImageView(src: v.value.path!),
                    ),
                    Positioned(
                        child: v.value.status!.isEmpty
                            ? Container(
                                width:
                                    widget.isVertical == true ? 114.w : 120.w,
                                height:
                                    widget.isVertical == true ? 131.w : 120.w,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                                    borderRadius: Styles.borderRadius.m),
                                child: Container(
                                  margin: EdgeInsets.all(30.w),
                                  width: 10.w,
                                  height: 10.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 3,
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()),
                    Positioned(
                        child: v.value.status == 'error'
                            ? Container(
                                width:
                                    widget.isVertical == true ? 114.w : 120.w,
                                height:
                                    widget.isVertical == true ? 131.w : 120.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                                    borderRadius: Styles.borderRadius.m),
                                child: Text(
                                  '点击重传',
                                  style: TextStyle(
                                      color: COLOR.hexColor('#F52443'),
                                      fontSize: 15.w),
                                ),
                              ).onOpaqueTap(() {
                                var index = v.key;
                                retransmit(index);
                              })
                            : const SizedBox.shrink()),
                    v.value.status!.isNotEmpty
                        ? Positioned(
                            right: 0.w,
                            top: 0.w,
                            child: Image.asset(
                              AppImagePath.community_community_delete,
                              width: 18.w,
                              height: 18.w,
                            ).onOpaqueTap(() {
                              var index = v.key;
                              if (kIsWeb) {
                                webfiles.removeAt(index);
                              } else {
                                appfiles.removeAt(index);
                              }
                              images.value.removeAt(index);
                              images.value = [...images.value];
                              var backList = images.value.map((v) {
                                return v.path;
                              }).toList();
                              widget.success(List<String>.from(backList));
                            }))
                        : const SizedBox.shrink()
                  ],
                );
              }),
              value.length < widget.limit
                  ? _buildBtn()
                  : const SizedBox.shrink()
            ],
          );
        });
  }
}
