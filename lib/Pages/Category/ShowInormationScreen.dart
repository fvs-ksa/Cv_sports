import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/SubScreen/MyImagesDataProfile.dart';
import 'package:cv_sports/Providers/UserInformationProvider.dart';
import 'package:cv_sports/Services/AllServices/ServiceFollowing/AllServicesFollow.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/CardInformation.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/CardMyImagesUser.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/CardPrizeUser.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/RowSocialMediaCards.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'OtherFollowers.dart';
import 'OtherFollowing.dart';
import 'package:easy_localization/easy_localization.dart';

class ShowInformationScreen extends StatefulWidget {
  Users informationProfile;

  ShowInformationScreen({@required this.informationProfile});

  @override
  _ShowInformationScreenState createState() => _ShowInformationScreenState();
}

class _ShowInformationScreenState extends State<ShowInformationScreen> {
  @override
  Widget build(BuildContext context) {
    widget.informationProfile =
        Provider.of<UserInformationProvider>(context).listInformationUser;
    return Provider.of<UserInformationProvider>(context).loading
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
                  //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: () async {
                          if (BaseUrlApi.tokenUser == null) {
                            BotToast.showText(
                              text: "The application must be registered first"
                                  .tr(),
                              contentColor: Colors.blue,
                            );
                          } else if (BaseUrlApi.idUser ==
                              widget.informationProfile.id) {
                            BotToast.showText(
                              text: "You cannot follow yourself.".tr(),
                              contentColor: Colors.blue,
                            );
                          } else {
                            // await ServiceAllFollow()
                            //     .addAndRemoveFollow(
                            //     idFollowAdd: widget.informationProfile.id)
                            //     .then((v) {
                            //   Provider.of<UserInformationProvider>(context,
                            //       listen: false)
                            //       .getInformationUser(
                            //       userId: widget.informationProfile.id);
                            //   BotToast.showText(
                            //     text: v.data["message"].toString(),
                            //     contentColor: Colors.blue,
                            //   );
                            //   setState(() {
                            //
                            //   });
                            // });
                            print(widget.informationProfile.isFollowed);
                            await ServiceAllFollow()
                                .addAndRemoveFollow(
                                    idFollowAdd: widget.informationProfile.id)
                                .whenComplete(() {
                              print(widget.informationProfile.isFollowed);
                              Provider.of<UserInformationProvider>(context,
                                      listen: false)
                                  .getInformationUser(
                                      userId: widget.informationProfile.id);
                              print(widget.informationProfile.isFollowed);
                            });

                            setState(() {
                              widget.informationProfile.isFollowed =
                                  !widget.informationProfile.isFollowed;
                            });
                          }
                        },
                        elevation: 3,
                        child: widget.informationProfile.isFollowed
                            ? Text(
                                "Unfollow".tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Text(
                                "Follow up".tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        color: widget.informationProfile.isFollowed
                            ? Colors.orange.shade400
                            : Colors.green.shade400,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (BaseUrlApi.tokenUser == null) {
                            BotToast.showText(
                              text: "The application must be registered first"
                                  .tr(),
                              contentColor: Colors.blue,
                            );
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OtherFollowers(
                                idUser: widget.informationProfile.id,
                              ),
                            ));
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Text(
                                  'Followers'.tr(),
                                  style: TextStyle(
                                //    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.informationProfile.userFollowers
                                  .toString(),
                              style: TextStyle(
                              //  fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w600,
                                color: Color(0xff2C2B53),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (BaseUrlApi.tokenUser == null) {
                            BotToast.showText(
                              text: "The application must be registered first"
                                  .tr(),
                              contentColor: Colors.blue,
                            );
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OtherFollowing(
                                idUser: widget.informationProfile.id,
                              ),
                            ));
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Text("follow".tr(),
                                    style: TextStyle(
                                   //   fontSize: ScreenUtil().setSp(18),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ))),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                                widget.informationProfile.userFollowing
                                    .toString(),
                                style: TextStyle(
                                //  fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff2C2B53),
                                )),
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
                  widget.informationProfile.prizes == null
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
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                          ),
                        ))
                      : (widget.informationProfile.role.profileType.index == 1
                          ? Container()
                          : Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 20, top: 20),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Prizes".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                    //      fontSize: ScreenUtil().setSp(18)
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
                                     //     fontSize: ScreenUtil().setSp(18),
                                          fontWeight: FontWeight.w600,
                                        ))),
                                CardPrizeUser(
                                  informationProfile: widget.informationProfile,
                                  isMedals: true,
                                ),
                              ],
                            )),
                  Container(
                      margin: EdgeInsets.only(right: 20, top: 10, left: 20),
                      alignment:
                          EasyLocalization.of(context).locale.languageCode ==
                                  "ar"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Text("Means of communication".tr(),
                          style: TextStyle(
                         //   fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w600,
                          ))),
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
                     //       fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w600,
                          ))),
                  CardMyImagesUser(
                      informationProfile: widget.informationProfile),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  )
                ],
              ),
            ),
          );
  }
}
