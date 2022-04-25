import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/AuthFuntions/FacebookSignInProvider.dart';
import 'package:cv_sports/AuthFuntions/GoogleSignInProvider.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/Category/ScreensAddNewPerson/AddNewClubScreen.dart';
import 'package:cv_sports/Pages/Category/ScreensAddNewPerson/AddNewPlayerScreen.dart';
import 'package:cv_sports/Pages/Category/ScreensAddNewPerson/AddnewExtraScreen.dart';
import 'package:cv_sports/Pages/PagesSetting/PageAboutUs.dart';
import 'package:cv_sports/Pages/PagesSetting/PageContactUs.dart';
import 'package:cv_sports/Pages/PagesSetting/PageTermsAndConditions.dart';
import 'package:cv_sports/Pages/auth/ComplateProfile_Screen.dart';
import 'package:cv_sports/Pages/auth/Login_Screen.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/splash_screen.dart';

import '../../ProviderAll.dart';
import 'MainScreen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // bool SwitchValue = false;
  Users informationProfile;

  @override
  Widget build(BuildContext context) {
    informationProfile =
        Provider.of<InformationMyProfileProvider>(context).listInformationUser;
    return Scaffold(
      backgroundColor: Color(0xffF9FAFF),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffF9FAFF),
        elevation: 0,
        title: Text(
          "Settings".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        //  margin:EdgeInsets.symmetric(horizontal: 20) ,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Personal settings".tr(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 0)),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        InkWell(
                          child: ListTile(
                            trailing: Icon(
                                (EasyLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? Icons.arrow_back_outlined
                                    : Icons.arrow_forward_outlined),
                                color: Color(0xffFB9800)),
                            title: Text(
                              "Edit profile".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            leading: FaIcon(
                              FontAwesomeIcons.userAlt,
                              size: 18,
                              color: Color(0xffFB9800),
                            ),
                          ),
                          onTap: () {
                            if (BaseUrlApi.tokenUser == null) {
                              BotToast.showText(
                                text: "The application must be registered first"
                                    .tr(),
                                contentColor: Colors.blue,
                              );
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ComplateProfileScreen(
                                  titleAppbarChange: true,
                                ), //Register //LogIn
                              ));
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (BaseUrlApi.tokenUser == null) {
                              BotToast.showText(
                                text: "The application must be registered first"
                                    .tr(),
                                contentColor: Colors.blue,
                              );
                            } else if (informationProfile.role == null) {
                              BotToast.showText(
                                text:
                                    "Please upgrade your account to Specialization"
                                        .tr(),
                                contentColor: Colors.blue,
                              );
                            } else {
                              if (informationProfile.role.profileType.index ==
                                  2) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AddNewPlayerScreen(
                                      setRoleId: informationProfile.role.name,
                                      informationProfile: informationProfile);
                                }));
                              } else if (informationProfile
                                      .role.profileType.index ==
                                  1) {
                                //MakeNewClubScreen
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AddNewClubScreen(
                                      setRoleId: informationProfile.role.name,
                                      informationProfile: informationProfile);
                                }));
                              } else {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AddnewExtraScreen(
                                    setRoleId: informationProfile.role.name,
                                    informationProfile: informationProfile,
                                  );
                                }));
                              }
                            }
                          },
                          child: ListTile(
                            trailing: Icon(
                                (EasyLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? Icons.arrow_back_outlined
                                    : Icons.arrow_forward_outlined),
                                color: Color(0xffFB9800)),
                            title: Text(
                              "Specialization Adjustment".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            leading: FaIcon(
                              FontAwesomeIcons.userEdit,
                              size: 18,
                              color: Color(0xffFB9800),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        InkWell(
                          onTap: () => showExitAuthDialog(),
                          child: ListTile(
                            trailing: Icon(
                                (EasyLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? Icons.arrow_back_outlined
                                    : Icons.arrow_forward_outlined),
                                color: Color(0xffFB9800)),
                            title: Text(
                              "Log out".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            leading: FaIcon(
                              FontAwesomeIcons.signOutAlt,
                              size: 18,
                              color: Color(0xffFB9800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "General settings".tr(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 0)),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) =>
                                    changeLanguage(context));
                          },
                          child: ListTile(
                            trailing: Icon(
                                (EasyLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? Icons.arrow_back_outlined
                                    : Icons.arrow_forward_outlined),
                                color: Color(0xffFB9800)),
                            title: Text(
                              "The language".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            leading: FaIcon(
                              FontAwesomeIcons.globe,
                              size: 18,
                              color: Color(0xffFB9800),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        // ListTile(
                        //   trailing: Switch(
                        //     value: SwitchValue,
                        //     activeColor: Color(0xff34C759),
                        //     onChanged: (v) {
                        //       if( BaseUrlApi.tokenUser ==null){
                        //         BotToast.showText(
                        //           text: "The application must be registered first" .tr(),
                        //           contentColor: Colors.blue,
                        //         );
                        //       }else{
                        //         setState(() {
                        //           SwitchValue = v;
                        //         });
                        //       }
                        //
                        //     },
                        //   ),
                        //   title: Text(
                        //     "Notifications".tr(),
                        //     style: TextStyle(
                        //         fontSize: 18, color: Colors.grey.shade700),
                        //   ),
                        //   leading: FaIcon(
                        //     FontAwesomeIcons.bell,
                        //     size: 18,
                        //     color: Color(0xffFB9800),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8),
                        //   child: Divider(
                        //     thickness: 2,
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PageContactUs(), //Register //LogIn
                            ));
                          },
                          child: ListTile(
                            trailing: Icon(
                                (EasyLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? Icons.arrow_back_outlined
                                    : Icons.arrow_forward_outlined),
                                color: Color(0xffFB9800)),
                            title: Text(
                              "call us".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            leading: FaIcon(
                              FontAwesomeIcons.phone,
                              size: 18,
                              color: Color(0xffFB9800),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PageAboutUs(), //Register //LogIn
                            ));
                          },
                          child: ListTile(
                            trailing: Icon(
                                (EasyLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? Icons.arrow_back_outlined
                                    : Icons.arrow_forward_outlined),
                                color: Color(0xffFB9800)),
                            title: Text(
                              "About Application".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            leading: FaIcon(
                              FontAwesomeIcons.info,
                              size: 18,
                              color: Color(0xffFB9800),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        // ListTile(
                        //   trailing: Icon(( EasyLocalization.of(context).locale .languageCode =="ar" ?     Icons.arrow_back_outlined:   Icons.arrow_forward_outlined),
                        //       color: Color(0xffFB9800)),
                        //   title: Text(
                        //     "Share the app".tr(),
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       color: Colors.grey.shade700,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                        //   leading: FaIcon(
                        //     FontAwesomeIcons.shareAlt,
                        //     size: 18,
                        //     color: Color(0xffFB9800),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8),
                        //   child: Divider(
                        //     thickness: 2,
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PageTermsAndConditions(), //Register //LogIn
                            ));
                          },
                          child: ListTile(
                            trailing: Icon(
                                (EasyLocalization.of(context)
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? Icons.arrow_back_outlined
                                    : Icons.arrow_forward_outlined),
                                color: Color(0xffFB9800)),
                            title: Text(
                              "Terms and Conditions".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            leading: FaIcon(
                              FontAwesomeIcons.scroll,
                              size: 18,
                              color: Color(0xffFB9800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  showExitAuthDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: new Text(
                "Log out".tr(),
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Text(
                    "Are you sure you are logged out of the app?".tr(),
                    style: TextStyle(color: Color(0xff8E93A2), fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          SharedPreferences saveTokenUser =
                              await SharedPreferences.getInstance();

                          BaseUrlApi.tokenUser = null;
                          saveTokenUser.clear();
                          GoogleSignInProvider().signOutWithGoogle();
                          FacebookSignInProvider().signOutWithFacebook();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          margin: const EdgeInsets.only(right: 2, left: 2),
                          decoration: BoxDecoration(
                              color: Color(0xff222B45),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          width: MediaQuery.of(context).size.width * 0.28,
                          alignment: Alignment.center,
                          child: Text(
                            "Log out".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          margin: const EdgeInsets.only(right: 2, left: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey)),
                          width: MediaQuery.of(context).size.width * 0.28,
                          alignment: Alignment.center,
                          child: Text(
                            "Retreat".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
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
