import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Services/AllServices/serviceUpdateExtra.dart';
import 'package:cv_sports/Services/AllServices/serviceUpdatePlayer.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class addSummaryProfile extends StatefulWidget {
  Users informationProfile;

  addSummaryProfile({ @required this.informationProfile});

  @override
  _addSummaryProfileState createState() => _addSummaryProfileState();
}

class _addSummaryProfileState extends State<addSummaryProfile> {
  TextEditingController textEditingController = TextEditingController();

  int maxLengthEnd = 255;

  int maxLengthStart = 255;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(0xffF9FAFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffF9FAFF),
          centerTitle: true,
          title: Text(
            "Add or modify a CV".tr(),
         //  style: TextStyle(fontSize: ScreenUtil().setSp(18)),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height *.36,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: TextField(
                textAlign: TextAlign.start,
                maxLines: null,
                maxLength: maxLengthStart,
                style: TextStyle(
            //      fontSize: ScreenUtil().setSp(18),
                  height: 1.5,
                  color: Colors.black,
                ),
                controller: textEditingController,
                onChanged: (value) {
                  setState(() {
                    maxLengthEnd = maxLengthStart - value.length;
                  });
                },
                decoration: InputDecoration(
                  counterText: "",
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
             //     hintStyle: TextStyle(fontSize: ScreenUtil().setSp(18)),
                  hintText: "write here".tr(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: Text(maxLengthEnd.toString(),
                  style: TextStyle(
                    //fontSize: ScreenUtil().setSp(18)
                  )),
            ),

            BottomApp(
              title: "Update".tr(),
              setCircular: 10,
              functionButton: () {
                widget.informationProfile.role.profileType.index == 2
                    ? ServiceUpdatePlayer()
                        .postUpdatePlayer(cv: textEditingController.text.trim())
                        .whenComplete(() {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return MainScreen();
                        }));
                      })
                    : ServiceUpdateExtra()
                        .postUpdateExtra(cv: textEditingController.text.trim())
                        .whenComplete(() {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                        return MainScreen();
                      }));
                } );
              },
              setWidth: .8,
              oneColor: Color(0xff2C2B53),
              twoColor: Color(0xff2C2B53),
              colorTitle: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
