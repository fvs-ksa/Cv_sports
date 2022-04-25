import 'package:dio/dio.dart';

import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';

class ServiceRolesSportGet {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> getRolesSports({int sportId}) async {
    Map<String, String> paramars = {
      "sport_id": (sportId != null) ? sportId.toString() : null,
    };

    paramars.removeWhere((key, value) => value == null);
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.RolesSportGet, paramars);


      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      print("getrolesSports " + response.data.toString());

      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("getRolesSports  error " + e.response.data.toString());
      return e.response;
    }
  }
}
