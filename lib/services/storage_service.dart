/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-16 16:33:01
 * @LastEditors: wdz
 * @LastEditTime: 2025-06-18 19:41:27
 * @FilePath: /xhs_app/lib/services/storage_service.dart
 */
import 'dart:async';

import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/model/advertisements/ad_resp_model.dart';
import 'package:xhs_app/model/user/user_info_model.dart';
import 'package:xhs_app/utils/consts.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum StorageKey {
  aiLink('aiLink'),
  deviceInfo('deviceInfo'),
  //上次成功的域名
  lastSuccessDomain('last_success_domain'),
  deviceId('deviceId'),
  token('token'),
  imageDomain('imageDomain'),
  //搜索记录
  history('history'),

  //我的页面 是否第一次
  isMineFirst('isMineFirst'),

  //应用锁开关
  isAppLock('isAppLock'),

  //设置图标开关
  isChangeAppIcon('isChangeAppIcon'),

  //密码锁
  lockPassword('lockPassword'),

  //注册密码
  registPassword('registPassword'),

  //资源搜索记录
  resourceSearchHistory('resourceSearchHistory'),

  //广告
  advertisement('advertisement'),
  //在线客服地址
  online('online'),
  //用户信息
  userInfo('userInfo'),
  m3u8RecordNextId('m3u8RecordNextId'),
  //搜索记录
  searchHistory('searchHistory'),

  ///精选搜索记录
  searchSelectionHistory('searchSelectionHistory'),
  ;

  const StorageKey(this.name);

  final String name;

  @override
  String toString() => name;
}

class StorageService extends GetxService {
  late final Box _box;

  Future<bool> deleteBox(String boxName) async {
    try {
      await Hive.deleteBoxFromDisk(boxName);
      return true; // 删除成功
    } catch (e) {
      return false; // 删除失败
    }
  }

  ///清空本地存储数据
  Future<bool> clearLocal() async {
    try {
      await Hive.deleteFromDisk();
      return true; // 删除成功
    } catch (e) {
      return false; // 删除失败
    }
  }

  /// 初始化 StorageService 工具类, 并返回类实例
  Future<StorageService> init() async {
    /// Hive 轻量级的NoSQL数据库,一种快速,没有依赖关系的键值对存储数据库,适合移动应用的离线数据存储.
    /// hive_flutter 基于Hive数据库与Flutter集成, 在Flutter 中使用 Hive 数据库
    /// 功能点:
    /// 与Flutter集成:
    ///   可以在 Widgets 中响应式数据处理
    /// Box存储:
    ///   Hive 使用称为Box的数据结构来存储数据,Box 类似一个集合或表格,可以存储多个键值对.
    /// 支持自动类型适配器:
    ///   支持自定义对象的持久化存储,只需要实现 TypeAdapter
    await Hive.initFlutter();

    /// openBox: 是Hive 数据库中用于打开或创建一个存储容器(Box)的方法.
    /// 返回类型 Future<Box<E>> 所以可以使用 await
    /// 返回的Box 就类似一个键值对集合.
    /// 参数:
    /// name String--
    /// 必填, box的名称,必须唯一.如果没有,openBox会即时使用 name 创建一个Box,并返回.
    /// encryptionCipher HiveCipher --
    /// 可选.
    /// 如果希望对Box中的数据进行加密,可以传入一个 HiveCipher 类型的对象来加解密数据.
    /// 下面的代码就是使用了加密,自定义了密钥
    /// crashRecovery bool --
    /// 可选, 默认为true
    /// true: 在应用程序崩溃或异常退出的情况下,Hive会尝试恢复Box的数据.
    /// false: 禁用尝试恢复功能,可能会提高性能,但是可能会导致数据丢失.
    /// path String --
    /// 可续.
    /// 指定Box的存储路径.
    /// 如果不提供,Hive会将Box存储在应用程序的默认数据目录下.
    /// 使用此参数,可以自定义存储路径.
    _box = await Hive.openBox(
      Consts.generalBoxName,
      encryptionCipher: HiveAesCipher(Consts.generalBoxKey),
    );

    return this;
  }

  T? _read<T>(StorageKey key) => _box.get(key.name);

  Future<void> _write<T>(StorageKey key, T value) => _box.put(key.name, value);

  Future<void> _delete(StorageKey key) => _box.delete(key.name);

  // deviceId
  String? get deviceId => _read(StorageKey.deviceId);

