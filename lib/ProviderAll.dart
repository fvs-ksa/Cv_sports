import 'package:flutter/material.dart';


class ProviderConstants with ChangeNotifier {
  int IndexTap = 0;

  int finishUpload = 0;


  int gallary =0;

  void getDataUpload({@required int start , @required int end }){
    print("start = "+start.toString()) ;
    finishUpload = ((start / end) *100).toInt();
       print("finishUpload = "+finishUpload.toString()) ;      //start / end
    notifyListeners();

  }


  void ChangeGallary({@required var Value}) {

    gallary = Value;
    notifyListeners();
  }

  void ChangeIndexTap({@required var Value}) {
    print("Eter ChangeIndexTap");
    IndexTap = Value;
    notifyListeners();
  }
}
