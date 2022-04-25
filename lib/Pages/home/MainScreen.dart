import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/Category/PlayerInfomation.dart';
import 'package:cv_sports/Pages/SubScreen/OnePostScreenAllPostShare.dart';
import 'package:cv_sports/ProviderAll.dart';
import 'package:cv_sports/Providers/FilterDataProvider.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:cv_sports/Providers/ProviderNofitcition.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'CategoryScreen.dart';
import 'HomeScreen.dart';
import 'NotificationScreen.dart';
import 'PostsScreen.dart';
import 'ProfileScreen.dart';
import 'SettingScreen.dart';
import 'VoteScreen.dart';
import 'filter_Screen.dart';

class MainScreen extends StatefulWidget {
  bool isDynamic;

  MainScreen({this.isDynamic = false});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(5);

  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.rectangle;

  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;

  Color selectedColor = Colors.blueGrey;
  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  Color unselectedColor = Colors.white;
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];

  var ListScreen = [
    HomeScreen(),
    BaseUrlApi.tokenUser != null ? ProfileScreen() : SettingScreen(),
    CategoryScreen(),
    VoteScreen(),
    PostsScreen(),
  ];
  final TextEditingController _typeAheadController = TextEditingController();
  Users informationProfile;

  final FirebaseMessaging _fcm = FirebaseMessaging();
  String fcmToken = "";
  Dio dio = new Dio();
  Response response;

  setNotificationDeviceId({String id}) async {
    var data = {"device_id": id};
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.setDeviceId);
    await Dio().postUri(uri,
        data: data,
        options: Options(headers: BaseUrlApi().getHeaderWithInToken()));
  }

  fireBaseNotifications() async {
    fcmToken = await _fcm.getToken();
    if (BaseUrlApi.tokenUser != null) {
      setNotificationDeviceId(id: fcmToken);
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Platform.isIOS
                ? ListTile(
                    title: Text(
                      message['aps']['alert']['title'],
                    ),
                    subtitle: Text(message['aps']['alert']['body']),
                  )
                : ListTile(
                    title: Text(
                      message['notification']['title'],
                    ),
                    subtitle: Text(
                      message['notification']['body'],
                    ),
                  ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
    );
    _fcm.requestNotificationPermissions(const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: false));
    _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  initDynamicLinks() async {
    // this is called when app comes from background

    print("Enter");
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print("deepLink " + deepLink.toString());

        print(deepLink.path);
        if (deepLink.path == "/PostShare") {
          print(deepLink.query.replaceFirst("PostId=", ""));

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OnePostScreenAllPostShare(
              postId: int.parse(deepLink.query.replaceFirst("PostId=", "")),
            ),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VoteScreen(
              isDynamic: true,
            ),
          ));
          print("Enter dy comes");
        }
      } else {
        print("deepLink == null");
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    // this is called when app is not open in background

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    print(deepLink);
    if (deepLink != null) {
      print("deepLink 2!= null");
      if (deepLink.path == "/PostShare") {
        print(deepLink.query.replaceFirst("PostId=", ""));

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OnePostScreenAllPostShare(
            postId: int.parse(deepLink.query.replaceFirst("PostId=", "")),
          ),
        ));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VoteScreen(
            isDynamic: true,
          ),
        ));
        print("Enter dy comes");
      }
    } else {
      print("deepLink 2== null");
    }
  }

  @override
  void initState() {
    initDynamicLinks();
    super.initState();

    if (BaseUrlApi.tokenUser != null) {
      Provider.of<InformationMyProfileProvider>(context, listen: false)
          .getInformationMyProfileData();
    }
    fireBaseNotifications();
  }

  @override
  Widget build(BuildContext context) {
    informationProfile =
        Provider.of<InformationMyProfileProvider>(context).listInformationUser;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          backgroundColor: Color(0xff2C2B53),
          snakeViewColor: selectedColor,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          currentIndex: _selectedItemPosition,
          selectedLabelStyle: TextStyle(color: Colors.white, fontSize: 12),
          unselectedLabelStyle: TextStyle(color: Colors.white, fontSize: 12),
          onTap: (index) {
            print("index SnakeNavigationBar = " + index.toString());
            Provider.of<ProviderConstants>(context, listen: false)
                .ChangeIndexTap(Value: 0);
            setState(() {
              _selectedItemPosition = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "profile".tr(),
            ),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.users,
                ),
                label: "category".tr()),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.voteYea,
                ),
                label: "vote".tr()),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.comment,
                ),
                label: "posts".tr()),
          ],
        ),
        backgroundColor: Color(0xffF9FAFF),
        appBar: (_selectedItemPosition == 1 ||
                _selectedItemPosition == 3 ||
                _selectedItemPosition == 4)
            ? null
            : appBarMainScreen(),
        body: ListScreen[_selectedItemPosition],
      ),
    );
  }
