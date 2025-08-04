import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/easy_button.dart';
import '../../../../components/safe_state.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/community/community_classify_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import '../../../../utils/logger.dart';

// 编辑classify
class CommunityClassifyEditCell extends StatefulWidget {
  final List<CommunityClassifyModel> selected;
  final List<CommunityClassifyModel> optional;
  final Function(CommunityClassifyModel)? onTapChangeClassify;
  final Function(
    List<CommunityClassifyModel> selected,
    List<CommunityClassifyModel> optional,
  )? onEditDone;

  CommunityClassifyEditCell({
    super.key,
    required List<CommunityClassifyModel> selected,
    required List<CommunityClassifyModel> optional,
    this.onTapChangeClassify,
    this.onEditDone,
  })  : selected = [...selected],
        optional = [...optional];

  @override
  State<StatefulWidget> createState() => _CommunityClassifyEditCellState();
}

class _CommunityClassifyEditCellState extends SafeState<CommunityClassifyEditCell> {
  bool _editing = false;

  @override
  void dispose() {
    logger.d('dispose CommunityClassifyEditCell');
    super.dispose();
  }

  bool _isReorderable(int index) => _isReorderableModel(widget.selected[index]);
  bool _isReorderableModel(CommunityClassifyModel model) =>
      model.type == CommunityClassifyTypeEnum.optional;

  bool _inSelected(CommunityClassifyModel model) =>
      widget.selected
          .firstWhereOrNull((e) => e.classifyId == model.classifyId) !=
      null;

  Widget _buildSelectedTitle() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '我的频道',
                style: TextStyle(fontSize: 15.w, fontWeight: FontWeight.w500),
              ),
              8.horizontalSpace,
              Text(
                _editing ? '长按拖动排序' : '点击进入编辑',
                style: TextStyle(fontSize: 11.w, color: COLOR.color_999999),
              ),
            ],
          ),
          EasyButton(
            _editing ? '完成编辑' : '进入编辑',
            borderRadius: Styles.borderRadius.all(12.w),
            textStyle: TextStyle(
              color: COLOR.color_5193FB,
              fontSize: 13.w,
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: COLOR.color_EEEEEE,
            width: 70.w,
            height: 26.w,
            onTap: () {
              setState(() {
                _editing = !_editing;
              });
              if (!_editing) {
                widget.onEditDone?.call(widget.selected, widget.optional);
              }
            },
          )
        ],
      );

  Widget _buildOneSelected(CommunityClassifyModel model, int i) => Container(
        key: ValueKey(model.classifyId),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 74.w,
              height: 32.w,
              decoration: BoxDecoration(
                border: Border.all(color: COLOR.color_EEEEEE),
                borderRadius: Styles.borderRadius.all(4.w),
                color: _isReorderableModel(model) ? null : COLOR.color_EEEEEE,
              ),
              alignment: Alignment.center,
              child: Text(
                model.classifyTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13.w, color: COLOR.color_666666),
              ),
            ),
            _editing
                ? Positioned(
                    top: -5.w,
                    right: -5.w,
                    child: Image.asset(
                      AppImagePath.community_discover_select_classify_remove,
                      width: 13.w,
                      height: 13.w,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ).onOpaqueTap(() {
          if (_editing) {
            setState(() {
              widget.selected.remove(model);
            });
          } else {
            widget.onTapChangeClassify?.call(model);
          }
        }),
      );

  Widget _buildSelectedClassify() => AnimatedReorderableGridView(
        items: widget.selected,
        itemBuilder: (context, index) =>
            _buildOneSelected(widget.selected[index], index),
        sliverGridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2,
        ),
        shrinkWrap: true,
        controller: ScrollController(),
        enterTransition: [FlipInX(), ScaleIn()],
        exitTransition: [SlideInLeft()],
        insertDuration: const Duration(milliseconds: 300),
        removeDuration: const Duration(milliseconds: 300),
        onReorder: (oldIndex, newIndex) {
          if (!_isReorderable(newIndex)) {
            return;
          }
          setState(() {
            final e = widget.selected.removeAt(oldIndex);
            widget.selected.insert(newIndex, e);
          });
        },
        dragStartDelay: const Duration(milliseconds: 300),
        isSameItem: (a, b) => a.classifyId == b.classifyId,
      );

  Widget _buildOptionalTitle() => Row(
        children: [
          Text(
            '推荐频道',
            style: TextStyle(fontSize: 15.w, fontWeight: FontWeight.w500),
          ),
          8.horizontalSpace,
          if (_editing)
            Text(
              '点击添加频道',
              style: TextStyle(fontSize: 11.w, color: COLOR.color_999999),
            ),
        ],
      );

  Widget _buildOneOptional(CommunityClassifyModel model) {
    final inSelected = _inSelected(model);
    return Stack(
      children: [
        Container(
          width: 74.w,
          height: 32.w,
          decoration: BoxDecoration(
            border: Border.all(color: COLOR.color_EEEEEE),
            borderRadius: Styles.borderRadius.all(4.w),
            color: inSelected ? COLOR.color_EEEEEE : null,
          ),
          alignment: Alignment.center,
          child: Text(
            model.classifyTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.w, color: COLOR.color_666666),
          ),
        ),
        _editing
            ? Positioned(
                top: 2.w,
                right: 2.w,
                child: Image.asset(
                  AppImagePath.community_discover_select_classify_add,
                  width: 5.3.w,
                  height: 5.3.w,
                ),
              )
            : const SizedBox.shrink(),
      ],
    ).onOpaqueTap(() {
      if (!_editing) return;
      if (_inSelected(model)) return;
      setState(() {
        widget.selected.add(model);
      });
    });
  }

  Widget _buildOptionalClassify() => Column(
        children: widget.optional
            .slices(4)
            .map(
              (row) => Row(
                children: row
                    .map((e) => _buildOneOptional(e))
                    .toList()
                    .joinWidth(12.w),
              ),
            )
            .toList()
            .joinHeight(11.w),
      );

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 0.65.sh),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSelectedTitle(),
              16.verticalSpaceFromWidth,
              Flexible(child: _buildSelectedClassify()),
              16.verticalSpaceFromWidth,
              _buildOptionalTitle(),
              13.verticalSpaceFromWidth,
              _buildOptionalClassify(),
              40.verticalSpaceFromWidth,
            ],
          ).baseMarginHorizontal,
        ),
      );
}
