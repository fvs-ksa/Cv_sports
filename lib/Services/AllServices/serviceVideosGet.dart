import 'package:dio/dio.dart';


import '../baseUrlApi/baseUrlApi.dart';

class ServiceVideosGet {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> VideosGet() async {
    try {

    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.getVideos);


      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      print("getVideos " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("getVideos  error " + e.response.data.toString());
      return e.response;
    }
  }
}
