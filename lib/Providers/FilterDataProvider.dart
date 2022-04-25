import 'package:cv_sports/Model/CountryApi.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Services/AllServices/ServiceFilterData.dart';

import 'package:cv_sports/Services/AllServices/serviceCountryGet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FilterDataProvider with ChangeNotifier {
  List<Users> listUsers = [];

  bool loading = false;
  int page = 0;

  Future<List<Users>> fetchFilterApi({
    String countryId,
    String city_id,
    String birthdate,
    String sport_id,
    String name,
  }) async {
    // clear old data

    page++;

    Response response = await ServiceFilterData().getFilterData(
        name: name,
        countryId: countryId,
        birthdate: birthdate,
        city_id: city_id,
        sport_id: sport_id,
        page: page);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listUsers.add(Users.fromJson(element));
      });

      print("listUsers = " + listUsers.length.toString());
      notifyListeners();
      return listUsers;
    } else {
      notifyListeners();
      return listUsers = [];
    }
  }



  Future<List<Users>> fetchFilterByName({
    String name,
  }) async {
    // clear old data

    listUsers = [];

    Response response = await ServiceFilterData().getFilterData(
      name: name,
    );
    listUsers = [];

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listUsers.add(Users.fromJson(element));
      });

      print("listUsers = " + listUsers.length.toString());
      notifyListeners();
      return listUsers;
    } else {
      notifyListeners();
      return listUsers = [];
    }
  }

  getFilterData({
    String countryId,
    String city_id,
    String birthdate,
    String sport_id,
    String name,
  }) async {
    page = 0;
    listUsers = [];
    loading = true;
    await fetchFilterApi(
      name: name,
      countryId: countryId,
      birthdate: birthdate,
      city_id: city_id,
      sport_id: sport_id,
    );
    loading = false;

    notifyListeners();
  }
}
