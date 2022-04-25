import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceAppleSign {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postAppleSign({
    @required String accessToken,
    @required String identityToken,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.signApple);

      FormData formData = new FormData.fromMap({
        "id_token": identityToken,

      });


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      BaseUrlApi.saveTokenUser = await SharedPreferences.getInstance();
      BaseUrlApi.saveTokenUser.setString("TokenUserLoad", response.data["token"]);
      BaseUrlApi.saveTokenUser.setInt("IdUserLoad", response.data["user"]["id"]);
      BaseUrlApi.tokenUser = BaseUrlApi.saveTokenUser.getString("TokenUserLoad");
      BaseUrlApi.idUser = BaseUrlApi.saveTokenUser.getInt("IdUserLoad");





      print("postAppleSign " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postAppleSign  error " + e.response.data.toString());
      return e.response;
    }
  }
}
