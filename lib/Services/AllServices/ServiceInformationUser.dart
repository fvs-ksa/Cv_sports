//ServiceInformationUser
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceInformationUser {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> getInformationUser({
   @required int userId
  }) async {
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, "/api/user/find/$userId");


     print(uri);
    print( BaseUrlApi.tokenUser);
    Response response;
    if( BaseUrlApi.tokenUser ==null){
      response     = await Dio().getUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));
    }else{
       response = await Dio().getUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));
    }





      print("ServiceInformationUser " + response.data.toString());


    return response;
    } on DioError catch (e) {
      print("ServiceInformationUser  error " + e.response.data.toString());
      return e.response;
    }
  }
}
