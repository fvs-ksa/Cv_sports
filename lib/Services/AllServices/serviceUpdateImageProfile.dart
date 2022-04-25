import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceUpdateImageProfile {




  Future<Response> uploadImageProfile({
    @required List media,
  }) async {
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.UpdateImageProfile);

    FormData formData = new FormData.fromMap({
      "media_id": media.map((e) => e.toString()).toList(),
    });


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("uploadImageProfile " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("uploadImageProfile  error " + e.response.data.toString());
      return e.response;
    }
  }

  Future<Response> DeleteImageProfile({
    @required int Idmedia,
  }) async {
    try {
      Uri uri = Uri.https(
          BaseUrlApi.baseUrl, "api/user/upload/image/$Idmedia/delete");

      Response response = await Dio().deleteUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("DeleteImageProfile " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("DeleteImageProfile  error " + e.response.data.toString());
      return e.response;
    }
  }
}
