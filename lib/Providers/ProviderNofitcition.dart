import 'package:cv_sports/Model/NewsApi.dart';
import 'package:cv_sports/Model/NotificationApi.dart';
import 'package:cv_sports/Services/AllServices/ServiceNoftication.dart';
import 'package:cv_sports/Services/AllServices/serviceNews.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class ProviderNofitcition with ChangeNotifier{


NotificationApi ListNofitcition = NotificationApi();

  bool loading = false;
  int page = 0;

  Future<void> fetchNofitcition() async {
    page++;
    Response response = await ServiceNoftication().getNoftication(page: page);

    if (response.statusCode == 200) {
if(page ==1){
  ListNofitcition =NotificationApi.fromJson(response.data);
}else{
  response.data["notifications"].forEach((element) {
    ListNofitcition. notifications.add(NotificationOnly.fromJson(element));
  });
}


  //    print("ListNofitcition  = "+ ListNofitcition.length.toString());
    } else {
      ListNofitcition = NotificationApi();
    }
    notifyListeners();
  }


  getNofitcitionData() async {
    page = 0;

    ListNofitcition= NotificationApi();
    loading = true;
    await fetchNofitcition();
    loading = false;

    notifyListeners();
  }
}