import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceNoftication {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> getNoftication({ @required int page,}) async {




    try {
      Map<String, String> paramars = {
        "page": page.toString(),
      };
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.AppNotifications,paramars);
      print("uri getNoftication " + uri.toString());
      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("getNoftication " + response.data.toString());

      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("getNoftication  error " + e.response.data.toString());
      return e.response;
    }
  }
}
