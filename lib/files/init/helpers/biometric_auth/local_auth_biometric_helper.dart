import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

import 'biometric_auth.dart';

@LazySingleton(as: BiometricAuth)
class LocalAuthBiometricHelper implements BiometricAuth {
  LocalAuthentication auth = LocalAuthentication();

  @override
  Future<bool> authenticate() async {
    return await auth.authenticate(
      localizedReason: 'Please scan your fingerprint to authenticate',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
        useErrorDialogs: true,
      ),
    );
  }

  @override
  Future<bool> isAuthSupported() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    return canAuthenticate;
  }
}
