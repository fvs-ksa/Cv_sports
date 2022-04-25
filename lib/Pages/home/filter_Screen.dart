import 'package:cv_sports/Model/CityApi.dart';
import 'package:cv_sports/Model/CountryApi.dart';
import 'package:cv_sports/Model/SportApi.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/Category/PlayerInfomation.dart';
import 'package:cv_sports/Pages/home/filter_SereenGet.dart';
import 'package:cv_sports/Providers/CategoryProvider.dart';
import 'package:cv_sports/Providers/CountryProvider.dart';
import 'package:cv_sports/Providers/FilterDataProvider.dart';
import 'package:cv_sports/Services/AllServices/serviceCityGet.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:cv_sports/Widgets/Globle/InputDropMenuById.dart';
import 'package:cv_sports/Widgets/Globle/seclectData.dart';
import 'package:cv_sports/Widgets/Globle/seclectDataByYear.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<CityApi> listCity = [];

  final filterController = TextEditingController();

  TextEditingController controllerDateTime = TextEditingController();
  TextEditingController controllerTextInput = TextEditingController();
  String dropdownValueCity;
  String dropdownValueCountry;
  String dropdownValueSportCategory;

//=================  Function _ Gat Category Api ========================
  Future<void> fetchCityApi({String countryId}) async {
    // clear old data

    //get new data
    Response response = await ServiceCityGet().getCity(countryId: countryId);
    listCity = [];
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listCity.add(CityApi.fromJson(element));
      });
      print("listCity = " + listCity.length.toString());
    } else {
      listCity = [];
    }
  }

  @override
  void initState() {
    Provider.of<FilterDataProvider>(context, listen: false).listUsers.clear();
    Provider.of<CountryProvider>(context, listen: false).getCountryData();
    Provider.of<CategoryProvider>(context, listen: false).getCategoriesData();
    super.initState();
  }

  DateTime _selectedDat = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<CountryApi> listCountry =
        Provider.of<CountryProvider>(context).listCountry;
    List<SportApi> dataSportCategory =
        Provider.of<CategoryProvider>(context).listCategory;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text("advanced search".tr()),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                //_________________________________search container

                InputNamePlayer(context),
                Provider.of<CategoryProvider>(context).loading
                    ? Center(
                        child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ))
                    : InputDropMenuById(
                        onValueChanged: (value) {
                          setState(() {
                            dropdownValueSportCategory = value;
                          });
                        },
                        iconSelect: Icons.sports_volleyball,
                        dropdownValue: dropdownValueSportCategory,
                        listMenu: dataSportCategory,
                        textHint: "the games".tr(),
                        setWidth: .85,
                      ),
                //   ColumnCityAndCountry(context, listCountry),

                ScerchCountry(context, listCountry),

                // seclectDataByYear(
                //   runValidator: true,
                //   inputController: controllerDateTime,
                //   textHint: "date of Birth".tr(),
                // ),

                // FlatButton(onPressed: (){
                //   showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: Text("Select Year"),
                //         content: Container( // Need to use container to add size constraint.
                //           width: 300,
                //           height: 300,
                //           child: YearPicker(
                //             firstDate: DateTime(DateTime.now().year - 100, 1),
                //             lastDate: DateTime(DateTime.now().year + 100, 1),
                //            // initialDate: DateTime.now(),
                //             // save the selected date to _selectedDate DateTime variable.
                //             // It's used to set the previous selected date when
                //             // re-showing the dialog.
                //             selectedDate:DateTime.now() ,
                //             onChanged: (DateTime dateTime) {
                //               // close the dialog when year is selected.
                //               print(dateTime.year);
                //               Navigator.pop(context);
                //
                //               // Do something with the dateTime selected.
                //               // Remember that you need to use dateTime.year to get the year
                //             },
                //           ),
                //         ),
                //       );
                //     },
                //   );
                //
                // }, child: Text("fsadas"),),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Select Year"),
                          content: Container(
                            // Need to use container to add size constraint.
                            width: 300,
                            height: 300,
                            child: YearPicker(
                              firstDate: DateTime(DateTime.now().year - 100, 1),
                              lastDate: DateTime(DateTime.now().year + 100, 1),
                              // initialDate: DateTime.now(),
                              // save the selected date to _selectedDate DateTime variable.
                              // It's used to set the previous selected date when
                              // re-showing the dialog.
                              selectedDate: _selectedDat,
                              onChanged: (DateTime dateTime) {
                                setState(() {
                                  // close the dialog when year is selected.
                                  print(dateTime.year);
                                  print("datae");
                                  _selectedDat = dateTime;
                                  print(_selectedDat);
                                });

                                Navigator.pop(context);

                                // Do something with the dateTime selected.
                                // Remember that you need to use dateTime.year to get the year
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              children: [
                                Icon(Icons.date_range,
                                    color: Color(0xff2C2B53)),
                                Text(
                                  _selectedDat.year.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 30,
                          color: Color(0xff2C2B53),
                        ),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
                ),
                BottomApp(
                  title: "Search".tr(),
                  setCircular: 10,
                  functionButton: () async {
                    print("dropdownValueCity");
                    print(dropdownValueCity);
                    if (dropdownValueCountry == null) {
                      dropdownValueCity = null;
                    }
                    await Provider.of<FilterDataProvider>(context,
                            listen: false)
                        .getFilterData(
                            name: controllerTextInput.text.trim().isEmpty
                                ? null
                                : controllerTextInput.text.trim(),
                            sport_id: dropdownValueSportCategory,
                            city_id: dropdownValueCity,
                            birthdate: _selectedDat.year.toString(),
                            countryId: dropdownValueCountry);
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => filter_SereenGet(
                        controllerDateTime: controllerDateTime,
                        controllerTextInput: controllerTextInput,
                        dropdownValueCity: dropdownValueCity,
                        dropdownValueCountry: dropdownValueCountry,
                        dropdownValueSportCategory: dropdownValueSportCategory,
                      ), //Register //LogIn
                    ));
                  },
                  setWidth: .8,
                  oneColor: Color(0xff2C2B53),
                  twoColor: Color(0xff2C2B53),
                  colorTitle: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column ScerchCountry(BuildContext context, List<CountryApi> listCountry) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          //  padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(
            top: 20,
          ),
          // padding: EdgeInsets.symmetric(horizontal: 8),
          width: MediaQuery.of(context).size.width * .85,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black45)),
          child: SearchableDropdown.single(
            items: listCountry.map<DropdownMenuItem>((value) {
              return DropdownMenuItem<String>(
                  value: value.name,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.flag_outlined,
                        color: Color(0xff2C2B53),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        value.name,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ));
            }).toList(),
            value: dropdownValueCountry,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Color.fromRGBO(29, 174, 209, 1),
              size: 35,
            ),
            underline: Container(
              height: 0,
              color: Colors.white,
            ),
            searchHint: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.flag_outlined,
                  color: Color(0xff2C2B53),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "اختار الدولة",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            hint: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.flag_outlined,
                  color: Color(0xff2C2B53),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "اختار الدولة",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            onChanged: (value) {
              dropdownValueCity = null;
              listCity.clear();
              dropdownValueCountry = value;
              print(dropdownValueCountry);
              if (dropdownValueCountry != null) {
                CountryApi city = listCountry.firstWhere(
                    (c) => c.name.trim() == dropdownValueCountry.trim());

                print(city.id);
                dropdownValueCountry = city.id.toString();
              } else {
                print(dropdownValueCountry);
                // setState(() {
                //   dropdownValueCountry = null;
                //   dropdownValueCity = null;
                //   listCity.clear();
                // });
                setState(() {});
              }
            },
            isExpanded: true,
          ),
        ),
        dropdownValueCountry != null
            ? FutureBuilder(
                future: fetchCityApi(countryId: dropdownValueCountry),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Column(
                    children: [
                      listCity.isNotEmpty
                          ? InputDropMenuById(
                              onValueChanged: (value) {
                                dropdownValueCity = value;
                              },

                              iconSelect: Icons.flag_outlined,
                              dropdownValue: dropdownValueCity,
                              listMenu: listCity,
                              //listCity
                              textHint: "City".tr(),
                              setWidth: .85,
                            )
                          : Container(),
                    ],
                  );
                },
              )
            : Container(),
      ],
    );
  }
