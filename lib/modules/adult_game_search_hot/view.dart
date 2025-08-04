import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/model/adult_game_collection_model/adult_game_collection_model.dart';
import 'package:xhs_app/repositories/adult_game.dart';
import 'package:xhs_app/routes/routes.dart';

class AdultGameSearchHotView extends StatefulWidget {
  const AdultGameSearchHotView({super.key});

  @override
  State<AdultGameSearchHotView> createState() => _AdultGameSearchHotViewState();
}

class _AdultGameSearchHotViewState extends State<AdultGameSearchHotView> {
  @override
  void initState() {
    super.initState();
    initList();
  }

  List<AdultGameCollectionModel> _collectionList = [];

  void initList() async {
    _collectionList =
        await AdultGamesRepositoryImpl().fetchAdultGameCollection();

    setState(() {});
  }

  final List<Color> _colors = [
    const Color(0xfff8a742),
    const Color(0xff00cebb),
    const Color(0xffa1a8ff),
    const Color(0xfff67270),
    const Color(0xff0087ce),
  ];

  Color getRandomColor() {
    final random = Random();
    return _colors[random.nextInt(_colors.length)]; // 随机选择一个颜色
  }

  Widget _item(AdultGameCollectionModel collection) {
    return GestureDetector(
      onTap: () {
        Get.toAdultGameSearchResultByWord(collection.gameCollectionName!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 14.w),
        decoration: BoxDecoration(
            color: getRandomColor(), borderRadius: BorderRadius.circular(6.w)),
        child: Text(
          collection.gameCollectionName!,
          style: TextStyle(
            fontSize: 12.w,
            color: Colors.white,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 12.w,
      alignment: WrapAlignment.spaceAround,
      children: [
        ..._collectionList.map(
          (collection) => _item(collection),
        ),
      ],
    );
  }
}
