import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/CountryApi.dart';
import 'package:cv_sports/Model/NationalityApi.dart';
import 'package:cv_sports/Model/SportApi.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Providers/CategoryProvider.dart';
import 'package:cv_sports/Providers/NationalityProvider.dart';
import 'package:cv_sports/Services/AllServices/ServiceAddNewProfile/serviceAddExtraProfile.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:cv_sports/Widgets/Globle/InputDropMenuById.dart';
import 'package:cv_sports/Widgets/Globle/InputFieldMake.dart';

import 'package:cv_sports/Widgets/Globle/seclectData.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:provider/provider.dart';

class AddnewExtraScreen extends StatefulWidget {
  String setRoleId;

  Users informationProfile;
  AddnewExtraScreen({@required this.setRoleId, this.informationProfile});

  @override
  _AddnewExtraScreenState createState() => _AddnewExtraScreenState();
}

class _AddnewExtraScreenState extends State<AddnewExtraScreen> {
  String dropdownValueNational;

  String dropdownValueGameSelect;

  TextEditingController controllerDateTime1 = TextEditingController();
  TextEditingController controllerDateTime2 = TextEditingController();

  TextEditingController controllerPlace = TextEditingController();
  FocusNode focusPlace = new FocusNode();

  TextEditingController controllerQualification = TextEditingController();
  FocusNode focusQualification = new FocusNode();

