import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class InputPhone extends StatelessWidget {

  String countryCode = "+20";
  PhoneNumber numberPhone ;
  TextEditingController controllerInputPhone;
  String title;

  double setWidth;

  double setHeight;


  InputPhone({this.countryCode = "+20",@required this.numberPhone,@required this.controllerInputPhone ,@required this.title, this.setWidth = .85  ,this.setHeight = 0.075});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin:EdgeInsets.only(bottom: 10 ) ,
        alignment:Alignment.center ,

        width: MediaQuery.of(context).size.width *  setWidth,
        height: MediaQuery.of(context).size.height * setHeight ,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Icon(
              Icons.phone,
              color: Colors.black,
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              // flex: 3,
              child: InternationalPhoneNumberInput(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                },
                maxLength: 10,
                inputDecoration: InputDecoration(
                  hintText: title,
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DROPDOWN,
                  backgroundColor: Colors.white,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: numberPhone,
                textFieldController: controllerInputPhone,
                inputBorder: OutlineInputBorder(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
