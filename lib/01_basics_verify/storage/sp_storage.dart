import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String kGuessKey = 'guess-config';
const String kMuYuKey = 'muyu-config';

/// 首选项-存储
class SpStorage {
  //私有化构造
  SpStorage._();

  static SpStorage? _storage;

  /// 获取实例-单例模式访问对象和存储配置
  static SpStorage get instance {
    _storage = _storage ?? SpStorage._();
    return _storage!;
  }

  /// 初始化存储配置
  SharedPreferences? _sp;
  Future<void> initSpWhenNull() async {
    if (_sp != null) return;
    _sp = _sp ?? await SharedPreferences.getInstance();
  }

  /// 存储猜数字配置
  Future<bool> saveGuessConfig({required bool guessing, required int value}) async {
    await initSpWhenNull();
    String content = json.encode({'guessing': guessing, 'value': value});
    return _sp!.setString(kGuessKey, content);
  }

  /// 读取猜数字配置
  Future<Map<String, dynamic>> readGuessConfig() async {
    await initSpWhenNull();
    String content = _sp!.getString(kGuessKey) ?? "{}";
    return json.decode(content);
  }

  ///木鱼配置
  Future<bool> saveMuYuConfig(
      {required int counter, required int activeImageIndex, required int activeAudioIndex}) async {
    await initSpWhenNull();
    String content = json.encode({
      'counter': counter,
      'activeImageIndex': activeImageIndex,
      'activeAudioIndex': activeAudioIndex,
    });
    return _sp!.setString(kMuYuKey, content);
  }

  Future<Map<String, dynamic>> readMuYuConfig() async {
    await initSpWhenNull();
    String content = _sp!.getString(kMuYuKey) ?? "{}";
    return json.decode(content);
  }
}
