
import 'package:cv_sports/AuthFuntions/GoogleSignInProvider.dart';
import 'package:dio/dio.dart';

import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceInformationUserGet{
  //================ Post  sent  sign Up  Email ==================


  Future<Response> getInformationProfile() async {
    try {
    Uri uri = Uri.https( BaseUrlApi.baseUrl, BaseUrlApi.InformationProfileGet);

    SharedPreferences  saveTokenUser = await SharedPreferences.getInstance();

    BaseUrlApi.tokenUser = saveTokenUser.getString("TokenUserLoad");
    BaseUrlApi.idUser = saveTokenUser.getInt("IdUserLoad");
      Response response = await Dio().getUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));


      print("getInformationProfile get " +response.data.toString());
      return response;
    } on DioError catch (e) {


      // NewUser.massageError = e.response.data.toString();
      print("getInformationProfile  error " +e.response.data.toString());
      return e.response;
    }
  }
}


