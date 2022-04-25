
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class PinCodeInput extends StatelessWidget {
  TextEditingController controllerPinText = TextEditingController();


  PinCodeInput({ @required this.controllerPinText});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:TextDirection.ltr ,
      child: PinCodeTextField(
        autoDisposeControllers: false,
        appContext: context,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        length: 4,
        obscureText: false,
        cursorColor: Colors.white,

        animationType: AnimationType.fade,
        pinTheme: PinTheme(

            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 60,
            fieldWidth: 60,
            activeFillColor: Color(0xff494861),
            activeColor: Color(0xff494861),
            inactiveColor: Color(0xff494861),
            inactiveFillColor: Color(0xff494861),
            disabledColor: Color(0xff494861)

        ),
        animationDuration: Duration(milliseconds: 300),
        keyboardType: TextInputType.phone,
        controller: controllerPinText,
     //   enableActiveFill: true,
        onCompleted: (v) {
          controllerPinText.text = v;
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }
}
