import 'package:dio/dio.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceUpdatePlayer {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postUpdatePlayer({
    String userName,
    String nationality_id,
    String player_role,
    String player_style,
    String height,
    String weight,
    String weight_unit,
    String contract_start_date,
    String contract_end_date,
    String cv,

  }) async {
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.UpdatePlayerProfile);

    FormData formData = new FormData.fromMap({
      "club_name": userName,
      "nationality_id": nationality_id,
      "player_role": player_role,
      "player_style": player_style,
      "height": height,
      "weight": weight,
      "weight_unit": weight_unit,
      "contract_start_date": contract_start_date,
      "contract_end_date": contract_end_date,
      "cv": cv,

    });
    formData.fields.removeWhere((element) => element.value.length == 0);

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postUpdatePlayer " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("postUpdatePlayer  error " + e.response.data.toString());
      return e.response;
    }
  }
}
