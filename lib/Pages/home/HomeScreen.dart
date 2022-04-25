import 'package:cv_sports/Model/AdvertismentsApi.dart';
import 'package:cv_sports/Model/RolesSport%D9%90Api%D9%90%D9%90.dart';
import 'package:cv_sports/Model/VideosApiHomePage.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/Category/ScreensAddNewPerson/AddNewClubScreen.dart';
import 'package:cv_sports/Pages/Category/ScreensAddNewPerson/AddNewPlayerScreen.dart';
import 'package:cv_sports/Pages/Category/ScreensAddNewPerson/AddnewExtraScreen.dart';
import 'package:cv_sports/Providers/AdvertismentsProvider.dart';
import 'package:cv_sports/Providers/CategoryProvider.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:cv_sports/Providers/ProviderNofitcition.dart';
import 'package:cv_sports/Providers/RolesSportProvider.dart';
import 'package:cv_sports/Providers/VideosHomePageProvider.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Widgets/Globle/InputDropMenuById.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/CardClubNews.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/CarouselAds.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/RowListSport.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/RowVideos.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'VoteScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RolesSport> dataSport;
  RolesSport roleIndex;
  String dropdownValueSport;
  Users informationProfile;
  int startShowDialog = 0;
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getCategoriesData();
    Provider.of<AdvertismentsProvider>(context, listen: false)
        .getAdvertismentsData();
    Provider.of<VideosHomePageProvider>(context, listen: false).getVideoData();
    Provider.of<ProviderNofitcition>(context, listen: false)
        .getNofitcitionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("lang = " + EasyLocalization.of(context).locale.languageCode);
    List<AdvertismentsApi> advertisments =
        Provider.of<AdvertismentsProvider>(context).listAdvertisments;
    List<Videos> allVideos =
        Provider.of<VideosHomePageProvider>(context).listVideos;
    informationProfile =
        Provider.of<InformationMyProfileProvider>(context).listInformationUser;

    dataSport = Provider.of<RolesSportProvider>(context).listRolesSport;
    if (!Provider.of<InformationMyProfileProvider>(context, listen: false)
        .loading) {
      if (startShowDialog == 0 &&
          BaseUrlApi.tokenUser != null &&
          informationProfile.role == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showListDialog();
        });
        startShowDialog++;
      }
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RowListSport(),
          Provider.of<AdvertismentsProvider>(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ))
              : CarouselAds(listAdvertisments: advertisments),
          Container(
              margin: EdgeInsets.only(right: 10, left: 10),
              alignment:
                  EasyLocalization.of(context).locale.languageCode == "ar"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
              child: Text(
                "See".tr(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              )),
          Provider.of<VideosHomePageProvider>(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ))
              : Container(
                  height: MediaQuery.of(context).size.height * .32,
                  child: ListView.builder(
                      itemCount: allVideos.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return RowVideos(
                          videoTitle: allVideos[index].title,
                          videoUrl: allVideos[index].video,
                        );
                      }),
                ),
          CardClubNews()
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
}
