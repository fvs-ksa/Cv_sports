import 'package:cv_sports/Model/SportApi.dart';
import 'package:cv_sports/Services/AllServices/serviceCategorySports.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class CategoryProvider with ChangeNotifier{


  List<SportApi> listCategory = [];

  bool loading = false;


  Future<void> fetchCategorySports()async{
    Response response = await ServiceCategorySports().getCategorySports();

    if (response.statusCode == 200) {



      response.data["sports"].forEach((element) {

       listCategory.add(SportApi.fromJson(element));
      });



     print("listCategory  = "+ listCategory.length.toString());
    } else {
      listCategory = [];
    }
    notifyListeners();
  }


  getCategoriesData() async {
    listCategory = [];
    loading = true;
    await fetchCategorySports();
    loading = false;

    notifyListeners();
  }
}