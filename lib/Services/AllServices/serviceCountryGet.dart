import 'package:dio/dio.dart';


import '../baseUrlApi/baseUrlApi.dart';

class ServiceCountryGet {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> countryGet() async {

    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.CountryGet);


      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      print("countryGet " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("countryGet  error " + e.response.data.toString());
      return e.response;
    }
  }
}
