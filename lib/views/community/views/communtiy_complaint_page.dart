import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../assets/styles.dart';
import '../../../components/divider/default_divider.dart';
import '../../../components/easy_button.dart';
import '../../../generate/app_image_path.dart';
import '../../../utils/color.dart';
import '../../../utils/extension.dart';
import '../controllers/community_complaint_page_controller.dart';

class CommuntiyComplaintPage extends GetView<CommunityComplaintPageController> {
  const CommuntiyComplaintPage({super.key});

  Widget _buildOne(CommunityComplaintModel model) => SizedBox(
        height: 56.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              model.text,
              style: TextStyle(fontSize: 13.w),
            ),
            Obx(
              () => Image.asset(
                controller.selectedId.value == model.id
                    ? AppImagePath.community_complaint_check_y
                    : AppImagePath.community_complaint_check,
                width: 20.w,
                height: 20.w,
              ),
            )
          ],
        ).onOpaqueTap(() => controller.onTapSelect(model.id)),
      );

  Widget _buildOptions() => Column(
        children: CommunityComplaintPageController.models
            .map((e) => _buildOne(e))
            .toList()
            .joinSeperator(const DefaultDivider(), tail: true),
      );

  Widget _buildDescInput() => SizedBox(
        height: 160.w,
        child: TextField(
          maxLines: 100,
          controller: controller.editingController,
          cursorColor: COLOR.color_999999,
          decoration: InputDecoration(
            hintText: '请输入其他原因',
            hintStyle: TextStyle(color: COLOR.color_999999, fontSize: 14.w),
            fillColor: COLOR.color_EEEEEE,
            filled: true,
            isDense: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.text,
          maxLength: 200,
        ),
      );

  Widget _buildImagePicker() => Container(
        decoration: BoxDecoration(
          color: COLOR.color_EEEEEE,
          borderRadius: Styles.borderRadius.all(4.w),
        ),
        width: 104.w,
        height: 104.w,
        alignment: Alignment.center,
        child: Image.asset(
          AppImagePath.community_complaint_plus,
          width: 24.w,
          height: 24.w,
        ),
      ).onOpaqueTap(controller.onTapPickImage);

  Widget _buildPictureInput() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('上传图片', style: TextStyle(fontSize: 14.w)),
              Text(
                '(最多可上传${controller.maxImage}张)',
                style: TextStyle(fontSize: 12.w, color: COLOR.color_999999),
              ),
            ],
          ),
          19.verticalSpaceFromWidth,
          Obx(() {
            final width = 104.w;
            final height = 104.w;
            final List<Widget> children = [];
            children.addAll(
              controller.pickedImages.map(
                (e) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: Styles.borderRadius.all(4.w),
                      child: Image.memory(
                        e.item1,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: -7.w,
                      right: -7.w,
                      child: Image.asset(
                        AppImagePath.community_complaint_remove_pick_image,
                        width: 20.w,
                        height: 20.w,
                      ),
                    )
                  ],
                ),
              ),
            );
            if (children.length < controller.maxImage) {
              children.add(_buildImagePicker());
            }
            return Row(children: children.joinWidth(10.w));
          })
        ],
      );

  Widget _buildBtn() => EasyButton(
        '提交',
        height: 40.w,
        width: double.infinity,
        textStyle: TextStyle(
          color: COLOR.white,
          fontSize: 14.w,
          fontWeight: FontWeight.w500,
        ),
        borderRadius: Styles.borderRadius.all(23.w),
        backgroundColor: COLOR.color_FB2D45,
        onTap: controller.onSubmit,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('投诉')),
        backgroundColor: COLOR.color_FAFAFA,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOptions(),
              20.verticalSpaceFromWidth,
              _buildDescInput(),
              22.verticalSpaceFromWidth,
              _buildPictureInput(),
              30.verticalSpaceFromWidth,
              _buildBtn(),
              60.verticalSpaceFromWidth,
            ],
          ).baseMarginHorizontal,
        ),
      );
}
