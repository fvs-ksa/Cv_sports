import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/CustomDropMenu.dart';
import 'package:cv_sports/Model/NationalityApi.dart';
import 'package:cv_sports/Model/SportApi.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Providers/CategoryProvider.dart';
import 'package:cv_sports/Providers/NationalityProvider.dart';
import 'package:cv_sports/Services/AllServices/ServiceAddNewProfile/serviceAddPlayerProfile.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:cv_sports/Widgets/Globle/InputDropMenuById.dart';
import 'package:cv_sports/Widgets/Globle/InputDropMenuByName.dart';
import 'package:cv_sports/Widgets/Globle/InputFieldMake.dart';
import 'package:cv_sports/Widgets/Globle/seclectData.dart';
import 'package:fa_stepper/fa_stepper.dart';
import 'package:flutter/material.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'ClassForSavePlayerData.dart';
import 'FirstScreenComplate.dart';

class AddNewPlayerScreen extends StatefulWidget {
  String setRoleId;
  Users informationProfile;
  AddNewPlayerScreen({@required this.setRoleId, this.informationProfile});

  @override
  _AddNewPlayerScreenState createState() => _AddNewPlayerScreenState();
}

class _AddNewPlayerScreenState extends State<AddNewPlayerScreen> {
  String dropdownValue = 'kg';

  TextEditingController controllerHeight = TextEditingController();
  FocusNode focusHeight = new FocusNode();

  TextEditingController controllerWeight = TextEditingController();
  FocusNode focusWeight = new FocusNode();

  final formKey = GlobalKey<FormState>();
  String dropdownValueNational;
  void unFocus() {
    focusHeight.unfocus();

    focusWeight.unfocus();
  }

  String dropdownValueGamePractitioner;
  String dropdownValueGameSelect;

  TextEditingController textEditingControllerCv = TextEditingController();

  int maxLengthEnd = 255;

  int maxLengthStart = 255;
  TextEditingController controllerDateTime1 = TextEditingController();
  TextEditingController controllerDateTime2 = TextEditingController();

  TextEditingController controllerNameClub = TextEditingController();
  TextEditingController controllerNameGameWhere = TextEditingController();
  FocusNode focusClub = new FocusNode();
  FocusNode focusGameWhere = new FocusNode();

  List<CustomDropMenu> roleGame = [
    CustomDropMenu(id: 1, name: "right".tr()),
    CustomDropMenu(id: 2, name: "left".tr()),
    CustomDropMenu(id: 3, name: "Both sides".tr()),
    CustomDropMenu(id: 4, name: "undefined".tr()),
  ];

  bool SeclectBtn = true;
  int currentStep = 0;

  List<FAStep> listStepper = [
    // FAStep(
    //     title: Text(
    //       "بيانات شخصية",
    //       style:
    //           TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.black),
    //     ),
    //     content: FirstScreenComplate(),
    //     isActive: true),
    // FAStep(
    //     title: Text(
    //       "بيانات اللاعب",
    //       style:
    //           TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.black),
    //     ),
    //     content: SecondScreenComplate(),
    //     isActive: true),
  ];

  showExitAuthDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: new Text(
                "الانتهاء من التسجيل",
                style: TextStyle(//fontSize: ScreenUtil().setSp(18)
                ),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Text(
                    "تم ادخال بياناتك بنجاح",
                    style: TextStyle(
                        color: Color(0xff8E93A2),
                     //   fontSize: ScreenUtil().setSp(18)
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return MainScreen();
                      }));
                    },
                    child: Text(
                      "الذهاب للصفحة الرئسية",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                         // fontSize: ScreenUtil().setSp(18)
                          ),
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  void initState() {
    if (widget.informationProfile != null) {
      //    dropdownValueNational = widget.informationProfile.extraDetails.nationality.name ;

      //     dropdownValueGameSelect= widget.informationProfile.sport.name;

      controllerDateTime1.text =
          widget.informationProfile.playerDetails.contractStartDate == null
              ? ""
              : DateFormat('yyyy-MM-dd').format(
                  widget.informationProfile.playerDetails.contractStartDate);
      controllerDateTime2.text =
          widget.informationProfile.playerDetails.contractEndDate == null
              ? ""
              : DateFormat('yyyy-MM-dd').format(
                  widget.informationProfile.playerDetails.contractEndDate);

      controllerNameClub.text =
          widget.informationProfile.playerDetails.clubName == null
              ? ""
              : widget.informationProfile.playerDetails.clubName.toString();

      controllerNameGameWhere.text =
          widget.informationProfile.playerDetails.playerRole == null
              ? ""
              : widget.informationProfile.playerDetails.playerRole;

      textEditingControllerCv.text =
          widget.informationProfile.playerDetails.cv == null
              ? ""
              : widget.informationProfile.playerDetails.cv;

      //controllerWeight

      controllerHeight.text =
          widget.informationProfile.playerDetails.height == null
              ? ""
              : widget.informationProfile.playerDetails.height.toString();

      controllerWeight.text =
          widget.informationProfile.playerDetails.weight == null
              ? ""
              : widget.informationProfile.playerDetails.weight.toString();

      dropdownValueNational =
          widget.informationProfile.playerDetails.nationality == null
              ? null
              : widget.informationProfile.playerDetails.nationality.id
                  .toString();

      dropdownValueGamePractitioner =
          widget.informationProfile.playerDetails.playerStyle == null
              ? null
              : widget.informationProfile.playerDetails.playerStyle;

      dropdownValueGameSelect = widget.informationProfile.role.id.toString();
    }

    Provider.of<NationalityProvider>(context, listen: false)
        .getNationalityData();
    Provider.of<CategoryProvider>(context, listen: false).getCategoriesData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Nationality> data =
        Provider.of<NationalityProvider>(context).listNationality;
    List<SportApi> dataGame =
        Provider.of<CategoryProvider>(context).listCategory;

    return Provider.of<CategoryProvider>(context).loading ||
            Provider.of<NationalityProvider>(context).loading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            )),
          )
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "ComplateProfile".tr(),
                  style: TextStyle(
                  //(fontSize: ScreenUtil().setSp(18)
                  ),
                ),
                centerTitle: true,
              ),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputDropMenuById(
                        onValueChanged: (value) {
                          dropdownValueNational = value;
                        },
                        iconSelect: Icons.flag_outlined,
                        dropdownValue: dropdownValueNational,
                        listMenu: data,
                        textHint: "Nationality".tr(),
                        setWidth: .85,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      InputFieldMake(
                        title: "Length".tr(),
                        isNumber: true,
                        inputController: controllerHeight,
                        touchFocus: focusHeight,
                        iconInput: Icons.height,
                        maxNumber: 3,
                        validatorInput: (input) {
                          if (input.trim().length <= 0) {
                            return "Please put your height down".tr();
                          } else if (input.trim().length == 2) {
                            return "The length consists of 2 digits".tr();
                          }
                          return null;
                        },
                      ),

                      Center(child: InputWeight(context)),

                      InputFieldMake(
                        title: "Club / Academy".tr(),
                        inputController: controllerNameClub,
                        touchFocus: focusClub,
                        iconInput: Icons.person,
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
                      widget.informationProfile!=null?
                         Container(
                             alignment: Alignment.centerRight,
                             padding: EdgeInsets.all(10),
                             margin: EdgeInsets.only(top: 10),
                             // padding: EdgeInsets.symmetric(horizontal: 8),
                             width: MediaQuery.of(context).size.width    *.85,
                             decoration: BoxDecoration(
                                 color:  Colors.white,
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(color: Colors.grey.shade300)),

                             child: Row(
                               children: [
                                 Text("اللعبة : " ,style: TextStyle(fontSize: 18 ,color: Colors.grey),),
                                 Text(  widget.informationProfile.sport.name ,style: TextStyle(fontSize: 18 ,), ),
                               ],
                             )) :


                      InputDropMenuById(
                        onValueChanged: (value) {
                          dropdownValueGameSelect = value;
                        },
                        iconSelect: Icons.sports_volleyball,
                        dropdownValue: dropdownValueGameSelect,
                        listMenu: dataGame,
                        textHint: "the game".tr(),
                        setWidth: .85,
                      ),

                      InputDropMenuByName(
                        onValueChanged: (value) {
                          dropdownValueGamePractitioner = value;
                        },
                        iconSelect: Icons.sports,
                        dropdownValue: dropdownValueGamePractitioner,
                        listMenu: roleGame,
                        textHint: "Play the game".tr(),
                        setWidth: .85,
                      ),

                      InputFieldMake(
                        title: "Player Center".tr(),
                        inputController: controllerNameGameWhere,
                        touchFocus: focusGameWhere,
                        iconInput: Icons.gamepad,
                        validatorInput: (input) {
                          return null;
                        },
                      ),
                      seclectDateTime(
                          inputController: controllerDateTime1,
                          textHint: "Beginning of the contract".tr()),
                      seclectDateTime(
                          inputController: controllerDateTime2,
                          textHint: "End of the contract".tr()),

                      Container(
                        height: MediaQuery.of(context).size.height * .16,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          textAlign: TextAlign.start,
                          maxLines: null,
                          maxLength: maxLengthStart,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.2,
                            color: Colors.black,
                          ),
                          controller: textEditingControllerCv,
                          onChanged: (value) {
                            setState(() {
                              maxLengthEnd = maxLengthStart - value.length;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(
                             //     fontSize: ScreenUtil().setSp(18)
                                ),
                            hintText: "CV".tr(),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        child: Text(
                          maxLengthEnd.toString(),
                          style: TextStyle(
                   //         fontSize: ScreenUtil().setSp(18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BottomApp(
                        title: "Update".tr(),
                        setCircular: 10,
                        functionButton: () {
                          if (widget.informationProfile != null) {
                            print(
                                " club name " + controllerNameClub.text.trim());
                            ServiceAddPlayerProfile()
                                .postUpdatePlayerProfile(
                              setHeight: controllerHeight.text.trim(),
                              setWeight: controllerWeight.text.trim(),
                              setNational: dropdownValueNational,
                              setWeightUnit: dropdownValue.trim(),
                              setGamePractitioner:
                                  dropdownValueGamePractitioner,
                              setGameSelect: dropdownValueGameSelect,
                              setDateTime1SecondScreen:
                                  controllerDateTime1.text.trim(),
                              setDateTime2SecondScreen:
                                  controllerDateTime2.text.trim(),
                              setNameClub: controllerNameClub.text.trim(),
                              setRoleId: widget.setRoleId,
                              setCvText: textEditingControllerCv.text.trim(),
                              setNameGameWhere:
                                  controllerNameGameWhere.text.trim(),
                            )
                                .then((value) {
                              if (value.statusCode == 201) {
                                print("done");

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return MainScreen();
                                }));
                              } else {
                                print("error");
                                BotToast.showText(
                                  duration: Duration(seconds: 3),
                                  text: value.data["message"].toString(),
                                  contentColor: Colors.blue,
                                );
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return MainScreen();
                                }));
                              }
                            });
                          } else if (formKey.currentState.validate()) {
                            print(
                                " club name " + controllerNameClub.text.trim());
                            ServiceAddPlayerProfile()
                                .postAddPlayerProfile(
                              setHeight: controllerHeight.text.trim(),
                              setWeight: controllerWeight.text.trim(),
                              setNational: dropdownValueNational,
                              setWeightUnit: dropdownValue.trim(),
                              setGamePractitioner:
                                  dropdownValueGamePractitioner,
                              setGameSelect: dropdownValueGameSelect,
                              setDateTime1SecondScreen:
                                  controllerDateTime1.text.trim(),
                              setDateTime2SecondScreen:
                                  controllerDateTime2.text.trim(),
                              setNameClub: controllerNameClub.text.trim(),
                              setRoleId: widget.setRoleId,
                              setCvText: textEditingControllerCv.text.trim(),
                              setNameGameWhere:
                                  controllerNameGameWhere.text.trim(),
                            )
                                .then((value) {
                              if (value.statusCode == 201) {
                                print("done");

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return MainScreen();
                                }));
                              } else {
                                print("error");
                                BotToast.showText(
                                  duration: Duration(seconds: 3),
                                  text: value.data["message"].toString(),
                                  contentColor: Colors.blue,
                                );
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return MainScreen();
                                }));
                              }
                            });
                          }
                        },
                        setWidth: .8,
                        oneColor: Color(0xff2C2B53),
                        twoColor: Color(0xff2C2B53),
                        colorTitle: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // BottomApp(
                      //   title: "حفظ المدخلات",
                      //   setCircular: 10,
                      //   functionButton: () {
                      //     if (formKey.currentState.validate()) {
                      //
                      //
                      //       if(dropdownValueGamePractitioner ==null){
                      //         BotToast.showText(
                      //           text: "يرجى اختيار ممارسة اللعبة",
                      //           contentColor: Colors.blue,
                      //         );
                      //       }else if(dropdownValueGameSelect == null){
                      //         BotToast.showText(
                      //           text: "يرجى اختيار  اللعبة",
                      //           contentColor: Colors.blue,
                      //         );
                      //       }
                      //
                      //       else{
                      //         ClassForSavePlayerData.setGamePractitioner = dropdownValueGamePractitioner.trim();
                      //         ClassForSavePlayerData.setGameSelect = dropdownValueGameSelect.trim();
                      //         ClassForSavePlayerData.setDateTime1SecondScreen = controllerDateTime1.text.trim();
                      //         ClassForSavePlayerData.setDateTime2SecondScreen = controllerDateTime2.text.trim();
                      //         ClassForSavePlayerData.setCvText = textEditingController.text.trim();
                      //         ClassForSavePlayerData.setNameClub = controllerNameClub.text.trim();
                      //         ClassForSavePlayerData.setNameGameWhere = controllerNameGameWhere.text.trim();
                      //         BotToast.showText(
                      //           text: "تم الحفظ",
                      //           contentColor: Colors.blue,
                      //         );
                      //       }
                      //
                      //
                      //     }
                      //   },
                      //   setWidth: .4,
                      //   oneColor: Color(0xff2C2B53),
                      //   twoColor: Color(0xff2C2B53),
                      //   colorTitle: Colors.white,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
