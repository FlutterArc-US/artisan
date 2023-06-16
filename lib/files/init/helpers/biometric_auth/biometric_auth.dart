abstract class BiometricAuth {
  Future<bool> isAuthSupported();

  Future<bool> authenticate();
}
