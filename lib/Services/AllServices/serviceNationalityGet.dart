import 'package:dio/dio.dart';


import '../baseUrlApi/baseUrlApi.dart';

class ServiceNationalityGet {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> getNationality() async {
    try {

    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.NationalityGet);


      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      print("getNationality " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("getNationality  error " + e.response.data.toString());
      return e.response;
    }
  }
}