/*
  FAStepper buildFaStepper() {
    return FAStepper(
      currentStep: currentStep,
      // List the steps you would like to have
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return BottomApp(
          title: "Update".tr(),
          setCircular: 10,
          functionButton: () {
            StepContinue();
          },
          setWidth: .8,
          oneColor: Color(0xff2C2B53),
          twoColor: Color(0xff2C2B53),
          colorTitle: Colors.white,
        );
      },

      onStepContinue: () {
        StepContinue();
      },

      titleHeight: MediaQuery.of(context).size.height * .11,
      steps: listStepper,

      type: FAStepperType.horizontal,
      titleIconArrange: FAStepperTitleIconArrange.column,
      stepNumberColor: Color(0xff2C2B53),
      onStepTapped: (step) {
        setState(() {
          currentStep = step;
        });
      },
    );
  }
*/
  void StepContinue() {
    setState(() {
      if (currentStep < listStepper.length - 1) {
        currentStep = currentStep + 1;
      } else {
        ServiceAddPlayerProfile()
            .postAddPlayerProfile(
          setHeight: ClassForSavePlayerData().getHeight(),
          setWeight: ClassForSavePlayerData().getWeight(),
          setNational: ClassForSavePlayerData().getNational(),
          setWeightUnit: ClassForSavePlayerData().getWeightUnit(),
          setGamePractitioner: ClassForSavePlayerData().getGamePractitioner(),
          setGameSelect: ClassForSavePlayerData().getGameSelect(),
          setDateTime1SecondScreen: ClassForSavePlayerData().getDateTime1(),
          setDateTime2SecondScreen: ClassForSavePlayerData().getDateTime2(),
          setNameClub: ClassForSavePlayerData().getNameClub(),
          setRoleId: widget.setRoleId,
          setCvText: ClassForSavePlayerData().getCvText(),
          setNameGameWhere: ClassForSavePlayerData().getNameGameWhere(),
        )
            .then((value) {
          if (value.statusCode == 201) {
            print("done");
            ClassForSavePlayerData().removeAllValues();

            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return MainScreen();
            }));
          } else {
            print("error");
            BotToast.showText(
              duration: Duration(seconds: 3),
              text: value.data["message"].toString(),
              contentColor: Colors.blue,
            );
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return MainScreen();
            }));
          }
        });
      }
    });
  }

//========================= Widget Input Weight ================================

  Container InputWeight(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputFieldMake(
            title: "weight".tr(),
            setWidth: .55,
            isNumber: true,
            maxNumber: 3,
            inputController: controllerWeight,
            touchFocus: focusWeight,
            iconInput: Icons.anchor,
            validatorInput: (input) {
              if (input.trim().length <= 0) {
                return "Please put weight.".tr();
              } else if (input.trim().length <= 1) {
                return "Weight must not be less than 2 letters".tr();
              }
              return null;
            },
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300)),
            child: DropdownButton(
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down, color: Color(0xff2C2B53)),
              iconSize: 24,
              elevation: 16,
              //      style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                //         color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['kg', 'pd']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                         // fontSize: ScreenUtil().setSp(16), color: Colors.grey
                         ),
                    ));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