// ================= ColumnCityAndCountry ====================

  Column ColumnCityAndCountry(
      BuildContext context, List<CountryApi> ListCountry) {
    return Column(
      children: [
        Provider.of<CountryProvider>(context).loading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ))
            : InputDropMenuById(
                onValueChanged: (value) {
                  setState(() {
                    dropdownValueCountry = value;
                  });
                },
                iconSelect: Icons.location_on,
                dropdownValue: dropdownValueCountry,
                listMenu: ListCountry,
                textHint: "Country".tr(),
                setWidth: .85,
              ),
        dropdownValueCountry != null
            ? FutureBuilder(
                future: fetchCityApi(countryId: dropdownValueCountry),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return InputDropMenuById(
                    onValueChanged: (value) {
                      dropdownValueCity = value;
                    },

                    iconSelect: Icons.flag_outlined,
                    dropdownValue: dropdownValueCity,
                    listMenu: listCity,
                    //listCity
                    textHint: "City".tr(),
                    setWidth: .85,
                  );
                },
              )
            : Container(),
      ],
    );
  }

// ================= InputNamePlayer ====================
  Container InputNamePlayer(BuildContext context) {
    return Container(
      width: .85 * MediaQuery.of(context).size.width,
      child: TextFormField(
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        controller: controllerTextInput,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              controllerTextInput.clear();
            },
            child: Icon(
              Icons.clear,
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          //         border: InputBorder.none,
          hintText: "Search".tr(),

          hintStyle: TextStyle(fontSize: 18, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
