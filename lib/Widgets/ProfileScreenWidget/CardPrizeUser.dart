import 'package:cv_sports/Model/usersApi.dart';
import 'package:flutter/material.dart';

class CardPrizeUser extends StatelessWidget {
  Users informationProfile;

  bool isMedals;
  CardPrizeUser({@required  this.informationProfile , this.isMedals = true  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
        //     color: BackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [

            isMedals?
           informationProfile.medals.length !=0?
            Expanded(
              child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: informationProfile.medals.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return  Container(margin:EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.center,

                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.center ,
                            children: [
                              SizedBox(height: 10,),
                              Image.asset(
                                "assets/images/medal.png",

                               height: MediaQuery.of(context).size.height * 0.06,
                              ),
                              SizedBox(height: 5,),
                              Text(
                                informationProfile
                                              .medals[index].medal,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                      //      fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                              Text(informationProfile.medals[index].count.toString())
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ):Expanded(child: Center(child: Text("لا يوجد ميدليات حاليا"))):


            (informationProfile.prizes.length !=0?
            Expanded(
              child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: informationProfile.prizes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return  Container(margin:EdgeInsets.symmetric(horizontal: 5) ,
                        alignment: Alignment.center,
                      //  width: MediaQuery.of(context).size.width * .16,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.center ,
                            children: [
                              SizedBox(height: 10,),
                              Image.asset(
                                "assets/images/trophy.png",
                                //fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height * 0.06,
                              ),
                              SizedBox(height: 5,),
                              Text(

                                informationProfile
                                              .prizes[index].prize,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                              //              fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                              Text(informationProfile.prizes[index].count.toString())
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ):Expanded(child: Center(child: Text("لا يوجد جوائز حاليا")))),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                  color: Color(0xff2C2B53),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white)),
              //         height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width * 0.15,
              child:
              isMedals?
            Text(informationProfile.medals.length.toString(),style: TextStyle(color: Colors.white,fontSize: 18),):
              Text(informationProfile.prizes.length.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
            )
          ],
        ),
      ),
    );
  }
}
