import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'google_auth.dart';

@LazySingleton(as: GoogleAuth)
class GoogleAuthHelper extends GoogleAuth {
  @override
  Future<String?> googleSignIn() async {
    GoogleSignIn signIn = GoogleSignIn();

    GoogleSignInAccount? googleSignInAccount = await signIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    // final AuthCredential credential = GoogleAuthProvider.credential(
    //   accessToken: googleSignInAuthentication?.accessToken,
    //   idToken: googleSignInAuthentication?.idToken,
    // );
    //
    // var result = await auth.signInWithCredential(credential);
    // User? user = result.user;

    final email = googleSignInAccount?.email;
    log("get email $email");
    return email;
  }
}
