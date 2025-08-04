import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/model/adult_game_collection_model/adult_game_collection_model.dart';

class AdultGameSearchResultController extends GetxController {
  List<AdultGameCollectionModel> collectionList = [];

  String keyWord = '';

  void updateKeyword(String word) {
    if (word.isEmpty) {
      return;
    }

    keyWord = word;
  }

  void clearKeyword() {
    keyWord = '';
  }

  @override
  void onInit() {
    keyWord = Get.parameters['word'] ?? '';
    // initGame();
    super.onInit();
  }
}
