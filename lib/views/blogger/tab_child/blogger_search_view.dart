import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

class BloggerSearchView extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback? onTap;

  const BloggerSearchView({
    super.key,
    required this.searchController,
    this.onTap,
  });

  @override
  State<BloggerSearchView> createState() => _BloggerSearchViewState();
}

class _BloggerSearchViewState extends State<BloggerSearchView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppBgView(
            height: 32.w,
            radius: 16.w,
            backgroundColor: COLOR.color_EBEBEB,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                ImageView(
                  src: AppImagePath.mine_mine_search,
                  width: 16.w,
                  height: 16.w,
                ),
                5.horizontalSpace,
                Expanded(
                  child: TextField(
                    controller: widget.searchController,
                    style: TextStyle(
                      color: COLOR.color_333333,
                      fontSize: 13.w,
                    ),
                    decoration: InputDecoration(
                      hintText: "请输入搜索的内容",
                      hintStyle: TextStyle(
                        color: COLOR.color_999999,
                        fontSize: 13.w,
                      ),
                      isCollapsed: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        TextView(
          text: "搜索",
          color: COLOR.color_666666,
          fontSize: 14.w,
          fontWeight: FontWeight.w500,
        ).onOpaqueTap(() => widget.onTap?.call()),
        15.horizontalSpace,
      ],
    );
  }
}
