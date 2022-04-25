import 'package:cv_sports/Model/usersApi.dart';

import 'package:cv_sports/Pages/TapsProfileScreen/MyConversationProfileScreen.dart';
import 'package:cv_sports/Pages/TapsProfileScreen/MyPostsProfileScreen.dart';
import 'package:cv_sports/Providers/UserInformationProvider.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/ImageAndNameProfile.dart';
import 'package:cv_sports/Widgets/ProfileScreenWidget/TabsBarProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ProviderAll.dart';
import 'ShowInormationScreen.dart';

class PlayerInformation extends StatefulWidget {
  int userId;

  PlayerInformation({@required this.userId});

  @override
  _PlayerInformationState createState() => _PlayerInformationState();
}

//informationProfile.png
class _PlayerInformationState extends State<PlayerInformation>
    with TickerProviderStateMixin {
  Color BackgroundColor;

  Color TextColor;
  TabController tabController;

  Users informationProfile;

  void _setActiveTabIndex() {
    Provider.of<ProviderConstants>(context, listen: false)
        .ChangeIndexTap(Value: tabController.index);
  }

  @override
  void initState() {
    super.initState();

    Provider.of<UserInformationProvider>(context, listen: false)
        .getInformationUser(userId: widget.userId);

    tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    tabController.addListener(_setActiveTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    informationProfile =
        Provider.of<UserInformationProvider>(context).listInformationUser;

    return Provider.of<UserInformationProvider>(context).loading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            )),
          )
        : Scaffold(

            //   backgroundColor: Colors.transparent,
            backgroundColor: Color(0xffF9FAFF),
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * .25),
                child: Column(
                  children: [

                    ImageAndNameProfile(
                      informationProfile: informationProfile,isProfile: false,
                    ),
                    TabsBarProfile(tabController: tabController),
                  ],
                ),
              ),
              elevation: 0,
              backgroundColor: Color(0xffF9FAFF),
            ),
            body: Provider.of<UserInformationProvider>(context).loading
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ))
                : TabBarView(
                    controller: tabController,
                    children: [
                      ShowInformationScreen(
                        informationProfile: informationProfile,
                      ),
                      MyPostsProfileScreen(
                        informationProfile: informationProfile,
                      ),
                      MyConversationProfileScreen(myProfileId:   informationProfile.id,),
                      //     MyConversationProfileScreen(),
                    ], //01019334359
                  ));
  }
}
