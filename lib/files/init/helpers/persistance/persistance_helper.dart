abstract class PersistanceHelper {
  /// [Iitialize the persistance helper]
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
