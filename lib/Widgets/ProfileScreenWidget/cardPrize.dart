import 'package:flutter/material.dart';

class CardPrize extends StatelessWidget {
  int totalPrize;
  String imagePrize; //"assets/images/trophy.png"
  String namePrize;
  int numPrize;


  CardPrize({ @required this.totalPrize, @required  this.imagePrize,@required  this.namePrize,@required  this.numPrize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
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
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Expanded(

              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,

                  scrollDirection:Axis.horizontal ,
                  itemCount: 2,
                    itemBuilder: (context, index) {
                  return Container(
                    alignment:Alignment.center ,
                    width: MediaQuery.of(context).size.width * .3,
                    child: SingleChildScrollView(
                      child: Column(

                        children: [
                          Image.asset(
                            imagePrize,
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          SizedBox(height: 5,),
                          Text(
                              namePrize,

                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 5,),
                          Text(numPrize.toString())
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                  color: Color(0xffE7EBF8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white)),
              //         height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width * 0.15,
              child: Text(totalPrize.toString()),
            )
          ],
        ),
      ),
    );
  }
}
