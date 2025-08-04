import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/model/adult_game_collection_model/adult_game_collection_model.dart';
import 'package:xhs_app/repositories/adult_game.dart';

class AdultGameListCollectionController extends GetxController {
  List<String> hostTypeNames = ['', 'Android', 'PC', 'iOS'];

  late TabController tabController;

  // int activeCollectionIndex = 0;

  // void changeActiveCollectionIndex(int index) {
  //   activeCollectionIndex = index;
  //   update();
  // }

  List<AdultGameCollectionModel> collectionList = [];

  Future<void> initCollectionList() async {
    var result = await AdultGamesRepositoryImpl().fetchAdultGameCollection();

    // collectionList = [...result, ...result];
    collectionList = result;

    update();
  }
}
