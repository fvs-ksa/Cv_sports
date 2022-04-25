import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceSignGoogle {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postSignGoogle({
    @required String accessToken,
    @required String userName,
  }) async {
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.signGoogle);

    FormData formData = new FormData.fromMap({
      "name": userName,
      "access_token": accessToken,
    });


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

        BaseUrlApi.saveTokenUser = await SharedPreferences.getInstance();
        BaseUrlApi.saveTokenUser.setString("TokenUserLoad", response.data["token"]);
        BaseUrlApi.saveTokenUser.setInt("IdUserLoad", response.data["user"]["id"]);
        BaseUrlApi.tokenUser = BaseUrlApi.saveTokenUser.getString("TokenUserLoad");
        BaseUrlApi.idUser = BaseUrlApi.saveTokenUser.getInt("IdUserLoad");





      print("postSignUpEmailAndPassword " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postSignUpEmailAndPassword  error " + e.response.data.toString());
      return e.response;
    }
  }
}
