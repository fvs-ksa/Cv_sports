import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputImageCircle extends StatelessWidget {
  double setWidth;
  double setHeight;
  var setIcon;
  var setColorIcon;
  double sizeIcon;
  var setColorBackground;
  Function functionButton;


  InputImageCircle(
      {
      this.setWidth = .4,
      this.setHeight = .19,
   @required   this.setIcon,
        @required   this.functionButton,
      this.setColorIcon = Colors.black,
      this.sizeIcon =60,
        this.  setColorBackground = Colors.white
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(

          width: MediaQuery.of(context).size.width * setWidth,
          height:MediaQuery.of(context).size.height * setHeight,
          child: ClipOval(
            child: Material(

              color: setColorBackground, // button color
              child: InkWell(
                splashColor: Colors.red, // inkwell color
                child: Center(child: FaIcon(setIcon,color:setColorIcon ,size: sizeIcon,)),
                onTap:functionButton,
              ),
            ),
          ),
        ),
      ],
    );
  }
}