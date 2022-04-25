import 'dart:async';
import 'package:cv_sports/Widgets/Auth/PinCodeScreen/PinCodeInput.dart';
import 'package:cv_sports/Widgets/Auth/PinCodeScreen/TextSentOtpAgain.dart';
import 'package:cv_sports/Widgets/Auth/PinCodeScreen/TextShowTimer.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart' as esay;

import 'ComplateProfile_Screen.dart';



class PinCode extends StatefulWidget {
  String phoneUser;
  int timerStart;
  String nameUser;
  bool isLogin;


  PinCode(
      {@required this.phoneUser,
      @required this.timerStart,

      this.nameUser,
      @required this.isLogin});

  @override
  _PinCodeState createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  TextEditingController controllerPinText = TextEditingController();
  Timer _timer;
  int timerCount;

//==================**** Start Data *** ==============================

  @override
  void initState() {
    timerCount = widget.timerStart;
    print("timerCount = " + timerCount.toString());
    startTimer();
    super.initState();
  }

//================== Fun Start time ==============================

  void startTimer() {
    print("Run");
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerCount < 1) {
          //  timer.cancel();
          _timer.cancel();
        } else {
          setState(() {
            timerCount = timerCount - 1;
          });
        }
      },
    );
  }

//=========================== ****** Main Build ******* ========================================

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _timer.cancel();
        Navigator.of(context).pop();
        return null;
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OTP",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 15,
            ),
            PinCodeInput(
              controllerPinText: controllerPinText,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            BottomApp(
              title: "تحقق",
              functionButton: () {
                _timer.cancel();


                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ComplateProfileScreen(), //Register //LogIn
                  ));


              },
              setWidth: .8,
              oneColor: Colors.black,
              twoColor: Colors.black,
              colorTitle: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            (timerCount > 1)
                ? TextShowTimer(
                    timerCount: timerCount,
                  )
                : TextSentOtpAgain(
                    FunctionSentSms: () => FunctionSentSms(),
                  )
          ],
        ),
      ),
    );
  }

//========================= Row _ Sent Otp Again ========================

  void FunctionSentSms() async {
    setState(() {
      timerCount = widget.timerStart;
    });
    startTimer();
    controllerPinText.clear();
  }



//========================= show Error Dialog========================
  showErrorDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: new Text(
                "youEnteredWrongNumber".tr(),
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
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
                        "okay".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
