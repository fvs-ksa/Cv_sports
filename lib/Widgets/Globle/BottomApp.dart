import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomApp extends StatelessWidget {
  String title;
  var colorTitle;
  var colorIcon;
  Function functionButton;
  var iconAdd;

  var oneColor;
  var twoColor;
  double setWidth;
  double setHeight;
  double setCircular;
  BottomApp({
    @required this.title,
    @required this.functionButton,
    this.iconAdd,
     this.setCircular =20,
    this.setWidth =0.60,
    this.setHeight =0.07,
    this.oneColor = Colors.white,
    this.twoColor = Colors.white ,
    this.colorTitle = Colors.black,
    this.colorIcon  = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: functionButton,
      child: Row(mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Container(
             margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * setWidth, //0.60
            height: MediaQuery.of(context).size.height * setHeight, //0.07
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(setCircular),
              border: Border.all(color: Colors.black),
              gradient: LinearGradient(
                colors: <Color>[
                  oneColor,
                  twoColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colorTitle,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                iconAdd != null ? Icon(iconAdd, color: colorIcon) : Container(),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
