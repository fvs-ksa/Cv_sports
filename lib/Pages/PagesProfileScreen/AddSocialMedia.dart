import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Services/AllServices/ServiceAddSocial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:easy_localization/easy_localization.dart';

class AddSocialMedia extends StatefulWidget {
  Users informationProfile;

  AddSocialMedia({this.informationProfile});

  @override
  _AddSocialMediaState createState() => _AddSocialMediaState();
}

class _AddSocialMediaState extends State<AddSocialMedia> {
  TextEditingController controllerFacebook = TextEditingController();

  TextEditingController controllerInstgram = TextEditingController();

  TextEditingController controllertwiter = TextEditingController();

  TextEditingController controllersnap = TextEditingController();


  bool loading =false;
  @override
  void initState() {
    controllerFacebook.text = widget.informationProfile.socialLinks.facebook;
    controllerInstgram.text = widget.informationProfile.socialLinks.instagram;
    controllertwiter.text = widget.informationProfile.socialLinks.twitter;
    controllersnap.text = widget.informationProfile.socialLinks.snapchat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      loading?
      Scaffold(
        body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            )),
      ):
      GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
        backgroundColor: Color(0xffF9FAFF),
        appBar: AppBar(
          actions: [
            Container(
                margin: EdgeInsets.only(left: 20), child: Icon(Icons.add_circle)),
          ],
          elevation: 0,
          backgroundColor: Color(0xffF9FAFF),
          centerTitle: true,
          title: Text(
            "Adding or modifying means of communication".tr(),
                //  style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              RowAddTwitter(context),
              RowAddInstagram(context),
              RowAddFacebook(context),
              RowAddSnapchatGhost(context),
              //   Spacer(),
              BottomApp(
                title: "Update".tr(),
                      setCircular: 10,
                      functionButton: () async {
                        setState(() {
                          loading = true;
                        });
                        await ServiceAddSocial()
                            .postAddSocial(
                                facebook: controllerFacebook.text.trim(),
                                twitter: controllertwiter.text.trim(),
                                snapchat: controllersnap.text.trim(),
                                instagram: controllerInstgram.text.trim())
                            .whenComplete(() {
                          setState(() {
                      loading =false;
                    });
                    BotToast.showText(
                      text: "Updated".tr(),
                            contentColor: Colors.blue,
                          );
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return MainScreen();
                        }));
                  });
                },
                setWidth: .8,
                oneColor: Color(0xff2C2B53),
                twoColor: Color(0xff2C2B53),
                colorTitle: Colors.white,
              ),
            ],
          ),
        ),
    ),
      );
  }

  Container RowAddTwitter(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Color(0xff21A9F4),
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Twitter".tr(),
                    style: TextStyle(
                    //  fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300)),
              child: TextField(
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(
              //    fontSize: ScreenUtil().setSp(18),
                  color: Colors.black,
                ),
                controller: controllertwiter,
                decoration: InputDecoration(
                  counterText: "",
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
             //     hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
            //      labelStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
                  hintText: "Add link".tr(),
                  //           labelText: informationProfile.socialLinks.twitter
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container RowAddInstagram(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Color(0xffFFDD55),
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Instagram".tr(),
                    style: TextStyle(
                  //    fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300)),
              child: TextField(
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(
             //     fontSize: ScreenUtil().setSp(16),
                  color: Colors.black,
                ),
                controller: controllerInstgram,
                decoration: InputDecoration(
                  counterText: "",
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
              //    hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
             //     labelStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
                  hintText: "Add link".tr(),
                  //            labelText: informationProfile.socialLinks.instagram
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container RowAddFacebook(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Color(0xff1977F2),
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Facebook".tr(),
                    style: TextStyle(
                  //    fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300)),
              child: TextField(
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(
              //    fontSize: ScreenUtil().setSp(16),
                  color: Colors.black,
                ),
                controller: controllerFacebook,
                decoration: InputDecoration(
                  counterText: "",
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
              //    hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
               //   labelStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
                  hintText: "Add link".tr(),
                  //           labelText: informationProfile.socialLinks.facebook
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container RowAddSnapchatGhost(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.snapchatGhost,
                  color: Color(0xffFFEB3B),
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("snap chat".tr(),
                    style: TextStyle(
                 //    fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300)),
              child: TextField(
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(
          //        fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                controller: controllersnap,
                decoration: InputDecoration(
                  counterText: "",
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
             //     hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
          //        labelStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
                  hintText: "Add link".tr(),
                  //            labelText: informationProfile.socialLinks.snapchat
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
