import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class CardSelected extends StatefulWidget {
  bool selectBtn;
  ValueChanged<bool> onValueChanged;
  CardSelected({  @required this.onValueChanged  ,@required this.selectBtn});

  @override
  _CardSelectedState createState() => _CardSelectedState();
}

class _CardSelectedState extends State<CardSelected> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              setState(() {
              widget.  selectBtn = true;
              });
              widget.onValueChanged( widget.selectBtn);
            },
            child: Container(
                alignment: Alignment.center,
           //     width: MediaQuery.of(context).size.width * .40,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "male".tr(),
                      style: TextStyle(
                      //    fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w600,
                          color: (widget.selectBtn == true)
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    FaIcon(FontAwesomeIcons.male,
                        size: 30,
                        color:
                        (widget.  selectBtn == true) ? Colors.white : Colors.black),
                  ],
                ),
                decoration: BoxDecoration(
                  color:
                  (widget.  selectBtn == true) ? Color(0xff2C2B53) : Colors.white,
                  border: Border.all(
                    color: Colors.grey, //                   <--- border color
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(
                      20.0) //                 <--- border radius here
                  ),
                )),
          ),
          InkWell(
            onTap: () {
              setState(() {
                widget.  selectBtn = false;
              });
              widget.onValueChanged( widget.  selectBtn);
            },
            child: Container(
              alignment: Alignment.center,
          //      width: MediaQuery.of(context).size.width * .40,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "female".tr(),
                      style: TextStyle(
           //               fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w600,
                          color: (widget.selectBtn == false)
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    FaIcon(FontAwesomeIcons.female,
                        size: 30,
                        color:
                        (widget.  selectBtn == false) ? Colors.white : Colors.black)
                  ],
                ),
                decoration: BoxDecoration(
                  color:
                  (widget.  selectBtn == false) ? Color(0xff2C2B53) : Colors.white,
                  border: Border.all(
                    color: Colors.grey, //                   <--- border color
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(
                      20.0) //                 <--- border radius here
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
