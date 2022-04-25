import 'package:dio/dio.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceUpdateExtra {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postUpdateExtra({
    String work_place,
    String nationality_id,
    String qualification,
    String contract_start_date,
    String contract_end_date,
    String cv,

  }) async {
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.UpdatePlayerExtra);

    FormData formData = new FormData.fromMap({

      "nationality_id": nationality_id,
      "work_place": work_place,
      "qualification": qualification,
      "contract_start_date": contract_start_date,
      "contract_end_date": contract_end_date,
      "cv": cv,

    });
    formData.fields.removeWhere((element) => element.value.length == 0);

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postUpdateExtra " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("postUpdateExtra  error " + e.response.data.toString());
      return e.response;
    }
  }
}
