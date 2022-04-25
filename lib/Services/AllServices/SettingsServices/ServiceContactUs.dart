//ServiceContactUs
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../baseUrlApi/baseUrlApi.dart';

class ServiceContactUs {
  //================ post Create Post ==================

  Future<Response> postAddContactUs({
    @required   String name,
    @required   String email,
    @required   String message,

  }) async {

    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.ContactUs);

      FormData formData = new FormData.fromMap({
        "name":  name,
        "email":  email,
        "message":  message,

      });


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));


      print("postAddSocial " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postAddSocial  error " + e.response.data.toString());
      return e.response;
    }
  }


}
