import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/RolesSport%D9%90Api%D9%90%D9%90.dart';
import 'package:cv_sports/Model/SportApi.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/Category/ScreensAddNewPerson/AddNewClubScreen.dart';
import 'package:cv_sports/Pages/Category/ScreensAddNewPerson/AddNewPlayerScreen.dart';
import 'package:cv_sports/Pages/Category/ScreensAddNewPerson/AddnewExtraScreen.dart';
import 'package:cv_sports/Pages/PagesSetting/PageContactUs.dart';
import 'package:cv_sports/Providers/CategoryProvider.dart';
import 'package:cv_sports/Providers/RolesSportProvider.dart';
import 'package:cv_sports/Widgets/Globle/InputDropMenuById.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:full_screen_image/full_screen_image.dart';

class ImageAndNameProfile extends StatefulWidget {
  Users informationProfile;
  bool isProfile;
  ImageAndNameProfile(
      {@required this.informationProfile, this.isProfile = false});

  @override
  _ImageAndNameProfileState createState() => _ImageAndNameProfileState();
}

class _ImageAndNameProfileState extends State<ImageAndNameProfile> {
  String dropdownValueSport;
  String dropdownValueGame;
  List<RolesSport> dataSport;
  List<SportApi> dataGame;
  RolesSport roleIndex;
  @override
  Widget build(BuildContext context) {
    dataSport = Provider.of<RolesSportProvider>(context).listRolesSport;
    dataGame = Provider.of<CategoryProvider>(context).listCategory;

    return Center(
      child: Column(
        children: [
          FullScreenWidget(
            backgroundColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              height: .09 * MediaQuery.of(context).size.height,
              width: .19 * MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  widget.informationProfile.role == null
                      ? widget.informationProfile.avatar
                      : widget.informationProfile.role.profileType.index == 1
                          ? widget.informationProfile.clubDetails.icon
                          : widget.informationProfile.avatar,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          // FullScreenWidget(
          //   backgroundColor: Colors.white,
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: 10),
          //     height: .08 * MediaQuery.of(context).size.height,
          //     width: .18 * MediaQuery.of(context).size.width,
          //     child: CircleAvatar(
          //         backgroundColor: Colors.transparent,
          //         radius: 20,
          //         backgroundImage:
          //             NetworkImage(widget.informationProfile.role == null
          //                 ? widget.informationProfile.avatar
          //                 : widget.informationProfile.role.profileType.index == 1
          //                     ? widget.informationProfile.clubDetails.icon
          //                     : widget.informationProfile.avatar)),
          //   ),
          // ),
          Text(
            widget.informationProfile.role == null
                ? widget.informationProfile.name
                : widget.informationProfile.role.profileType.index == 1
                    ? widget.informationProfile.clubDetails.name
                    : widget.informationProfile.name,
            style: TextStyle(
         //       fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.bold
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.isProfile) {
                    if (!widget.informationProfile.active) {
                      showMassageDialog();
                    }
                  }
                },
                child: Text(
                  widget.informationProfile.active
                      ? "Verified".tr()
                      : "UnVerified".tr(),
                  style: TextStyle(
               //       fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold,
                      color: widget.informationProfile.active
                          ? Colors.blue
                          : Colors.red),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.informationProfile.role == null
                    ? "undefined".tr()
                    : widget.informationProfile.role.name,
                style: TextStyle(
             //       fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          widget.informationProfile.role == null && widget.isProfile == true
              ? GestureDetector(
                  onTap: () {
                    showListDialog();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Account upgrade".tr(),
                        style: TextStyle(
                        //    fontSize: ScreenUtil().setSp(13),
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Press here".tr(),
                        style: TextStyle(
                      //      fontSize: ScreenUtil().setSp(13),
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  showListDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: new Text(
                "Account upgrade".tr(),
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: new Text(
                      "Choose one of the majors that you want to become one of them"
                          .tr(),
                      style: TextStyle(color: Color(0xff8E93A2), fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(bottom: 10),
                  ),

                  //
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 20),
                  //   child:     InputDropMenuById(
                  //     onValueChanged: (value) {
                  //       dropdownValueGame = value;
                  //     },
                  //     iconSelect: Icons.sports_volleyball,
                  //     dropdownValue: dropdownValueGame,
                  //     listMenu: dataGame,
                  //     textHint: "the game".tr(),
                  //     setWidth: .55,
                  //   ),
                  // ),

                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: InputDropMenuById(
                      onValueChanged: (value) {
                        dropdownValueSport = value;

                        if (dropdownValueSport != null) {
                          roleIndex = dataSport.firstWhere((element) =>
                              element.id.toString() == dropdownValueSport);
                        }
                      },
                      iconSelect: Icons.sports,
                      dropdownValue: dropdownValueSport,
                      listMenu: dataSport,
                      textHint: "All majors".tr(),
                      setWidth: .55,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (roleIndex == null) {
                            Navigator.pop(context);
                          } else {
                            if (roleIndex.profileType.index == 0) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return AddNewPlayerScreen(
                                  setRoleId: dropdownValueSport,
                                );
                              }));
                            } else if (roleIndex.profileType.index == 2) {
                              //MakeNewClubScreen
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return AddNewClubScreen(
                                    setRoleId: dropdownValueSport);
                              }));
                            } else {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return AddnewExtraScreen(
                                    setRoleId: dropdownValueSport);
                              }));
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          margin: const EdgeInsets.only(right: 2, left: 2),
                          decoration: BoxDecoration(
                              color: Color(0xff222B45),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          width: MediaQuery.of(context).size.width * 0.28,
                          alignment: Alignment.center,
                          child: Text(
                            "OK".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          margin: const EdgeInsets.only(right: 2, left: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey)),
                          width: MediaQuery.of(context).size.width * 0.28,
                          alignment: Alignment.center,
                          child: Text(
                            "Retreat".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  showMassageDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: new Text(
                "activate the account".tr(),
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: new Text(
                      "Please contact the service provider to activate your account"
                          .tr(),
                      style: TextStyle(color: Color(0xff8E93A2), fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PageContactUs(), //Register //LogIn
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          margin: const EdgeInsets.only(right: 2, left: 2),
                          decoration: BoxDecoration(
                              color: Color(0xff222B45),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          width: MediaQuery.of(context).size.width * 0.28,
                          alignment: Alignment.center,
                          child: Text(
                            "OK".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          margin: const EdgeInsets.only(right: 2, left: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey)),
                          width: MediaQuery.of(context).size.width * 0.28,
                          alignment: Alignment.center,
                          child: Text(
                            "Retreat".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
