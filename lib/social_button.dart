import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  final Color color;
  final String text;
  final IconData iconBtn;
  final Function function;
  final Gradient gradient;

  SocialButton(
      {this.color, this.text, this.iconBtn, this.function, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            gradient: gradient,
            color: color,
            borderRadius: BorderRadius.circular(25),
          ),
          height: MediaQuery.of(context).size.height * 0.065,
          width: MediaQuery.of(context).size.height * 0.65,
          child: Row(
            children: [
              FaIcon(
                iconBtn,
                color: Colors.white,
              ),
              SizedBox(
                width: 30,
              ),
              Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        onTap: function as void Function(),
      ),
    );
  }
}
