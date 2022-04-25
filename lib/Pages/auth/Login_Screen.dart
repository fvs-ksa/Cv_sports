import 'dart:io';

import 'package:cv_sports/AuthFuntions/AppleSignInProvider.dart';
import 'package:cv_sports/AuthFuntions/FacebookSignInProvider.dart';
import 'package:cv_sports/AuthFuntions/GoogleSignInProvider.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:cv_sports/splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode touchFocusPassword = new FocusNode();

  FocusNode touchFocusText = new FocusNode();

  bool loading = false;

  final controllerInputPassword = TextEditingController();

  final nameUserController = TextEditingController();

  void unFocus() {
    touchFocusText.unfocus();
    touchFocusPassword.unfocus();
  }

  @override
  Widget build(BuildContext context) {
// "assets/images/login.png",
    return loading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            )),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              fit: StackFit.expand,
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  "assets/images/login.png",
                  alignment: Alignment.topRight,
                  scale: 1.2,
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * .18,
                  child: Column(
                    children: [
                      SignInButton(
                          buttonSize: ButtonSize.medium,
                          imagePosition: ImagePosition.right,
                          buttonType: ButtonType.google,
                          padding: 5,
                          width: MediaQuery.of(context).size.width * .55,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });

                            await GoogleSignInProvider()
                                .signGoogleFun(context: context)
                                .whenComplete(() {
                              setState(() {
                                loading = false;
                              });
                            });
                          }),
                      SizedBox(
                        height: 10,
                      ),
/*
                      Platform.isIOS
                          ? SignInButton(
                              buttonSize: ButtonSize.medium,
                              imagePosition: ImagePosition.right,
                              buttonType: ButtonType.apple,
                              width: MediaQuery.of(context).size.width * .55,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              
                              onPressed: () async {
                                if (Platform.isIOS) {
                                  await AppleLogin()
                                      .signInWithApple(context: context)
                                      .then((value) {
                                    if (value == null) {
                                      BotToast.showText(
                                        text:
                                            "Not available, must be at least 0.ios 13"
                                                .tr(),
                                        contentColor: Colors.blue,
                                      );
                                    } else if (value == true) {
                                      // Navigator.of(context)
                                      //     .pushReplacement(MaterialPageRoute(builder: (context) {
                                      //   return MainScreen();
                                      // }));
                                    }
                                  });
                                } else {
                                  BotToast.showText(
                                    text: "You must have an iPhone".tr(),
                                    contentColor: Colors.blue,
                                  );
                                }
                              }
                              )
                              
                          : Container(),
                      Platform.isIOS
                          ? SizedBox(
                              height: 10,
                            )
                            
                          : Container(),
                          */
                      SignInButton(
                          buttonSize: ButtonSize.medium,
                          buttonType: ButtonType.facebook,
                          imagePosition: ImagePosition.right,
                          width: MediaQuery.of(context).size.width * .55,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          
                          onPressed: () async {
                            await FacebookSignInProvider()
                                .signFacebookFun(context: context);
                            // BotToast.showText(
                            //   text: "جارى التطوير",
                            //   contentColor: Colors.blue,
                            // );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      changeLanguage(context));
                            },
                            child: Text(
                              "Language",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return MainScreen();
                              }));
                            },
                            child: Text("Skip", style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Widget changeLanguage(context) {
    return CupertinoActionSheet(
      title: Text('Language'),
      message: Text('Choose your language'),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('English'),
          onPressed: () {
            EasyLocalization.of(context).locale =
                EasyLocalization.of(context).supportedLocales[0];

            BaseUrlApi.lang = EasyLocalization.of(context).locale.languageCode;
            print(
                "Setting " + EasyLocalization.of(context).locale.languageCode);

            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ));
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Arabic'),
          onPressed: () {
            EasyLocalization.of(context).locale =
                EasyLocalization.of(context).supportedLocales[1];
            BaseUrlApi.lang = EasyLocalization.of(context).locale.languageCode;
            print(EasyLocalization.of(context).locale.languageCode);

            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ));
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Español'),
          onPressed: () {
            EasyLocalization.of(context).locale =
                EasyLocalization.of(context).supportedLocales[2];
            BaseUrlApi.lang = EasyLocalization.of(context).locale.languageCode;
            print(EasyLocalization.of(context).locale.languageCode);

            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ));
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Português'),
          onPressed: () {
            EasyLocalization.of(context).locale =
                EasyLocalization.of(context).supportedLocales[3];
            BaseUrlApi.lang = EasyLocalization.of(context).locale.languageCode;
            print(EasyLocalization.of(context).locale.languageCode);

            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ));
          },
        ),
        CupertinoActionSheetAction(
          child: Text('français'),
          onPressed: () {
            EasyLocalization.of(context).locale =
                EasyLocalization.of(context).supportedLocales[4];
            BaseUrlApi.lang = EasyLocalization.of(context).locale.languageCode;
            print(EasyLocalization.of(context).locale.languageCode);

            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ));
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('cancel'),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    );
  }
}
