import 'ad_enum.dart';
import 'ad_utils.dart';

// PagingController 中处理返回的分页数据
// 保存一个offset的状态

class AdInsertHelper<T> {
  final AdApiType place;
  late int _interval = adHelper.getInsertWeight(place);
  int get interval => _interval;
  int _offset = 0;
  int get offset => _offset;

  AdInsertHelper(this.place);

  // 直接插入place
  List<dynamic> insert(List<T> models) {
    if (_interval == 0) return models;
    final result = [];
    for (final model in models) {
      result.add(model);
      _offset++;
      if (_offset == _interval) {
        result.add(place);
        _offset = 0;
      }
    }
    return result;
  }

  // 插入时，返回类型T
  // 由广告位置构建一个新的T
  List<T> insertWithType(
      List<T> models, T Function(AdApiType place) modelFromAdBuilder) {
    if (_interval == 0) return models;
    final result = <T>[];
    for (final model in models) {
      result.add(model);
      _offset++;
      if (_offset == _interval) {
        result.add(modelFromAdBuilder(place));
        _offset = 0;
      }
    }
    return result;
  }

  void reset() {
    _interval = adHelper.getInsertWeight(place);
    _offset = 0;
  }
}
