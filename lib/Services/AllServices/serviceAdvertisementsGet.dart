
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceAdvertisementsGet{
  //================ Post  sent  sign Up  Email ==================


  Future<Response> getAdvertisements() async {


    SharedPreferences  saveTokenUser = await SharedPreferences.getInstance();
    BaseUrlApi.tokenUser = saveTokenUser.getString("TokenUserLoad");
    try {
    Uri uri = Uri.https( BaseUrlApi.baseUrl, BaseUrlApi.AdvertisementsGet);



      Response response = await Dio().getUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));


      print("getAdvertisements " +response.data.toString());
      return response;
    } on DioError catch (e) {


      // NewUser.massageError = e.response.data.toString();
      print("getAdvertisements  error " +e.response.data.toString());
      return e.response;
    }
  }
}


