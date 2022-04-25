import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Pages/auth/ComplateProfile_Screen.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Services/AllServices/serviceSignGoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future signGoogleFun({@required BuildContext context}) async {

      //trigger Authentication Flow
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      //   print( "googleSignInAccount = " +googleSignInAccount.toString());
      if (googleSignInAccount != null) {
        //Obtaining auth details from the request
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        //      print("googleSignInAuthentication = "+ googleSignInAuthentication.toString());

        //Creating new credential
        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        //         print("credential = "+credential.toString());

        print("credential accessToken = " + credential.accessToken);
        User user = (await _firebaseAuth.signInWithCredential(credential)).user;
        print("User = " + user.providerData.toString());
    try {
      await ServiceSignGoogle()
          .postSignGoogle(
          accessToken: credential.accessToken, userName: user.displayName)
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
    }catch (e) {
      print("Error ServiceSignGoogle in Servers");
      print(e);
    }

      }

  }

  Future signOutWithGoogle() async {
    await _googleSignIn.signOut();
    print("User Out");
  }
}
