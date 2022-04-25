
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:dio/dio.dart';


class ServiceCategorySports{
  //================ Post  sent  sign Up  Email ==================


  Future<Response> getCategorySports() async {
    try {
    Uri uri = Uri.https( BaseUrlApi.baseUrl, BaseUrlApi.CategorySportsGet);



      Response response = await Dio().getUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));


      print("getCategorySports " +response.data["sports"].toString());


      return response;
    } on DioError catch (e) {


      // NewUser.massageError = e.response.data.toString();
      print("getCategorySports  error " +e.response.data.toString());
      return e.response;
    }
  }
}


