//ServiceTermsAndConditions
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../baseUrlApi/baseUrlApi.dart';

class ServiceTermsAndConditions {
  //================ post Create Post ==================

  Future<Response> getTermsAndConditions() async {

    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.TermsAndConditions);


      Response response = await Dio().getUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));


      print("getTermsAndConditions " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("getTermsAndConditions  error " + e.response.data.toString());
      return e.response;
    }
  }


}