//ServiceAppSocialLinks
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../baseUrlApi/baseUrlApi.dart';

class ServiceAppSocialLinks {
  //================ post Create Post ==================

  Future<Response> getAppSocialLinks() async {

    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.AppSocialLinks);


      Response response = await Dio().getUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));


      print("getAppSocialLinks " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("getAppSocialLinks  error " + e.response.data.toString());
      return e.response;
    }
  }


}