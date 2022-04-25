import 'package:cv_sports/Pages/auth/SignUp_Screen.dart';
import 'package:flutter/material.dart';




class NoHaveAccount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(" ليس لديك حساب ؟ "),
        SizedBox(
          width: 5,
        ),
        InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return SignUpScreen();
              }));
            },
            child: Text(
              "سجل",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              //  color: Color(0xffCE5EEF),
                decoration: TextDecoration.underline,

              ),
            ))
      ],
    );
  }
}
