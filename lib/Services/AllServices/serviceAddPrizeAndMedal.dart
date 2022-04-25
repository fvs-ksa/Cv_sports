import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceAddPrizeAndMedal {
  //================ post Create Post ==================

  Future<Response> postAddPrize({
    @required List<Map> listPrize,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.AddPrize);

      FormData formData = new FormData.fromMap({
        "prizes": listPrize.toList(),

        // "prize":  namePrize[0],
        // "count":  quantityPrize[0],
      });

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postAddPrize " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postAddPrize  error " + e.response.data.toString());
      return e.response;
    }
  }

  Future<Response> postUpdatePrize(
      {@required int idPrize,
      @required String body,
      @required String count}) async {
    try {
      Uri uri =
          Uri.https(BaseUrlApi.baseUrl, "/api/user/update-prize/$idPrize");

      FormData formData = new FormData.fromMap({
        "prize": body,
        "count": count,
      });

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postUpdatePrize " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postUpdatePrize  error " + e.response.data.toString());
      return e.response;
    }
  }

  Future<Response> postAddMedal({
    @required List<Map> listMedal,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.AddMedal);

      FormData formData = new FormData.fromMap({
        "medals": listMedal.toList(),
      });

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postAddPrize " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postAddPrize  error " + e.response.data.toString());
      return e.response;
    }
  }

  Future<Response> postUpdateMedal(
      {@required int idMedal,
      @required String body,
      @required String count}) async {
    try {
      Uri uri =
          Uri.https(BaseUrlApi.baseUrl, "/api/user/update-medal/$idMedal");

      FormData formData = new FormData.fromMap({
        "medal": body,
        "count": count,
      });

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postUpdateMedal " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postUpdateMedal  error " + e.response.data.toString());
      return e.response;
    }
  }
}
