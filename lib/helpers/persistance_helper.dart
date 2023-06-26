import 'dart:io';

void addPersistenceHelper() {
  final persistenceHelperAbstractFile = File(
      "${Directory.current.path}/lib/helpers/persistence/persistence_helper.dart");

  final persistenceHelperAbstractFileImpl = File(
      "${Directory.current.path}/lib/helpers/persistence/persistence_helper_imp.dart");

  if (!persistenceHelperAbstractFile.existsSync()) {
    persistenceHelperAbstractFile.createSync(recursive: true);
  }

  if (!persistenceHelperAbstractFileImpl.existsSync()) {
    persistenceHelperAbstractFileImpl.createSync(recursive: true);
  }

  persistenceHelperAbstractFile.writeAsStringSync(_helperContents);
  persistenceHelperAbstractFileImpl.writeAsStringSync(_helperImpContents);
}

const _helperContents = '''
abstract class PersistenceHelper {
  /// [Iitialize the persistence helper]
  Future<void> init();

  /// [Save the data]
  Future<void> saveBool(String key, bool value);

  /// [Save the String]
  Future<void> saveString(String key, String value);

  /// [Save the num]
  Future<void> saveNum(String key, num value);

  /// [Get the bool]
  Future<bool?> getBool(String key);

  /// [Get the String]
  Future<String?> getString(String key);

  /// [Get the num]
  Future<num?> getNum(String key);

  /// [Delete the data]
  Future<void> delete(String key);
}

''';

const _helperImpContents = '''
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'persistence_helper.dart';

@Singleton(as: PersistenceHelper)
class PersistenceHelperImpl implements PersistenceHelper {
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

''';
