import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceSignFacebook {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postSignFacebook({
    @required String accessToken,
    @required String facebook_id,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.signFacebook);

      FormData formData = new FormData.fromMap({
        "facebook_id": facebook_id,
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
