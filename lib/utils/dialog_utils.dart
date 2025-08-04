

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/components/popups/product_pay_bottom_sheet.dart';
import 'package:xhs_app/model/comics/comic_detail_model.dart';
import 'package:xhs_app/views/novel/bs_novel_chapter.dart';

import '../components/diolog/dialog_resource_link.dart';
import '../components/popups/bs_comics_chapter.dart';
import '../model/fiction/fiction_info_model.dart';
import '../model/video/product_detail_model.dart';

class DialogUtils{

  ///下载链接
  static Future<bool?> showDownloadLink(BuildContext context, String? title, String? url,String? password,String? zipPassword) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            content: DialogResourceLink(title,url,password,zipPassword),
          );
        });
  }


  static Future<int?> showNovelChapterSheet(BuildContext context, List<Chapters> chapters,int chapterIndex) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => BsNovelChapter(chapters,chapterIndex),
    );
  }

  static Future<int?> showComicsChapterSheet(BuildContext context, List<ChapterList> chapters,int chapterIndex) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => BsComicsChapter(chapters,chapterIndex),
    );
  }

  static Future<dynamic> showProductPaySheet(BuildContext context,ProductDetailModel model) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => ProductPayBottomSheet(model,),
    );
  }


}


