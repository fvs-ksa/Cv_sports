import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/AddMedal.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/AddPostNews.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/AddPost_Image_video.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/AddPrizes.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/AddSocialMedia.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/addSummaryProfile.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/editImageProfile.dart';
import 'package:cv_sports/Pages/PagesSetting/PageContactUs.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FunctionShowBottomSheet {
  showMassageDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: new Text(
                "activate the account".tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: new Text(
                      "Please contact the service provider to activate your account"
                          .tr(),
                      style: TextStyle(
                        color: Color(0xff8E93A2),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
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

  void displayBottomSheet({BuildContext context, Users informationProfile}) {
    showModalBottomSheet(
        //  isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        context: context,
        builder: (ctx) {
          return Container(
            height: informationProfile.role.profileType.index == 2
                ? MediaQuery.of(context).size.height * 0.6
                : MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  informationProfile.role.profileType.index == 2 ||
                          informationProfile.role.profileType.index == 0
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return addSummaryProfile(
                                      informationProfile: informationProfile);
                                }));
                              },
                              child: ListTile(
                                trailing: Icon(Icons.arrow_back_outlined),
                                title: Text(
                                  "Add or modify a CV".tr(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700),
                                ),
                                leading: Image.asset(
                                  "assets/images/profile.png",
                                  height: 26.42,
                                  width: 27.55,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        )
                      : Container(),

                  informationProfile.role.profileType.index == 2
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AddPrize();
                                }));
                              },
                              child: ListTile(
                                trailing: Icon(Icons.arrow_back_outlined),
                                title: Text(
                                  "Adding or modifying prizes".tr(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700),
                                ),
                                leading: Image.asset(
                                  "assets/images/trophy.png",
                                  height: 26.42,
                                  width: 27.55,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            InkWell(
                              //AddMedal
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AddMedal();
                                }));
                              },
                              child: ListTile(
                                trailing: Icon(Icons.arrow_back_outlined),
                                title: Text(
                                  "Add or modify medals".tr(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700),
                                ),
                                leading: Image.asset(
                                  "assets/images/medal.png",
                                  height: 26.42,
                                  width: 27.55,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        )
                      : Container(),

                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AddSocialMedia(
                          informationProfile: informationProfile,
                        );
                      }));
                    },
                    child: ListTile(
                      trailing: Icon(Icons.arrow_back_outlined),
                      title: Text(
                        "Adding or modifying means of communication".tr(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/images/slack.png",
                        height: 26.42,
                        width: 27.55,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ), //editImageProfile
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return editImageProfile();
                      }));
                    },
                    child: ListTile(
                      trailing: Icon(Icons.arrow_back_outlined),
                      title: Text(
                        "Add or edit photos".tr(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/images/image.png",
                        height: 26.42,
                        width: 27.55,
                      ),
                    ),
                  ),

                  informationProfile.role.news
                      ? Column(
                          children: [
                            Divider(
                              thickness: 2,
                            ),
                            InkWell(
                              onTap: () {
                                if (!informationProfile.active) {
                                  showMassageDialog(context);
                                } else {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AddPostNews(
                                      isClub: true,
                                    );
                                  }));
                                }
                              },
                              child: ListTile(
                                trailing: Icon(Icons.arrow_back_outlined),
                                title: Text(
                                  "Add news".tr(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                leading: Image.asset(
                                  "assets/images/newspaper.png",
                                  height: 26.42,
                                  width: 27.55,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),

                  Divider(
                    thickness: 2,
                  ),
                  InkWell(
                    onTap: () {
                      if (!informationProfile.active) {
                        showMassageDialog(context);
                      } else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AddPost_Image_video();
                        }));
                      }
                    },
                    child: ListTile(
                      trailing: Icon(Icons.arrow_back_outlined),
                      title: Text(
                        "Add post".tr(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        "assets/images/chat.png",
                        height: 26.42,
                        width: 27.55,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
