import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cv_sports/Pages/TapsProfileScreen/MyConversationProfileScreen.dart';
import 'package:cv_sports/Pages/TapsProfileScreen/MyDataProfileScreen.dart';
import 'package:cv_sports/Pages/TapsProfileScreen/MyPostsProfileScreen.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/FunctionShowBottomSheet.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/ImageAndNameProfile.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/TabsBarProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../ProviderAll.dart';
import 'SettingScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  //====================  Variables  ==========================

  Color BackgroundColor;

  Color TextColor;
  TabController tabController;

  Users informationProfile;

  void _setActiveTabIndex() {
    Provider.of<ProviderConstants>(context, listen: false)
        .ChangeIndexTap(Value: tabController.index);
  }
  //==================== initState Build ==========================

  @override
  void initState() {
    super.initState();

    Provider.of<InformationMyProfileProvider>(context, listen: false)
        .getInformationMyProfileData();

    tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    tabController.addListener(_setActiveTabIndex);
  }

  //==================== Main Build ==========================
  @override
  Widget build(BuildContext context) {
    informationProfile =
        Provider.of<InformationMyProfileProvider>(context).listInformationUser;

    return Provider.of<InformationMyProfileProvider>(context).loading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            )),
          )
        : Scaffold(
            backgroundColor: Color(0xffF9FAFF),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(informationProfile.role != null
                    ? MediaQuery.of(context).size.height * .25
                    : MediaQuery.of(context).size.height * .28),
                child: Column(
                  children: [
                    ImageAndNameProfile(
                      informationProfile: informationProfile,
                      isProfile: true,
                    ),
                    TabsBarProfile(
                      tabController: tabController,
                    )
                  ],
                ),
              ),
              elevation: 0,
              backgroundColor: Color(0xffF9FAFF),
              actions: [
                InkWell(
                  onTap: () {
                    if (informationProfile.role != null) {
                      FunctionShowBottomSheet().displayBottomSheet(
                          context: context,
                          informationProfile: informationProfile);
                    } else {
                      BotToast.showText(
                        text:
                            "Please add a specialty to complete the data.".tr(),
                        contentColor: Colors.blue,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 15, right: 15), //   size: 26,
                    //      color: Color(0xff5E5D8F),
                    child: FaIcon(
                      FontAwesomeIcons.ellipsisV,
                      color: Color(0xff2C2B53),
                      size: 24,
                    ),
                  ),
                )
              ],
              leading: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SettingScreen();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 15, left: 15), //   size: 26,
                  //      color: Color(0xff5E5D8F),
                  child: FaIcon(
                    FontAwesomeIcons.cog,
                    color: Color(0xff2C2B53),
                    size: 24,
                  ),
                ),
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                MyDataProfileScreen(
                  informationProfile: informationProfile,
                ),
                MyPostsProfileScreen(
                  informationProfile: informationProfile,
                ),
                MyConversationProfileScreen(
                  myProfileId: informationProfile.id,
                ),
              ], //01019334359
            ));
  }
}
