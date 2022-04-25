import 'package:cv_sports/Model/CountryApi.dart';
import 'package:cv_sports/Model/NationalityApi.dart';

import 'package:cv_sports/Services/AllServices/serviceCountryGet.dart';
import 'package:cv_sports/Services/AllServices/serviceNationalityGet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class NationalityProvider with ChangeNotifier{


  List<Nationality> listNationality = [];


  bool loading = false;




  Future<void> fetchNationalityApi() async {
    // clear old data
    listNationality = [];

    Response response = await ServiceNationalityGet().getNationality();

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listNationality.add(Nationality.fromJson(element));
      });


    } else {
      listNationality = [];
    }
    notifyListeners();
  }



  getNationalityData() async {

    listNationality = [];
    loading = true;
    await fetchNationalityApi( );
    loading = false;

    notifyListeners();
  }
}