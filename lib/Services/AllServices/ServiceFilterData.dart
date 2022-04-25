import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceFilterData {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> getFilterData({
    String countryId,
    String city_id,
    String birthdate,
    String sport_id,
    String name,
    int page}) async {
    print("Enter Api2 ");


    Map<String, String> paramars = {
      "country_id": countryId ,
      "city_id": city_id ,
      "birthdate":  birthdate,
      "sport_id": sport_id ,
      "name":  name,
      "page": page.toString()
    };
    print("Enter Api");

    paramars.removeWhere((key, value) => value == null);

    print("Filter = " + paramars.toString());

    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.FilterData, paramars);

      print(uri);

      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      print("getFilterData " + response.data.toString());

      return response;
    } on DioError catch (e) {
      print("getFilterData  error " + e.response.data.toString());
      return e.response;
    }
  }
}
