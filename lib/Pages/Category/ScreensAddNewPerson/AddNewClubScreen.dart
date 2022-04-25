import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Pages/home/ProfileScreen.dart';
import 'package:cv_sports/Providers/CountryProvider.dart';
import 'package:cv_sports/Services/AllServices/ServiceAddNewProfile/serviceAddClubProfile.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:cv_sports/Widgets/Globle/InputFieldMake.dart';
import 'package:cv_sports/Widgets/Globle/seclectData.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddNewClubScreen extends StatefulWidget {

  String setRoleId;

  Users informationProfile;
  AddNewClubScreen({@required this.setRoleId , this.informationProfile});
  @override
  _AddNewClubScreenState createState() => _AddNewClubScreenState();
}

class _AddNewClubScreenState extends State<AddNewClubScreen> {



  TextEditingController controllerDateTime= TextEditingController();


  TextEditingController controllerName = TextEditingController();
  FocusNode focusName = new FocusNode();

  TextEditingController controllerPhone = TextEditingController();
  FocusNode focusPhone = new FocusNode();


  TextEditingController controllerPlace = TextEditingController();
  FocusNode focusPlace = new FocusNode();

  final formKey = GlobalKey<FormState>();


  String imageAvatar;
  //Holds image File
  File imageClub;
//ImagePicker instance.
  final picker = ImagePicker();

  Future getImage() async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imageAvatar = null;
      if (pickedFile != null) {
        imageClub = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  String dropdownValueCity;


  @override
  void initState() {
    if (widget.informationProfile != null) {
      //    dropdownValueNational = widget.informationProfile.extraDetails.nationality.name ;

      //     dropdownValueGameSelect= widget.informationProfile.sport.name;
      imageAvatar =  widget.informationProfile.clubDetails.icon;

      controllerDateTime.text =  widget.informationProfile.clubDetails.creationDate == null
          ? ""
          : DateFormat('yyyy-MM-dd').format(
          widget.informationProfile.clubDetails.creationDate);

      controllerPlace.text =
      widget.informationProfile.clubDetails.place == null
          ? ""
          : widget.informationProfile.clubDetails.place.toString();

      controllerName.text =
      widget.informationProfile.clubDetails.name == null
          ? ""
          : widget.informationProfile.clubDetails.name.toString();

      controllerPhone.text =
      widget.informationProfile.clubDetails.phone == null
          ? ""
          : widget.informationProfile.clubDetails.phone.toString();

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(0xffF9FAFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffF9FAFF),
          centerTitle: true,
          title: Text(
            "Complete the club information".tr(),
          //  style: TextStyle(fontSize: ScreenUtil().setSp(18)),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                InputImage(),

                InputFieldMake(
                  title: "Club name".tr(),
                  inputController: controllerName,
                  touchFocus: focusName,
                  iconInput: Icons.person,
                  validatorInput: (input) {
                    if (input.trim().length <= 0) {
                      return "Please put a name".tr();
                    } else if (input.trim().length <= 5) {
                      return "The name must not be less than 5 letters".tr();
                    }
                    return null;
                  },
                ),
                InputFieldMake(
                  title: "Club headquarters".tr(),
                  inputController: controllerPlace,
                  touchFocus: focusPlace,
                  iconInput: Icons.location_on,
                  validatorInput: (input) {
                    if (input.trim().length <= 0) {
                      return "Please put a name".tr();
                    } else if (input.trim().length <= 5) {
                      return "The name must not be less than 5 letters".tr();
                    }
                    return null;
                  },
                ),



                InputFieldMake(
                  title: "Club phone".tr(),
                  isNumber: true,
                  inputController: controllerPhone,
                  touchFocus: focusPhone,
                  iconInput: Icons.phone,
                  maxNumber: 18,
                  validatorInput: (input) {
                    return null;
                  },
                ),
                seclectDateTime(inputController: controllerDateTime,textHint: "تاريخ التاسيس",),

                  BottomApp(
                    title: "Update".tr(),
                  setCircular: 10,
                  functionButton: () {
                    if (widget.informationProfile != null) {
                      ServiceAddClubProfile()
                          .postUpdateClubProfile(
                              nameClub: controllerName.text.trim(),
                              placeClub: controllerPlace.text.trim(),
                              creationDate: controllerDateTime.text.trim(),
                              roleId: widget.setRoleId,
                              image: imageClub ,
                            phone: controllerPhone.text.trim()
                        ).then((value) {
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
                        })


                        ;
                      }


                    else  if (formKey.currentState.validate()){
                        if (imageClub==null) {
                          print("error");
                          BotToast.showText(
                            duration: Duration(seconds: 3),
                          text: "Please put a picture".tr(),
                          contentColor: Colors.blue,
                        );
                        } else {
                          ServiceAddClubProfile().postAddClubProfile(
                              nameClub: controllerName.text.trim(),
                              placeClub: controllerPlace.text.trim(),
                              creationDate: controllerDateTime.text.trim(),
                              roleId: widget.setRoleId,
                              image: imageClub,
                              phone: controllerPhone.text.trim()
                          ).then((value) {
                            if (value.statusCode == 201) {
                              print("done");
                              BotToast.showText(
                                duration: Duration(seconds: 3),
                              text: "successfully registered".tr(),
                              contentColor: Colors.blue,
                            );
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                    return ProfileScreen();
                                  }));
                            } else {
                              BotToast.showText(
                                duration: Duration(seconds: 3),
                                text: value.data["message"],
                                contentColor: Colors.blue,
                              );

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                    return ProfileScreen();
                                  }));
                            }
                          })


                          ;
                        }
                      }



                    },
                    setWidth: .8,
                    oneColor: Color(0xff2C2B53),
                    twoColor: Color(0xff2C2B53),
                    colorTitle: Colors.white,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }



  Row InputImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .25,
          height: MediaQuery.of(context).size.height * .12,
          child: ClipOval(
            child: Material(
              color: Color(0xffC7C9EA), // button color
              child: InkWell(
                splashColor: Colors.red, // inkwell color
                child:
                imageAvatar !=null? Image.network(imageAvatar ,fit:BoxFit.fill ,):

                imageClub==null?  SizedBox(
                    child: Icon(
                  Icons.shield,
                  color: Color(0xff68699C),
                  size: 50,
                )) : Image.file(imageClub,fit:BoxFit.fill ),
                onTap: ()=> getImage(),
              ),
            ),
          ),
        ),
      ],
    );
  }


}
