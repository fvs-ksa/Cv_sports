import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Services/AllServices/serviceAddPrizeAndMedal.dart';
import 'package:cv_sports/Services/AllServices/serviceUpdatePlayer.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'EditPrizes.dart';

class AddPrize extends StatefulWidget {
  @override
  _AddPrizeState createState() => _AddPrizeState();
}

class _AddPrizeState extends State<AddPrize> {
  int quantity = 0;
  List<String> namePrize = List(4);
  List<int> quantityPrize = List(4);
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
              return EditPrizes();
            }));
          },
          child: const Icon(Icons.edit_rounded),
        ),
        backgroundColor: Color(0xffF9FAFF),
        appBar: AppBar(
          actions: [
            Container(
                margin: EdgeInsets.only(left: 20), child: Icon(Icons.add_circle)),
          ],
          elevation: 0,
          backgroundColor: Color(0xffF9FAFF),
          centerTitle: true,
          title: Text(
            "Adding or modifying prizes".tr(),
      //      style: TextStyle(fontSize: ScreenUtil().setSp(18)),
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
                    if(quantityPrize [index] ==null){
                      quantityPrize [index]= 0;
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
                         //         fontSize: ScreenUtil().setSp(18),
                                  color: Colors.black,
                                ),
                                onChanged: (v){
                                  namePrize[index] = v.trim();
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                 //     fontSize: ScreenUtil().setSp(16)
                                 ),
                                  hintText: "Name of the award ".tr(),
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
                                      quantityPrize [index] ++;
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
                                      quantityPrize [index]==null? "0"   :   quantityPrize [index].toString()),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (quantityPrize [index] >= 1)
                                      setState(() {
                                        quantityPrize [index]--;
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

                  //         List newNamePrize =[];
                  //          List<int> newQuantityPrize =[];

                  List<Map> mapPrize = [];

                  for(int i =0 ; i<namePrize.length ;i++){
                    if(quantityPrize[i] !=0 && namePrize[i] !=null) {
                      //       newNamePrize.add(namePrize[i]);
                      //   newQuantityPrize.add(quantityPrize[i]);
                      mapPrize.add({
                        "prize" : namePrize[i],
                        "count" : quantityPrize[i]
                      });
                    }
                  }
                  print(mapPrize .toString() + " = List");


                  if((mapPrize.length != 0)){
                    ServiceAddPrizeAndMedal().postAddPrize(listPrize: mapPrize)
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
                    for(int i =0 ; i<namePrize.length ;i++){
                      quantityPrize[i] =0;
                    }
                    setState(() {
                      uploadData = false;
                    });
                    BotToast.showText(
                      align: Alignment.topCenter,
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
