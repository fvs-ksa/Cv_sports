import 'package:cv_sports/Pages/auth/Login_Screen.dart';
import 'package:flutter/material.dart';




class HaveAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(" لدي حساب ؟  "),
        SizedBox(
          width: 5,
        ),
        InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            },
            child: Text(
              "تسجيل الدخول",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
            //    color: Color(0xffCE5EEF),
                decoration: TextDecoration.underline,

              ),
            ))
      ],
    );
  }
}
