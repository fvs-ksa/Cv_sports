import 'package:dio/dio.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceUsersGet {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> getUsers({int page, int sportId, int roleId}) async {
    Map<String, String> paramars = {
      "limit": 30.toString(),
      "page": page.toString(),
      "sport_id": (sportId != null) ? sportId.toString() : null,
      "role_id": (roleId != null) ? roleId.toString() : null,
    };

    paramars.removeWhere((key, value) => value == null);

    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.UsersGet, paramars);
      print("uri getUsers " + uri.toString());
      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      print("getUsers " + response.data.toString());

      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("getUsers  error " + e.response.data.toString());
      return e.response;
    }
  }
}
