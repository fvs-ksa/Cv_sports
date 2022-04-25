import 'dart:io';

import 'package:dio/dio.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceInformationUserUpdate {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postInformationUserUpdate({
    String gender,
    String userName,
    String birthdate,
    String phone_one,
    String phone_two,
    int cityId,
     File image,
    int countryId,
  }) async {
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.InformationProfileUpdate);

    FormData formData = new FormData.fromMap({
      "name": userName,
      "gender": gender,
      "city_id": (cityId != null) ? cityId.toString() : null,
      "country_id": (countryId != null) ? countryId.toString() : null,
      "birthdate": birthdate,
      "phone_one": phone_one,
      "phone_two": phone_two,
      "image":     (image != null)  ?   await MultipartFile.fromFile(image.path):null,
    });
    formData.fields.removeWhere((element) => element.value.length == 0);

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("ServiceInformationUserUpdate " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("ServiceInformationUserUpdate  error " + e.response.data.toString());
      return e.response;
    }
  }
}
