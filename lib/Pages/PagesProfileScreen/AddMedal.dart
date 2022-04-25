// "اضافة او تعديل ميداليات",
import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Services/AllServices/serviceAddPrizeAndMedal.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'EditMedal.dart';

class AddMedal extends StatefulWidget {
  @override
  _AddMedalState createState() => _AddMedalState();
}

class _AddMedalState extends State<AddMedal> {
  int quantity = 0;

  List<String> nameMedal = List(4);

  List<int> quantityMedal = List(4);

  bool uploadData = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return EditMedal();
            }));
          },
          child: const Icon(Icons.edit_rounded),
        ),
        backgroundColor: Color(0xffF9FAFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffF9FAFF),
          centerTitle: true,
          title: Text(
            "Add or modify medals".tr(),
            style: TextStyle(
            //  fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: uploadData
            ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ))
            :  SingleChildScrollView(
          child: Column(
            children: [

              ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context , index){
                    if(quantityMedal [index] ==null){
                      quantityMedal [index]= 0;
                    }

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey.shade300)),
                              child: TextField(
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                //  fontSize: ScreenUtil().setSp(18),
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                onChanged: (v){
                                  nameMedal[index] = v.trim();
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                   //       fontSize: ScreenUtil().setSp(16),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        hintText: "Name Medals".tr(),
                                      ),
                              ),
                            ),
                          ),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300)),
                            child: Row(

                              children: [
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      quantityMedal [index] ++;
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 15),
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.blue,
                                        size: 20,
                                      )),
                                ),
                                Container(
                                  child: Text(
                                      quantityMedal [index]==null? "0"   :   quantityMedal [index].toString()),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (quantityMedal [index] >= 1)
                                      setState(() {
                                        quantityMedal [index]--;
                                      });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          right: 15),
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.blue,
                                        size: 20,
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),


              BottomApp(
                title: "Update".tr(),
                setCircular: 10,
                functionButton: () {
                  setState(() {
                    uploadData = true;
                  });

                  List<Map> mapMedal = [];

                  for(int i =0 ; i<nameMedal.length ;i++){
                    if(quantityMedal[i] !=0 &&  nameMedal[i] !=null) {
                      mapMedal.add({
                        "medal" : nameMedal[i],
                        "count" : quantityMedal[i]
                      });
                    }
                  }
                  print(mapMedal .toString() + " = List");

                  if((mapMedal.length != 0)){
                    ServiceAddPrizeAndMedal().postAddMedal(listMedal: mapMedal)
                        .then((value) {
                      if(value.statusCode == 201){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return MainScreen();
                            }));
                      }else{
                        setState(() {
                          uploadData = false;
                        });
                      }
                    });
                  }else{
                    setState(() {
                      uploadData = false;
                    });
                    BotToast.showText(
                      align: Alignment(0, 0.6),
                      text: "Make sure you enter data".tr(),
                      contentColor: Colors.blue,
                    );
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
