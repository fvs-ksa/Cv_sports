import 'package:flutter/material.dart';

class InputDropMenuByName extends StatefulWidget {
  String dropdownValue ;
  double setWidth;
  double setHeight;

  var iconSelect;
  ValueChanged<String> onValueChanged;
  List listMenu;
  String textHint;


  InputDropMenuByName(
      {@required this.dropdownValue,@required  this.iconSelect, this.onValueChanged ,this.setWidth = .85, this.setHeight = 0.085,@required this.listMenu,@required this.textHint});

  @override
  _InputDropMenuByNameState createState() => _InputDropMenuByNameState();
}

class _InputDropMenuByNameState extends State<InputDropMenuByName> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10, ),
          // padding: EdgeInsets.symmetric(horizontal: 8),
          width: MediaQuery.of(context).size.width *  widget. setWidth,
          height: MediaQuery.of(context).size.height * widget.setHeight ,//65
          decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300)),
          child: DropdownButton(
            value:widget. dropdownValue,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: Color(0xff2C2B53),),
            iconSize: 24,

            //      style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              //         color: Colors.deepPurpleAccent,
            ),


            //
            onChanged: (v){
              print("v = "+v.toString());
              setState(() {
                widget.dropdownValue = v;
              });
              // to can sent value to other class
              widget.onValueChanged(v);

            },
            hint: Row(
              children: [
                SizedBox(width: 5,),
                Icon(widget.iconSelect , color: Color(0xff2C2B53),),
                SizedBox(width: 5,),
                Text(
                  widget. textHint,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey),
                ),
              ],
            ),
            items:widget. listMenu
                .map<DropdownMenuItem>(( value) {
              return DropdownMenuItem<String>(
                  value: value.name.toString(),
                  child: Row(
                    children: [
                      SizedBox(width: 5,),
                      Icon(widget.iconSelect , color: Color(0xff2C2B53),),
                      SizedBox(width: 5,),
                      Text(
                        value.name,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ],
                  ));
            }).toList(),
          ),
        ),


      ],
    );
  }
}
