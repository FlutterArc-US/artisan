import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'persistance_helper.dart';

@Singleton(as: PersistanceHelper)
class PersistanceHelperImpl implements PersistanceHelper {
  late final Box _settingsBox;

  final _settingBoxName = 'settings';

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    _settingsBox = await Hive.openBox(_settingBoxName);
  }

  @override
  Future<bool?> getBool(String key) async {
    final bool? value = await _settingsBox.get(key);
    return value;
  }

  @override
  Future<num?> getNum(String key) async {
    final num? value = await _settingsBox.get(key);
    return value;
  }

  @override
  Future<String?> getString(String key) async {
    final String? value = await _settingsBox.get(key);
    return value;
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _settingsBox.put(key, value);
  }

  @override
  Future<void> saveNum(String key, num value) async {
    await _settingsBox.put(key, value);
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _settingsBox.put(key, value);
  }

  @override
  Future<void> delete(String key) async {
    await _settingsBox.delete(key);
  }
}
