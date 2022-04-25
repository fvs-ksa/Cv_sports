//ServiceAboutUs

import 'dart:io';

import 'package:dio/dio.dart';

import '../../baseUrlApi/baseUrlApi.dart';

class ServiceAboutUs {
  //================ post Create Post ==================

  Future<Response> getAboutUs() async {

    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.AboutUs);


      Response response = await Dio().getUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));


      print("getAboutUs " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("getAboutUs  error " + e.response.data.toString());
      return e.response;
    }
  }


}
