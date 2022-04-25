import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'Pages/auth/Login_Screen.dart';
import 'Pages/home/MainScreen.dart';
import 'Services/baseUrlApi/baseUrlApi.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences saveTokenUser;

  getUserLocation() async {
    saveTokenUser = await SharedPreferences.getInstance();

    Timer(
      Duration(seconds: 3),
      () {
        if (saveTokenUser.getString("TokenUserLoad") == null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginScreen(), //Register //LogIn
          ));
        } else {
          print("TokenUserLoad = " + saveTokenUser.getString("TokenUserLoad"));
          print(
              "IdUserLoad = " + saveTokenUser.getInt("IdUserLoad").toString());
          BaseUrlApi.tokenUser = saveTokenUser.getString("TokenUserLoad");

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
        }
      },
    );
    BaseUrlApi.lang = Localizations.localeOf(context).languageCode;
  }

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
          // alignment: Alignment.center,
          width: double.infinity,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
          child: Image.asset(
            "assets/images/splash.png",
            fit: BoxFit.fill,
          )),
    );
  }
}
