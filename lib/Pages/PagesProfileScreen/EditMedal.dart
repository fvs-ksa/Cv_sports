import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:cv_sports/Services/AllServices/serviceAddPrizeAndMedal.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bot_toast/bot_toast.dart';

class EditMedal extends StatefulWidget {
  @override
  _EditMedalState createState() => _EditMedalState();
}

class _EditMedalState extends State<EditMedal> {
  Users informationProfile;

  List<TextEditingController> nameMedal;

  List<int> quantityPrize;

  bool uploadData = false;
  @override
  void initState() {
    informationProfile =
        Provider.of<InformationMyProfileProvider>(context, listen: false)
            .listInformationUser;
    quantityPrize = List(informationProfile.medals.length);
    nameMedal = List(informationProfile.medals.length);
    print("namePrize " + nameMedal.length.toString());
    informationProfile.medals.asMap().forEach((index, value) {
      print("value = " + value.medal);
      nameMedal[index] = TextEditingController();
      nameMedal[index].text = value.medal;
      quantityPrize[index] = value.count;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Modification".tr(),
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: uploadData
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ))
            : Column(
          mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: informationProfile.medals.length,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade300)),
                                  child: TextField(
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: TextStyle(
                                  //    fontSize: ScreenUtil().setSp(18),
                                      color: Colors.black,
                                    ),
                                    controller: nameMedal[index],
                                    decoration: InputDecoration(
                                      counterText: "",
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                 //         fontSize: ScreenUtil().setSp(16)
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
                                    border:
                                        Border.all(color: Colors.grey.shade300)),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          quantityPrize[index]++;
                                        });
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(left: 15),
                                          height: 30,
                                          width: 30,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.blue,
                                            size: 20,
                                          )),
                                    ),
                                    Container(
                                      child: Text(quantityPrize[index] == null
                                          ? "0"
                                          : quantityPrize[index].toString()),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (quantityPrize[index] >= 1)
                                          setState(() {
                                            quantityPrize[index]--;
                                          });
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(right: 15),
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
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.swap_horizontal_circle_rounded,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    ServiceAddPrizeAndMedal().postUpdateMedal(
                                        idMedal:
                                            informationProfile.medals[index].id,
                                        body: nameMedal[index].text.trim(),
                                        count: quantityPrize[index].toString());
                                    informationProfile.medals[index].medal =
                                        nameMedal[index].text.trim();
                                    informationProfile.medals[index].count =
                                        quantityPrize[index];
                                    BotToast.showText(
                                      text: "Updated".tr(),
                                      contentColor: Colors.blue,
                                    );
                                  })
                            ],
                          ),
                        );
                      }),
                ],
              ),
      ),
    );
  }
}
