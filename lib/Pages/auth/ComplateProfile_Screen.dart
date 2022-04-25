import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/CityApi.dart';
import 'package:cv_sports/Model/CountryApi.dart';
import 'package:cv_sports/Model/RolesSport%D9%90Api%D9%90%D9%90.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Providers/CountryProvider.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:cv_sports/Providers/RolesSportProvider.dart';
import 'package:cv_sports/Services/AllServices/serviceCityGet.dart';
import 'package:cv_sports/Services/AllServices/serviceInformationUserUpdate.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:cv_sports/Widgets/Auth/CardSelected.dart';
import 'package:cv_sports/Widgets/Globle/InputDropMenuById.dart';
import 'package:cv_sports/Widgets/Globle/InputFieldMake.dart';
import 'package:cv_sports/Widgets/Globle/seclectData.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ComplateProfileScreen extends StatefulWidget {
  
  bool titleAppbarChange ;


  ComplateProfileScreen({this.titleAppbarChange = false});

  @override
  _ComplateProfileScreenState createState() => _ComplateProfileScreenState();
}

class _ComplateProfileScreenState extends State<ComplateProfileScreen> {
  bool selectBtn = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  FocusNode focusName = new FocusNode();

  TextEditingController controllerPhone1 = TextEditingController();
  FocusNode focusPhone1 = new FocusNode();

  TextEditingController controllerPhone2 = TextEditingController();
  FocusNode focusPhone2 = new FocusNode();

  TextEditingController controllerDateTime = TextEditingController();
  String dropdownValueCity;
  String dropdownValueNational;
  String dropdownValueSport;

  List<CityApi> listCity = [];
  Future futureCountry;

  void unFocus() {
    focusPhone1.unfocus();
    focusPhone2.unfocus();
    focusName.unfocus();
  }
  //Holds image File
  File imageClub;
  bool loadData = false;
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
//=================  Function _ Gat Category Api ========================
  Future<void> fetchCityApi({String countryId}) async {
    // clear old data
    listCity = [];
    //get new data
    Response response = await ServiceCityGet().getCity(countryId: countryId);

    if (response.statusCode == 200) {
      listCity = [];
      response.data.forEach((element) {
        listCity.add(CityApi.fromJson(element));
      });
    } else {
      listCity = [];
    }
  }
  String imageAvatar;
  @override
  void initState() {
    Users  informationProfile =
        Provider.of<InformationMyProfileProvider>(context , listen: false).listInformationUser;

    if (informationProfile != null &&widget. titleAppbarChange ) {
      //    dropdownValueNational = widget.informationProfile.extraDetails.nationality.name ;

      //     dropdownValueGameSelect= widget.informationProfile.sport.name;
      print(informationProfile.gender);
       selectBtn =informationProfile.gender==null?   true:             informationProfile.gender.index ==0? true :false;
      imageAvatar =  informationProfile.avatar;

      controllerDateTime.text = informationProfile.birthdate == null
          ? ""
          : DateFormat('yyyy-MM-dd').format(
          informationProfile.birthdate);

      controllerName.text = informationProfile.name== null
          ? ""
          : informationProfile.name;


   //   print("id = "+informationProfile.country.id.toString());

       dropdownValueNational = informationProfile.country== null
           ? null
           : informationProfile.country.id.toString();

       dropdownValueCity  = informationProfile.city== null
           ? null
           : informationProfile.city.id.toString();

      controllerPhone1.text = informationProfile.phoneOne== null
          ? ""
          : informationProfile.phoneOne;
      controllerPhone2.text = informationProfile.phoneTwo== null
          ? ""
          : informationProfile.phoneTwo;
    }




    Provider.of<RolesSportProvider>(context, listen: false)
        .getRolesSportData();

    Provider.of<CountryProvider>(context, listen: false).getCountryData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CountryApi> data = Provider.of<CountryProvider>(context).listCountry;
    List<RolesSport> dataSport = Provider.of<RolesSportProvider>(context).listRolesSport;

    return
    GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
         widget.titleAppbarChange
                ? "EditCompleteProfile".tr()
                : "CompleteProfile".tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Provider.of<CountryProvider>(context).loading
            ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ))
            :SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                InputImage(),
                SizedBox(height: 10,),
                CardSelected(
                  onValueChanged: (value){

                    selectBtn =value;
                  },
                selectBtn:selectBtn ,
                ),
                InputFieldMake(
                  title: "UserName".tr(),
                        inputController: controllerName,
                        touchFocus: focusName,
                        iconInput: Icons.person,
                        validatorInput: (input) {
                          return null;
                        },
                      ),






                seclectDateTime(
                  runValidator: false,
                  inputController: controllerDateTime,
                  textHint: "date of Birth".tr(),
                ),

                Column(
                  children: [
                    InputDropMenuById(
                      onValueChanged: (value) {
                        setState(() {
                          print("api");
                          dropdownValueNational =null;
                          listCity = [];
                                dropdownValueCity = null;
                                dropdownValueNational = value;
                              });
                            },
                            iconSelect: Icons.location_on,
                            dropdownValue: dropdownValueNational,
                            listMenu: data,
                            textHint: "Country".tr(),
                            setWidth: .85,
                          ),


                    dropdownValueNational != null
                        ? FutureBuilder(
                            future: fetchCityApi(countryId: dropdownValueNational),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    print("Enter");

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
                ),
                InputFieldMake(
                  title: "Contact number 1".tr(),
                        isNumber: true,
                        inputController: controllerPhone1,
                        touchFocus: focusPhone1,
                        iconInput: Icons.phone,
                        maxNumber: 18,
                        validatorInput: (input) {
                          return null;
                        },
                      ),




                InputFieldMake(
                  title: "Contact number 2".tr(),
                        isNumber: true,
                        inputController: controllerPhone2,
                        touchFocus: focusPhone2,
                        iconInput: Icons.phone,
                        maxNumber: 18,
                        validatorInput: (input) {
                          return null;
                        },
                      ),
                BottomApp(
                  title: "Update".tr(),
                        setCircular: 10,
                        functionButton: () {
                          if (formKey.currentState.validate()) {
                            ServiceInformationUserUpdate()
                                .postInformationUserUpdate(
                                    birthdate: controllerDateTime.text,
                                    image: imageClub,
                                    cityId: dropdownValueCity != null
                                        ? int.parse(dropdownValueCity)
                                        : null,
                                    countryId: dropdownValueNational!=null? int.parse(dropdownValueNational) : null,
                        gender: selectBtn ? "male" : "female",
                        phone_one: controllerPhone1.text.trim(),
                        phone_two: controllerPhone2.text.trim(),
                        userName: controllerName.text.trim()
                      )
                          .then((value) {
                        if (value.data["user"] == null) {
                          BotToast.showText(
                            text: value.data["errors"],
                            contentColor: Colors.blue,
                          );
                        } else {
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
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
//==================== InputImage ====================
  Row InputImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .28,
          height: MediaQuery.of(context).size.height * .145,
          child: ClipOval(
            child: Material(
              color: Colors.black12, // button color
              child: InkWell(
                splashColor: Colors.red,
                // inkwell color
                child:
                imageAvatar !=null? Image.network(imageAvatar ,fit:BoxFit.fill ,):
                imageClub==null?   SizedBox(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    )) : Image.file(imageClub , fit:BoxFit.fill ,),
                onTap: ()=> getImage(),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
