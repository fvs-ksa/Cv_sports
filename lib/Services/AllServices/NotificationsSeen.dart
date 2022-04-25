import 'package:dio/dio.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceNotificationsSeen {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postNotificationsSeen(


  ) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.AppNotificationsSeen);


      Response response = await Dio().postUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postNotificationsSeen " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("postNotificationsSeen  error " + e.response.data.toString());
      return e.response;
    }
  }
}
