import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../baseUrlApi/baseUrlApi.dart';

class ServiceAddExtraProfile {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postAddExtraProfile({
     String sportId,
    @required     String roleId,
     String qualification,
     String contractEndDate,
    String contractStartDate,
    @required   String nationalityId,
    String workPlace,

    


  }) async {
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi. AddExtraProfile);

    FormData formData = new FormData.fromMap(
        {
          "sport_id":sportId,
          "role_id":roleId,
          "qualification":qualification,
          "contract_end_date":contractEndDate,
          "contract_start_date":contractStartDate,
          "nationality_id":nationalityId,
          "work_place":workPlace,
        });



    formData.fields.removeWhere((element) => element.value.length == 0);


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("AddExtraProfile " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("AddExtraProfile  error " + e.response.data.toString());
      return e.response;
    }
  }

  Future<Response> postUpdateExtraProfile({
    String sportId,
    @required     String roleId,
    String qualification,
    String contractEndDate,
    String contractStartDate,
    @required   String nationalityId,
    String workPlace,




  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi. UpdatePlayerExtra);

      FormData formData = new FormData.fromMap(
          {
            "sport_id":sportId,
            "role_id":roleId,
            "qualification":qualification,
            "contract_end_date":contractEndDate,
            "contract_start_date":contractStartDate,
            "nationality_id":nationalityId,
            "work_place":workPlace,
          });



      formData.fields.removeWhere((element) => element.value.length == 0);


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("AddExtraProfile " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("AddExtraProfile  error " + e.response.data.toString());
      return e.response;
    }
  }
}
