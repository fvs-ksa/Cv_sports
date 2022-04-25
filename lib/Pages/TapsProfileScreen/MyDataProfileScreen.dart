import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/CardInformation.dart';

import 'package:cv_sports/Widgets/ProfileScreenWidget/CardMyImagesUser.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/CardPrizeUser.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/RowSocialMediaCards.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'FollowersPage.dart';
import 'followingPage.dart';

class MyDataProfileScreen extends StatefulWidget {
  Users informationProfile;

  MyDataProfileScreen({@required this.informationProfile});

  @override
  _MyDataProfileScreenState createState() => _MyDataProfileScreenState();
}

class _MyDataProfileScreenState extends State<MyDataProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<InformationMyProfileProvider>(context).loading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            )),
          )
        : Scaffold(
            backgroundColor: Color(0xffF9FAFF),
            bottomSheet: ClipRRect(
              child: Container(
                color: Color(0xffF9FAFF),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),

                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),

                    //  border: Border.all(color: Colors.white)
                  ),
                  height: MediaQuery.of(context).size.height * 0.12,
                  //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FollowersPage(),
                          ));
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Text(
                                'Followers'.tr(),
                                style: TextStyle(
                      //              fontSize: ScreenUtil().setSp(18),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.informationProfile.userFollowers
                                  .toString(),
                              style: TextStyle(
                                // fontSize: ScreenUtil().setSp(18),
                                  color: Color(0xff2C2B53),
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FollowingPage(),
                          ));
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Text("follow".tr(),
                                  style: TextStyle(
                          //            fontSize: ScreenUtil().setSp(18),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                                widget.informationProfile.userFollowing
                                    .toString(),
                                style: TextStyle(
                            //        fontSize: ScreenUtil().setSp(18),
                                    color: Color(0xff2C2B53),
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CardInformation(
                    informationProfile: widget.informationProfile,
                  ),
                  widget.informationProfile.role == null
                      ? Center(
                          child: Container(
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 2,
                            child: Center(
                                child: Text(
                                    "There are currently no added prizes.".tr(),
                                    style: TextStyle(fontSize: 18))),
                          ),
                        ))
                      : (widget.informationProfile.role.profileType.index == 2
                          ? Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 20, top: 20),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Prizes".tr(),
                                      style: TextStyle(
                                      //    fontSize: ScreenUtil().setSp(18)
                                          ),
                                    )),
                                CardPrizeUser(
                                  informationProfile: widget.informationProfile,
                                  isMedals: false,
                                ),
                                Container(
                                    margin: EdgeInsets.only(right: 20, top: 20),
                                    alignment: Alignment.centerRight,
                                    child: Text("Medals".tr(),
                                        style: TextStyle(
                                  //          fontSize: ScreenUtil().setSp(18)
                                            ))),
                                CardPrizeUser(
                                  informationProfile: widget.informationProfile,
                                  isMedals: true,
                                ),
                              ],
                            )
                          : Container()),
                  Container(
                      margin: EdgeInsets.only(right: 20, top: 10, left: 20),
                      alignment:
                          EasyLocalization.of(context).locale.languageCode ==
                                  "ar"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Text(
                        "Means of communication".tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  RowSocialMediaCards(
                    socialLinks: widget.informationProfile.socialLinks,
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 20, top: 10, left: 20),
                      alignment:
                          EasyLocalization.of(context).locale.languageCode ==
                                  "ar"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Text("My Pictures".tr(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ))),
                  CardMyImagesUser(
                      informationProfile: widget.informationProfile),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                  )
                ],
              ),
            ),
          );
  }
}
