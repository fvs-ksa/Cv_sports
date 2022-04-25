
import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Pages/auth/ComplateProfile_Screen.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Services/AllServices/serviceSignFacebook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signFacebookFun({@required BuildContext context}) async {
    try{
      AccessToken accessToken = await FacebookAuth.instance.login(permissions: [
        'email', 'public_profile'
      ]);
      // FacebookLoginResult result;
      // final FacebookAccessToken accessToken = result.accessToken;

      AuthCredential credential =
      FacebookAuthProvider.credential(accessToken.token);

      var a = await _firebaseAuth.signInWithCredential(credential);
      print("Go");
      User user = a.user;
      print(user.toString());

      try {

        await ServiceSignFacebook()
            .postSignFacebook(
            accessToken: accessToken.token, facebook_id:  accessToken.userId)
            .then((v) {

          print("accessToken = "+ accessToken.token);
          print("userId = +"+ accessToken.userId);


          print("Go To FaceBook");
          print(v.statusCode);
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
        print("Error FaceBook in Servers");
        print(e);
      }

    }catch(e){
      BotToast.showText(
        text: "يوجد مشكلة فى السرفير , جارى الصيانة",
        contentColor: Colors.blue,
      );
      print("Error FaceBook" +e.toString());
    }





  }

  Future signOutWithFacebook() async {
   await _firebaseAuth.signOut();
    print("User Out");
  }
}
