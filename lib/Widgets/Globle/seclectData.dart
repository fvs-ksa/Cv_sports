import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class seclectDateTime extends StatelessWidget {
  double setWidth;
  double setHeight;
  String textHint;
  var inputController;
  bool runValidator;

  seclectDateTime(
      {this.setHeight = 0.08,
        this.runValidator = true,
        this.setWidth = 0.85,
        @required this.textHint,
        @required this.inputController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * setWidth,
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
            child: DateTimeField(
              controller: inputController,
              validator: (date) => runValidator
                  ? (date == null ? "Please enter the date".tr() : null)
                  : null,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1940),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              format: DateFormat("yyyy-MM-dd"),
              style: TextStyle(
        //        fontSize: ScreenUtil().setSp(18),
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.date_range, color: Color(0xff2C2B53)),
                border: InputBorder.none,
                hintText: textHint,

                hintStyle: TextStyle(
               //     fontSize: ScreenUtil().setSp(18), color: Colors.grey
              ),
                //    labelText: "date of Birth".tr(),
                //        labelStyle: TextStyle(fontSize: 18, color: Colors.grey.shade700),
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
    );
  }
}