  Future<void> setDeviceId(String v) => _write(StorageKey.deviceId, v);

  // token
  String? get token => _read(StorageKey.token);

  Future<void> setToken(String v) => _write(StorageKey.token, v);

  Future<void> deleteToken() => _delete(StorageKey.token);

// 图片域名
  String? get imgDomain => _read(StorageKey.imageDomain);

  Future<void> setDomain(String v) => _write(StorageKey.imageDomain, v);

  Future<void> deleteImageDomain() => _delete(StorageKey.imageDomain);

  ///ads
  List<AdInfoModel>? get ads {
    final jsons = _read(StorageKey.advertisement);
    if (jsons == null) return null;
    if (jsons is List<Map>) {
      final items = jsons
          .map((e) => AdInfoModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return items;
    }
    return null;
  }

  Future<void> saveAds(List<AdInfoModel> items) async {
    await _write(
        StorageKey.advertisement, items.map((e) => e.toJson()).toList());
  }

  ///在线客服
  String? get onLine => _read(StorageKey.online);

  Future<void> saveOnLine(String value) async {
    await _write(StorageKey.online, value);
  }

  dynamic get userInfo => _read(StorageKey.userInfo);

  Future<void> saveUserInfo(UserInfo v) async {
    final domain = v.imgDomain ?? '';
    final token = v.token ?? '';
    //保存图片域名
    if (domain.isNotEmpty) {
      await setDomain(v.imgDomain ?? '');
    }
    //保存token
    if (token.isNotEmpty) {
      await setToken(token);
    }
    await _write(StorageKey.userInfo, v.toJson());
  }

  //history
  List<String> get history => _read(StorageKey.history) ?? [];

  Future<void> setHistory(String v) async {
    if (!history.contains(v)) {
      history.insert(0, v);
    }
    await _write(StorageKey.history, history);
  }

  Future<void> deleteHistory() => _delete(StorageKey.history);

  //域名列表domains
  String get getLastSuccessDomain => _read(StorageKey.lastSuccessDomain) ?? "";

  Future<void> setLastSuccessDomain(String v) =>
      _write(StorageKey.lastSuccessDomain, v);

  /// 资源搜索记录
  List<String> get resourceSearchHistory =>
      _read(StorageKey.resourceSearchHistory) ?? [];

  /// 资源搜索记录
  Future<void> setResourceSearchHistory(String v) async {
    if (!resourceSearchHistory.contains(v)) {
      resourceSearchHistory.insert(0, v);
    }
    await _write(StorageKey.resourceSearchHistory, resourceSearchHistory);
  }

  /// 资源搜索记录
  Future<void> deleteResourceSearchHistory() =>
      _delete(StorageKey.resourceSearchHistory);

  ///我的页面是否第一次的字段
  bool get isMineFirst => _read(StorageKey.isMineFirst) ?? false;

  Future<void> saveMineFirst(bool v) async {
    await _write(StorageKey.isMineFirst, v);
  }

  ///设置桌面图标的字段
  bool get isChangeAppIcon => _read(StorageKey.isChangeAppIcon) ?? false;

  Future<void> saveChangeAppIcon(bool v) async {
    await _write(StorageKey.isChangeAppIcon, v);
  }

  ///设置密码
  String get lockPassword => _read(StorageKey.lockPassword) ?? '';

  Future<void> savelockPassword(String v) async {
    await _write(StorageKey.lockPassword, v);
  }

  ///注册密码
  String get registerPassword => _read(StorageKey.registPassword) ?? '';

  Future<void> saveRegisterPassword(String v) async {
    await _write(StorageKey.registPassword, v);
  }

  ///搜索记录
  List<String> get searchHistory => _read(StorageKey.searchHistory) ?? [];

  Future<void> saveSearchHistory(List<String> v) async {
    return _write(StorageKey.searchHistory, v);
  }

  ///精选搜索记录
  List<String> get searchSelectionHistory =>
      _read(StorageKey.searchSelectionHistory) ?? [];

  Future<void> saveSearchSelectionHistory(List<String> v) async {
    return _write(StorageKey.searchSelectionHistory, v);
  }

  // deviceInfo
  String? get deviceInfo => _read(StorageKey.deviceInfo);

  Future<void> updateDeviceInfo(String v) => _write(StorageKey.deviceInfo, v);

// ai域名
  String? get aiLink => _read(StorageKey.aiLink);

  Future<void> updateAiLink(String v) => _write(StorageKey.aiLink, v);
}