  @override
  void initState() {
    if (widget.informationProfile != null) {
      //    dropdownValueNational = widget.informationProfile.extraDetails.nationality.name ;

      //     dropdownValueGameSelect= widget.informationProfile.sport.name;
      print(("Data" + widget.informationProfile.toJson().toString()));

      controllerDateTime1.text =
          widget.informationProfile.extraDetails.contractStartDate == null
              ? ""
              : DateFormat('yyyy-MM-dd').format(
                  widget.informationProfile.extraDetails.contractStartDate);
      controllerDateTime2.text =
          widget.informationProfile.extraDetails.contractEndDate == null
              ? ""
              : DateFormat('yyyy-MM-dd').format(
                  widget.informationProfile.extraDetails.contractEndDate);
      print(widget.informationProfile.extraDetails.toJson());

      controllerPlace.text =
      widget.informationProfile.extraDetails.workPlace == null
          ? ""
              : widget.informationProfile.extraDetails.workPlace.toString();

      controllerQualification.text =
          widget.informationProfile.extraDetails.qualification == null
              ? ""
              : widget.informationProfile.extraDetails.qualification;

      dropdownValueGameSelect = widget.informationProfile.role.id.toString();

      dropdownValueNational =
          widget.informationProfile.extraDetails.nationality == null
              ? ""
              : widget.informationProfile.extraDetails.nationality.id
                  .toString();
    }

    Provider.of<CategoryProvider>(context, listen: false).getCategoriesData();
    Provider.of<NationalityProvider>(context, listen: false)
        .getNationalityData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<SportApi> dataGame =
        Provider.of<CategoryProvider>(context).listCategory;
    List<Nationality> dataCountry =
        Provider.of<NationalityProvider>(context).listNationality;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(0xffF9FAFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffF9FAFF),
          centerTitle: true,
          title: Text(
            "CompleteProfile".tr(),
          //  style: TextStyle(fontSize: ScreenUtil().setSp(18)),
          ),
        ),
        body: Provider.of<NationalityProvider>(context).loading ||
                Provider.of<CategoryProvider>(context).loading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    widget.informationProfile != null
                        ? Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 10),
                            // padding: EdgeInsets.symmetric(horizontal: 8),
                            width: MediaQuery.of(context).size.width * .85,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Row(
                              children: [
                                Text(
                                  "اللعبة : ",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),//"undefined"
                                widget.informationProfile.sport == null
                                    ? Text(
                                  "undefined".tr(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                                    : Text(
                                        widget.informationProfile.sport.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                              ],
                            ))
                        : InputDropMenuById(
                            onValueChanged: (value) {
                              dropdownValueGameSelect = value;
                            },
                            iconSelect: Icons.sports_volleyball,
                            dropdownValue: dropdownValueGameSelect,
                            listMenu: dataGame,
                            textHint: "the game".tr(),
                            setWidth: .85,
                          ),
                    InputFieldMake(
                      title: "Qualification".tr(),
                      inputController: controllerQualification,
                      touchFocus: focusQualification,
                      iconInput: Icons.article_outlined,
                      validatorInput: (input) {
                        if (input.trim().length <= 0) {
                          return "Please insert the qualification".tr();
                        } else if (input.trim().length <= 5) {
                          return "The qualification must not be less than 5 characters."
                              .tr();
                        }
                        return null;
                      },
                    ),
                    InputFieldMake(
                      title: "Workplace".tr(),
                      inputController: controllerPlace,
                      touchFocus: focusPlace,
                      iconInput: Icons.location_on,
                      validatorInput: (input) {
                        if (input.trim().length <= 0) {
                          return "Please put a name".tr();
                        } else if (input.trim().length <= 5) {
                          return "The name must not be less than 5 letters"
                              .tr();
                        }
                        return null;
                      },
                    ),
                    InputDropMenuById(
                      onValueChanged: (value) {
                        dropdownValueNational = value;
                      },
                      iconSelect: Icons.flag_outlined,
                      dropdownValue: dropdownValueNational,
                      listMenu: dataCountry,
                      textHint: "Nationality".tr(),
                      setWidth: .85,
                    ),
                    widget.setRoleId == "7"
                        ? Container()
                        : seclectDateTime(
                            inputController: controllerDateTime1,
                            textHint: "Beginning of the contract".tr()),
                    widget.setRoleId == "7"
                        ? Container()
                        : seclectDateTime(
                            inputController: controllerDateTime2,
                            textHint: "End of the contract".tr()),
                    SizedBox(
                      height: 10,
                    ),
                    BottomApp(
                      title: "Update".tr(),
                      setCircular: 10,
                      functionButton: () {
                        if (widget.informationProfile != null) {
                          print("Enter Edit done");
                          ServiceAddExtraProfile()
                              .postUpdateExtraProfile(
                            roleId: widget.setRoleId,
                            nationalityId: dropdownValueNational,
                            sportId: dropdownValueGameSelect,
                            //ereorr
                            qualification: controllerQualification.text.trim(),
                            workPlace: controllerPlace.text.trim(),
                            contractEndDate: controllerDateTime2.text.trim(),
                            contractStartDate: controllerDateTime1.text.trim(),
                          )
                              .then((value) {
                            if (value.statusCode == 201) {
                              print("done");
                              BotToast.showText(
                                duration: Duration(seconds: 3),
                                text: "Modified Successfully".tr(),
                                contentColor: Colors.blue,
                              );
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return MainScreen();
                              }));
                            } else {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return MainScreen();
                              }));
                            }
                          });
                        } else if (dropdownValueNational == null) {
                          BotToast.showText(
                            duration: Duration(seconds: 3),
                            text: "Please select a nationality".tr(),
                            contentColor: Colors.blue,
                          );
                        } else if (dropdownValueGameSelect == null) {
                          BotToast.showText(
                            duration: Duration(seconds: 3),
                            text: "من فضلك اختيار اللعبة",
                            contentColor: Colors.blue,
                          );
                        } else {
                          ServiceAddExtraProfile()
                              .postAddExtraProfile(
                            roleId: widget.setRoleId,
                            nationalityId: dropdownValueNational,
                            sportId: dropdownValueGameSelect,
                            qualification: controllerQualification.text.trim(),
                            workPlace: controllerPlace.text.trim(),
                            contractEndDate: controllerDateTime2.text.trim(),
                            contractStartDate: controllerDateTime1.text.trim(),
                          )
                              .then((value) {
                            if (value.statusCode == 201) {
                              print("done");
                              BotToast.showText(
                                duration: Duration(seconds: 3),
                                text: "successfully registered".tr(),
                                contentColor: Colors.blue,
                              );
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return MainScreen();
                              }));
                            } else {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return MainScreen();
                              }));
                            }
                          });

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return MainScreen();
                          }));
                        }
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
    );
  }
}
