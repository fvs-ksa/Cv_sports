import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/RolesSportِApiِِ.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/home/NotificationScreen.dart';
import 'package:cv_sports/Providers/FilterDataProvider.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:cv_sports/Providers/UsersProvider.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../ProviderAll.dart';
import 'ScreensAddNewPerson/AddNewPlayerScreen.dart';
import 'ScreensAddNewPerson/AddNewClubScreen.dart';
import 'ScreensAddNewPerson/AddnewExtraScreen.dart';
import 'PlayerInfomation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class OneCategory extends StatefulWidget {
  int indexRole;
  int idCategorySport;
  String titleCategorySport;
  RolesSport itemSport;

  OneCategory(
      {@required this.itemSport,
      @required this.indexRole,
      this.titleCategorySport,
      this.idCategorySport});

  @override
  _OneCategoryState createState() => _OneCategoryState();
}

class _OneCategoryState extends State<OneCategory> {
  Users informationProfile;
  final TextEditingController _typeAheadController = TextEditingController();
  @override
  void initState() {
    if (widget.titleCategorySport == null) {
      widget.titleCategorySport = "All games".tr();
    }

    Provider.of<UsersProvider>(context, listen: false).getUsersData(
        sportId: widget.idCategorySport, roleId: widget.itemSport.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Users> data = Provider.of<UsersProvider>(context).listUsers;
      informationProfile = Provider.of<InformationMyProfileProvider>(context).listInformationUser;
    return Provider.of<UsersProvider>(context).loading
        ? Scaffold(
          body: Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            )),
        )
        : Scaffold(
            backgroundColor: Color(0xffF9FAFF),
            appBar: AppbarOneCategory(context),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.titleCategorySport != null
                        ? Text(
                            widget.titleCategorySport + " - ",
                            style: TextStyle(
                           //   fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Container(),
                    Text(widget.itemSport.name,
                        style: TextStyle(
                         // fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: LazyLoadScrollView(
                      onEndOfPage: () {
                        Provider.of<UsersProvider>(context, listen: false)
                            .fetchUsers(
                                sportId: widget.idCategorySport,
                                roleId: widget.itemSport.id);
                      },
                      child: GridView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.70,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Provider.of<ProviderConstants>(context,
                                      listen: false)
                                  .ChangeIndexTap(Value: 0);
                              print("id = " + data[index].id.toString());
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PlayerInformation(
                                  userId: data[index].id,
                                );
                              }));
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 0, color: Colors.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: columnMoreData(
                                      context: context,
                                      SportData: data[index])),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
//================================= Appbar One Category ===========================================

  AppBar AppbarOneCategory(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffF9FAFF),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
                if( BaseUrlApi.tokenUser ==null){
                  BotToast.showText(
                    text: "The application must be registered first" .tr(),
                    contentColor: Colors.blue,
                  );
                }
             else if(informationProfile.role !=null){
                BotToast.showText(
                  text: "You have been previously updated".tr(),
                  contentColor: Colors.blue,
                );
              }else{
                if (widget.indexRole == 0) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddNewPlayerScreen(setRoleId: widget.itemSport.id.toString(),);
                  }));
                } else if (widget.indexRole == 2) {
                  //MakeNewClubScreen
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddNewClubScreen(setRoleId: widget.itemSport.id.toString());
                  }));
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddnewExtraScreen(setRoleId: widget.itemSport.id.toString());
                  }));
                }
              }



            },
            child: Icon(
              Icons.add_circle,
              color: Color(0xff5E5D8F),
              size: 30,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xffEEF1FC),
              ),
              child: TypeAheadField(
                hideOnError: true,
                textFieldConfiguration: TextFieldConfiguration(
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  controller: _typeAheadController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,color: Colors.black,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _typeAheadController.clear();
                      },
                      child: Icon(
                        Icons.clear,color: Colors.black,
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
                      borderSide:
                          const BorderSide(color: Colors.black, width: 0.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 0.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Search".tr(),
                    hintStyle:
                        TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  ),
                ),
                suggestionsCallback: (nameText) async {
                  //  return null;
                  print("Enter");
                  return await Provider.of<FilterDataProvider>(context,
                      listen: false)
                      .fetchFilterApi(name: nameText);
                },
                noItemsFoundBuilder: (BuildContext context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("There is no person with this name".tr(),
                        style: TextStyle(color: Theme.of(context).errorColor)),
                  ],
                ),
                itemBuilder: (context, Users suggestion) {
                  print("avatar" + informationProfile.avatar.toString());
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        backgroundImage:
                        NetworkImage(suggestion.avatar)),
                    title: Text(
                      suggestion.name,
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                        suggestion.role == null
                            ? "undefined".tr()
                            : suggestion.role.name.toString(),
                        style: TextStyle(fontSize: 18)),
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
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 5 ,left: 5),
              child: FaIcon(
                EasyLocalization.of(context).locale .languageCode =="ar" ?    FontAwesomeIcons.arrowLeft :  FontAwesomeIcons.arrowRight,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
//================================= column More Data ===========================================
  SingleChildScrollView columnMoreData({Users SportData, BuildContext context}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // padding: EdgeInsets.all(2),
            height: .08 * MediaQuery.of(context).size.height,
            width: .18 * MediaQuery.of(context).size.width,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              backgroundImage: NetworkImage(
                widget.indexRole == 2?        SportData.clubDetails.icon :  SportData.avatar,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.indexRole == 2 ? SportData.clubDetails.name : SportData.name,
            textAlign: TextAlign.center,
            maxLines: null,
            style: TextStyle(
            //  fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
