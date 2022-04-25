import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:cv_sports/Widgets/Auth/HaveAccount.dart';
import 'package:cv_sports/Widgets/Globle/InputFieldMake.dart';
import 'package:cv_sports/Widgets/Globle/InputImageCircle.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:easy_localization/easy_localization.dart' as easy;

import 'ComplateProfile_Screen.dart';
import 'PinCodeScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController controllerName = TextEditingController();
  FocusNode focusName = new FocusNode();

  TextEditingController controllerEmail = TextEditingController();
  FocusNode focusEmail = new FocusNode();

  TextEditingController controllerPassword = TextEditingController();
  FocusNode focusPassword = new FocusNode();

  void unFocus() {
    focusName.unfocus();
    focusEmail.unfocus();
    focusPassword.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "signup".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //    InputImage(Mediawidth, Mediaheight),
              InputImageCircle(
                setIcon: FontAwesomeIcons.image,
                setColorBackground: Color(0xffe7f0ff),
                setColorIcon: Color(0xff0064ff),
                sizeIcon: 60,
                setWidth: .4,
                setHeight: .22,
                functionButton: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              InputFieldMake(
                title: "الاسم بالكامل",
                inputController: controllerName,
                touchFocus: focusName,
                iconInput: Icons.person,
                validatorInput: (input) {
                  if (input.trim().length <= 0) {
                    return "من فضلك ضع اسمك";
                  } else if (input.trim().length <= 5) {
                    return "اسمك لا يجب ان يقل عن 5 حروف";
                  }
                  return null;
                },
              ),
              InputFieldMake(
                title: "البريد الالكترونى",
                inputController: controllerEmail,
                touchFocus: focusEmail,
                iconInput: Icons.email,
                validatorInput: (input) {
                  if (input.trim().length <= 0) {
                    return "من فضلك ضع بريدك";
                  } else if (input.trim().length <= 5) {
                    return "بريدك لا يجب ان يقل عن 5 حروف";
                  }
                  return null;
                },
              ),
              InputFieldMake(
                title: "رقم السرى",
                hideText: true,
                inputController: controllerPassword,
                touchFocus: focusPassword,
                iconInput: Icons.lock,
                validatorInput: (input) {
                  if (input.trim().length <= 0) {
                    return "من فضلك ضع رقم السرى";
                  } else if (input.trim().length <= 6) {
                    return "رقم السرى لا يجب ان يقل عن 6 حروف";
                  }
                  return null;
                },
              ),
              BottomApp(
                title: "SignUpBtn".tr(),
                setCircular: 10,
                functionButton: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                    return PinCode(isLogin: false, phoneUser: "123456789", timerStart: 60 , nameUser: "Medo",);
                  }));
                },
                setWidth: .8,
                oneColor: Color(0xff2C2B53),
                twoColor: Color(0xff2C2B53),
                colorTitle: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              HaveAccount()
            ],
          ),
        ),
      ),
    );
  }
}
