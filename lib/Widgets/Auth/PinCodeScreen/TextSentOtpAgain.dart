import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as esay;

class TextSentOtpAgain extends StatelessWidget {

  Function FunctionSentSms;

  TextSentOtpAgain({@required this.FunctionSentSms});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("didn'tRecieveCode".tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
        InkWell(
          onTap: FunctionSentSms,
          child: Text(
            "resendItAgain".tr(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                textBaseline: TextBaseline.alphabetic,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
