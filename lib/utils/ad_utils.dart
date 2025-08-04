// import 'enum.dart';
// import 'initAdvertisementInfo.dart';

// class InsertAdPlaceHolderModel {
//   final AdPlaceEnum place;
//   InsertAdPlaceHolderModel(this.place);
// }

// typedef StationOrAdPlaceHolderModel = dynamic;
// typedef VideoBaseOrAdPlaceHolderModel = dynamic;
// typedef CommunityBaseOrAdPlaceHolderModel = dynamic;

// abstract class AdUtils {
//   static const adModelIndex = -1;

//   static bool isAdModelIndex(int i) => i == adModelIndex;

//   static int interval(AdPlaceEnum place) {
//     final info = initSequenceAdvertisementInfo(place);
//     if (info.isEmpty) return 0;
//     return initRuleIntervalNum(place);
//   }

//   // static List<dynamic> insertAdToModels<T>(List<T> models,
//   //     {required int interval, required AdPlaceEnum place}) {
//   //   if (interval == 0) return models;
//   //   final modelsLength = models.length;
//   //   if (modelsLength == 0) return models;
//   //   final resultLength = modelsLength + modelsLength ~/ interval;
//   //   var modelI = 0;
//   //   return List.generate(resultLength, growable: false, (index) {
//   //     if ((index + 1) % (interval + 1) == 0) {
//   //       return InsertAdPlaceHolderModel(place);
//   //     } else {
//   //       return models[modelI++];
//   //     }
//   //   });
//   // }

//   static int withAdLength(int modelsLength, {required int interval}) {
//     if (interval == 0) return modelsLength;
//     return modelsLength + modelsLength ~/ interval;
//   }

//   static int buildIndexToModelIndex(int buildIndex, {required int interval}) {
//     if (interval == 0) return buildIndex;
//     if ((buildIndex + 1) % (interval + 1) == 0) {
//       return adModelIndex;
//     }
//     return buildIndex - (buildIndex ~/ (interval + 1));
//   }

//   static dynamic modelByBuildIndex<T>(int buildIndex,
//       {required List<T> models,
//       required int interval,
//       required AdPlaceEnum place}) {
//     final modelIndex = buildIndexToModelIndex(buildIndex, interval: interval);
//     final isAd = isAdModelIndex(modelIndex);
//     return isAd ? InsertAdPlaceHolderModel(place) : models[modelIndex];
//   }
// }
