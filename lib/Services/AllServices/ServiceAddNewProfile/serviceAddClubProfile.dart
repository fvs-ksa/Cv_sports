import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../baseUrlApi/baseUrlApi.dart';

class ServiceAddClubProfile {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postAddClubProfile({
 @required   String nameClub,
    @required   String placeClub,
    @required   String creationDate,
    @required   String roleId,
    @required   File image,
     String phone


  }) async {
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi. AddClubProfile);

    FormData formData = new FormData.fromMap(
        {
         "name":nameClub,
          "place":placeClub,
          "creation_date":creationDate,
          "role_id":roleId,
          "image":await MultipartFile.fromFile(image.path),
          "phone":phone,

        });



    formData.fields.removeWhere((element) => element.value.length == 0);


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postAddClubProfile " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("postAddClubProfile  error " + e.response.data.toString());
      return e.response;
    }
  }

  Future<Response> postUpdateClubProfile({
      String nameClub,
      String placeClub,
      String creationDate,
    String roleId,
     File image,
    String phone


  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi. UpdateClubProfile);

      FormData formData = new FormData.fromMap(
          {
            "name":nameClub,
            "place":placeClub,
            "creation_date":creationDate,
            "role_id":roleId,
            "image":  image!=null ?await MultipartFile.fromFile(image.path):"",
            "phone":phone,

          });



      formData.fields.removeWhere((element) => element.value.length == 0);


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postUpdateClubProfile " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("postUpdateClubProfile  error " + e.response.data.toString());
      return e.response;
    }
  }
}