//=============================== Widget AppBar_MainScreen ===========================

  AppBar appBarMainScreen() {
    return AppBar(
      backgroundColor: Color(0xffF9FAFF),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BaseUrlApi.tokenUser == null
              ? Container()
              : Provider.of<InformationMyProfileProvider>(context).loading
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ))
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedItemPosition = 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 3),
                        height: .042 * MediaQuery.of(context).size.height,
                        width: .09 * MediaQuery.of(context).size.width,
                        child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 20,
                            backgroundImage:
                                NetworkImage(informationProfile.avatar)),
                      ),
                    ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                //  color: Color(0xffEEF1FC),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TypeAheadField(
                      hideOnError: true,
                      textFieldConfiguration: TextFieldConfiguration(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        controller: _typeAheadController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _typeAheadController.clear();
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(top: 0, right: 10),
                          filled: true,
                          fillColor: Color(0xffEEF1FC),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 0.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 0.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 0.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Search".tr(),
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      suggestionsCallback: (nameText) async {
                        //  return null;
                        print("Enter $nameText");

                        return await Provider.of<FilterDataProvider>(context,
                                listen: false)
                            .fetchFilterByName(name: nameText);
                      },
                      noItemsFoundBuilder: (BuildContext context) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("There is no person with this name".tr(),
                              style: TextStyle(
                                  color: Theme.of(context).errorColor)),
                        ],
                      ),
                      itemBuilder: (context, Users suggestion) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              backgroundImage: NetworkImage(suggestion.avatar)),
                          title: Text(
                            suggestion.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                              suggestion.role == null
                                  ? "undefined".tr()
                                  : suggestion.role.name.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              )),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PlayerInformation(
                            userId: suggestion.id,
                          );
                        }));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return FilterScreen();
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.filter_alt_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          BaseUrlApi.tokenUser != null
              ? GestureDetector(
                  onTap: () {
                    if (BaseUrlApi.tokenUser == null) {
                      BotToast.showText(
                        text: "The application must be registered first".tr(),
                        contentColor: Colors.blue,
                      );
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return NotificationScreen();
                      }));
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                        ),
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor:
                            Provider.of<ProviderNofitcition>(context)
                                        .ListNofitcition
                                        .unreadCount ==
                                    null
                                ? Colors.transparent
                                : Provider.of<ProviderNofitcition>(context)
                                            .ListNofitcition
                                            .unreadCount ==
                                        0
                                    ? Colors.transparent
                                    : Colors.red,
                        child: Text(
                          Provider.of<ProviderNofitcition>(context)
                                      .ListNofitcition
                                      .unreadCount ==
                                  null
                              ? ""
                              : Provider.of<ProviderNofitcition>(context)
                                          .ListNofitcition
                                          .unreadCount ==
                                      0
                                  ? ""
                                  : Provider.of<ProviderNofitcition>(context)
                                      .ListNofitcition
                                      .unreadCount
                                      .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 7, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
      centerTitle: true,
    );
  }
}
