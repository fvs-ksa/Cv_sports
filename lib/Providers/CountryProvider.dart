import 'package:cv_sports/Model/CountryApi.dart';

import 'package:cv_sports/Services/AllServices/serviceCountryGet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class CountryProvider with ChangeNotifier{


  List<CountryApi> listCountry = [];
  int idCountry ;

  bool loading = false;

  setIdCountry({@required int id}){
    idCountry = id;
    notifyListeners();
  }


  Future<void> fetchCountryApi() async {
    // clear old data
    listCountry = [];

    Response response = await ServiceCountryGet().countryGet();

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listCountry.add(CountryApi.fromJson(element));
      });


    } else {
      listCountry = [];
    }
    notifyListeners();
  }



  getCountryData() async {

    listCountry = [];
    loading = true;
    await fetchCountryApi( );
    loading = false;

    notifyListeners();
  }
}