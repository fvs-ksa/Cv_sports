//AdvertismentsProvider
import 'package:cv_sports/Model/AdvertismentsApi.dart';
import 'package:cv_sports/Model/SportApi.dart';
import 'package:cv_sports/Services/AllServices/serviceAdvertisementsGet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class AdvertismentsProvider with ChangeNotifier{


  List<AdvertismentsApi> listAdvertisments = [];

  bool loading = false;


  Future<void> fetchAdvertisments()async{
    Response response = await ServiceAdvertisementsGet().getAdvertisements();

    if (response.statusCode == 200) {



      response.data.forEach((element) {

        listAdvertisments.add(AdvertismentsApi.fromJson(element));
      });



      print("listCategory  = "+ listAdvertisments.length.toString());
    } else {
      listAdvertisments = [];
    }
    notifyListeners();
  }


  getAdvertismentsData() async {
    listAdvertisments = [];
    loading = true;
    await fetchAdvertisments();
    loading = false;

    notifyListeners();
  }
}