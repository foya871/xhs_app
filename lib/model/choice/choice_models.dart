import 'package:json2dart_safe/json2dart.dart';

const _aiChoiceId = -987654321;

class VideoChoiceModel {
  final int choiceId;
  final String choiceName;
  final String coverImg;
  final String info;

  bool get isAi => choiceId == _aiChoiceId;

  VideoChoiceModel.ai()
      : choiceId = _aiChoiceId,
        choiceName = '',
        coverImg = '',
        info = '';

  VideoChoiceModel.fromJson(Map<String, dynamic> json)
      : choiceId = json.asInt('choiceId'),
        choiceName = json.asString('choiceName'),
        coverImg = json.asString('coverImg'),
        info = json.asString('info');
}
