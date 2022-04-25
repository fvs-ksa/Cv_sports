
import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/NationalityApi.dart';
import 'package:cv_sports/Providers/NationalityProvider.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:cv_sports/Widgets/Globle/InputDropMenuById.dart';
import 'package:cv_sports/Widgets/Globle/InputFieldMake.dart';
import 'package:cv_sports/Widgets/Globle/seclectData.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'ClassForSavePlayerData.dart';


class FirstScreenComplate extends StatefulWidget {
  @override
  _FirstScreenComplateState createState() => _FirstScreenComplateState();
}

class _FirstScreenComplateState extends State<FirstScreenComplate> {


  String dropdownValue = 'kg';


  TextEditingController controllerHeight = TextEditingController();
  FocusNode focusHeight = new FocusNode();

  TextEditingController controllerWeight = TextEditingController();
  FocusNode focusWeight = new FocusNode();


  TextEditingController controllerNational = TextEditingController();
  FocusNode focusNational  = new FocusNode();
  final formKey = GlobalKey<FormState>();
  String dropdownValueNational;
  void unFocus() {
    focusHeight.unfocus();
    focusNational.unfocus();
    focusWeight.unfocus();
  }
  @override
  void initState() {
    Provider.of<NationalityProvider>(context, listen: false).getNationalityData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Nationality> data = Provider.of<NationalityProvider>(context).listNationality;

    return  Provider.of<NationalityProvider>(context).loading
        ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ))
        : Form(
      key: formKey,
      child: Column(
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
                    } else if (input.trim().length == 2 ) {
                  return "The length consists of 2 digits".tr();
                    }
                return null;
              },
            ),

            InputWeight(context),
            BottomApp(
              title: "حفظ المدخلات",
              setCircular: 10,
              functionButton: () {
                if (formKey.currentState.validate()) {


                  if(dropdownValueNational ==null){
                    BotToast.showText(
                      text: "يرجى اختيار الجنسية",
                      contentColor: Colors.blue,
                    );
                  }else{
                    ClassForSavePlayerData.setHeight = controllerHeight.text.trim();
                    ClassForSavePlayerData.setWeight = controllerWeight.text.trim();
                    ClassForSavePlayerData.setNational = dropdownValueNational.trim();

                    ClassForSavePlayerData.setWeightUnit = dropdownValue.trim();
                    BotToast.showText(
                      text: "تم الحفظ",
                      contentColor: Colors.blue,
                    );
                  }

                }
              },
              setWidth: .4,
              oneColor: Color(0xff2C2B53),
              twoColor: Color(0xff2C2B53),
              colorTitle: Colors.white,
            ),
          ],
        ),
    );
  }


//========================= Widget Input Weight ================================

  Container InputWeight(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
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
