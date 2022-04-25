import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceNews {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> getNews({
    @required int page,
  }) async {
    try {
      Map<String, String> paramars = {
        "page": page.toString(),
      };

      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.ShowAllNews, paramars);
      print(uri);
      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      print("getNews " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("getNews  error " + e.response.data.toString());
      return e.response;
    }
  }
}
