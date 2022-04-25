import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceAddSocial {
  //================ post Create Post ==================

  Future<Response> postAddSocial({
    @required   String facebook,
    @required   String twitter,
    @required   String snapchat,
    @required   String instagram,
  }) async {

    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.AddSocial);

      FormData formData = new FormData.fromMap({
        "facebook":  facebook,
        "twitter":  twitter,
        "snapchat":  snapchat,
        "instagram":  instagram,
      });
      formData.fields.removeWhere((element) => element.value.length == 0);

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));


      print("postAddSocial " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postAddSocial  error " + e.response.data.toString());
      return e.response;
    }
  }


}
