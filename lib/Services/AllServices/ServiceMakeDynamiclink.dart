import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceMakeDynamiclink {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postMakeDynamiclink (
      {
  @required String dynamicLink
}

      ) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.MakeDynamiclink);

      FormData formData = new FormData.fromMap({

"dynamic_link" :dynamicLink

      });
      Response response = await Dio().postUri(uri,
data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postNotificationsSeen " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("postNotificationsSeen  error " + e.response.data.toString());
      return e.response;
    }
  }
}
