import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/Category/PlayerInfomation.dart';
import 'package:cv_sports/Providers/FilterDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class filter_SereenGet extends StatelessWidget {
  TextEditingController controllerDateTime = TextEditingController();
  TextEditingController controllerTextInput = TextEditingController();
  String dropdownValueCity;
  String dropdownValueCountry;
  String dropdownValueSportCategory;

  filter_SereenGet(
      {@required this.controllerDateTime,
      @required this.controllerTextInput,
      @required this.dropdownValueCity,
      @required this.dropdownValueCountry,
      @required this.dropdownValueSportCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("advanced search".tr()),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: LazyLoadScrollView(
          onEndOfPage: () {
            Provider.of<FilterDataProvider>(context, listen: false)
                .fetchFilterApi(
                    name: controllerTextInput.text.trim().isEmpty
                        ? null
                        : controllerTextInput.text.trim(),
                    sport_id: dropdownValueSportCategory,
                    city_id: dropdownValueCity,
                    birthdate: controllerDateTime.text.trim().isEmpty
                        ? null
                        : controllerDateTime.text.trim(),
                    countryId: dropdownValueCountry);
          },
          child: GridView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: Provider.of<FilterDataProvider>(context, listen: true)
                .listUsers
                .length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.70,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PlayerInformation(
                      userId: Provider.of<FilterDataProvider>(context,
                              listen: false)
                          .listUsers[index]
                          .id,
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
                          border: Border.all(width: 0, color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      child: columnMoreData(
                          context: context,
                          SportData: Provider.of<FilterDataProvider>(context,
                                  listen: false)
                              .listUsers[index])),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  SingleChildScrollView columnMoreData(
      {Users SportData, BuildContext context}) {
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
              radius: 10,
              backgroundImage: NetworkImage(
                SportData.role == null
                    ? SportData.avatar
                    : SportData.role.profileType.index == 1
                        ? SportData.clubDetails.icon
                        : SportData.avatar,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            SportData.role == null
                ? SportData.name
                : SportData.role.profileType.index == 1
                    ? SportData.clubDetails.name
                    : SportData.name,
            textAlign: TextAlign.center,
            maxLines: null,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
