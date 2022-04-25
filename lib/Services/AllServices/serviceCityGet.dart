import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceCityGet {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> getCity({ String countryId}) async {

    Map<String, String> paramars = {
      "country_id": (countryId != null) ? countryId.toString() : null,
    };
    paramars.removeWhere((key, value) => value == null);
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.CityGet, paramars);


      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      print("getCity " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("getCity  error " + e.response.data.toString());
      return e.response;
    }
  }
}
