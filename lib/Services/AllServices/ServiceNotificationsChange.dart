import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceNotificationsChange {
  //================ post Create Post ==================

  Future<Response> postNotificationsChange() async {

    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.AppNotificationsChange);


      Response response = await Dio().postUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));


      print("postNotificationsChange " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postNotificationsChange  error " + e.response.data.toString());
      return e.response;
    }
  }


}
