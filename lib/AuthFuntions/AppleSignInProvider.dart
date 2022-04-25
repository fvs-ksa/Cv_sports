/*
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Pages/auth/ComplateProfile_Screen.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Services/AllServices/ServiceAppleSign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppleLogin{
  final _firebaseAuth = FirebaseAuth.instance;
  Future signInWithApple({@required BuildContext context}) async {

    if (!await AppleSignIn.isAvailable()) {

      print("Error");
      return null; //Break from the program
    }


    // 1. perform the sign-in request
    AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName ,Scope.rawValue("name")])
    ]);

    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),

        );

        print("idToken = "+ credential.idToken);
        print("accessToken = "+ credential.accessToken);

        final authResult = await _firebaseAuth.signInWithCredential(credential);

        final firebaseUser = authResult.user;



        print(firebaseUser);
        await ServiceAppleSign()
            .postAppleSign(
            accessToken: credential.accessToken, identityToken: credential.idToken)
            .then((v) {
          print("Go To ServiceSignGoogle");
          if (v.data["firstTimeLogin"] == true) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ComplateProfileScreen(),
            ));
          } else if (v.data["firstTimeLogin"] == false) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return MainScreen();
            }));
          } else {
            BotToast.showText(
              text: "يوجد مشكلة فى السرفير , جارى الصيانة",
              contentColor: Colors.blue,
            );
          }
        });
        return true;
      case AuthorizationStatus.error:
        print("Sign in failed: ${result.error.localizedDescription}");
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }

  Future signOutWithApple() async {
    await _firebaseAuth.signOut();
    print("User Out");
  }
}

*/